
class PlayListModel{

  String? title;
  String id;
  List<MixMusicModel>? playListList;

  PlayListModel({this.title,required this.id,this.playListList});

  factory PlayListModel.fromJson(Map<String,dynamic> json){
    return PlayListModel(
        id:json['id'],
        title: json['title'],
        playListList:List<MixMusicModel>.from(json["playListList"].map((x) => MixMusicModel.fromJson(x))),
    );
  }
  Map<String,dynamic> toJson() => {
    "id":id,
    "title":title,
    "playListList":List<dynamic>.from(playListList!.map((x) => x.toJson())),
  };
}

class MixMusicModel{

  String id;
  MusicModel? first;
  MusicModel? second;
  MixMusicModel({this.first,this.second,required this.id});

  factory MixMusicModel.fromJson(Map<String,dynamic> json){
    return MixMusicModel(
        id:json['id'] ,
        first: MusicModel.fromJson(json['first']),
        second: MusicModel.fromJson(json['second'])
    );
  }
  Map<String,dynamic> toJson() => {
    "id":id,
    "first":first,
    "second":second
  };
}
class MusicModel{
  final String musicName;
  final String musicFile;
  final String id;
  final String image;
  MusicModel({required this.musicName, required this.musicFile,required this.id,required this.image});

  factory MusicModel.fromJson(Map<String,dynamic> json){
    return MusicModel(
        musicName: json['musicName'],
        musicFile: json['musicFile'],
        id: json['id'],
        image: json['image']);
  }

  Map<String,dynamic> toJson() => {
    "musicName":musicName,
    "musicFile":musicFile,
    "id":id,
    "image":image
  };
}
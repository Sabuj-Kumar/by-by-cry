
class MixMusicModel{

  MusicModel first;
  MusicModel second;
  MixMusicModel({required this.first,required this.second});

  factory MixMusicModel.fromJson(Map<String,dynamic> json){
    return MixMusicModel(
        first: MusicModel.fromJson(json['first']),
        second: MusicModel.fromJson(json['second'])
    );
  }
  Map<String,dynamic> toJson() => {
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
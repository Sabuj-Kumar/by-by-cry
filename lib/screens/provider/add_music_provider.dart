import 'package:bye_bye_cry_new/local_db/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../compoment/utils/image_link.dart';
import '../models/music_models.dart';

final addProvider = ChangeNotifierProvider((ref) => AddMusicProvider());

class AddMusicProvider extends ChangeNotifier {
  List<String> nameList = [];
  List<String> playListIds = [];
  List<MusicModel> musicList = [];
  bool homePage = true;
  List<MusicModel> playList = [];
  int pageNumber = 0;
  bool showAddPlaylist = false;
  String musicId = "";
  bool changeToPlayNow = false;
  bool playFromPlayList = false;

  playFromPlaylistActive({bool change = false}){
    playFromPlayList = change;
    notifyListeners();
  }
  setMusicId({String normalMusicId = ''}){
    musicId = normalMusicId;
    notifyListeners();
  }
  changePlay({bool change = false}){
    changeToPlayNow = change;
    notifyListeners();
  }
  showPlusPlaylist({bool playlistPlusBottom = false,}){
    showAddPlaylist = playlistPlusBottom;
    notifyListeners();
  }
  addMusic(){

    musicList.add(MusicModel(musicName: 'Canon blended', musicFile: "babyCry/Canon_blended.wav", id: '1', image: chainsaw));
    musicList.add(MusicModel(musicName: "Chainsaw", musicFile: "babyCry/Chainsaw.wav", id: "2", image: vaccum));
    musicList.add(MusicModel(musicName: "Fanr", musicFile: "babyCry/Fanr3.wav", id: '3', image: jackhammer));
    musicList.add(MusicModel(musicName: "Hair Dryer", musicFile: "babyCry/Hair_Dryer.wav", id: "4", image: blowdryer));
    musicList.add(MusicModel(musicName: 'Jackhammer', musicFile: "babyCry/Jackhammer.wav", id: "5", image: lawnmower));
    musicList.add(MusicModel(musicName: "Lawn Mower", musicFile: "babyCry/Lawn_Mower.wav", id: "6", image: washer));
    musicList.add(MusicModel(musicName: 'Ocean', musicFile: "babyCry/Ocean.wav", id: '7', image: ocean));
    musicList.add(MusicModel(musicName: 'Rain', musicFile: "babyCry/Rain.wav", id: '8', image: dummy));
    musicList.add(MusicModel(musicName: "Sushing", musicFile: "babyCry/Sushing.wav", id: "9", image: dummy));
    musicList.add(MusicModel(musicName: "Vacuum", musicFile: "babyCry/Vacuum.wav", id: "10", image: dummy));

    print("music add ${musicList.length}");
    notifyListeners();
  }
  changeHomePage(){
    homePage = false;
    notifyListeners();
  }
  changePage(int pageNum){
    pageNumber = pageNum;
    notifyListeners();
  }
  assignAllPlaylist()async{
    playList = await LocalDB.getPlayListItem() ?? [];
    playListIds = [];
    for(int index = 0; index < playList.length;index++){
      playListIds.add(playList[index].id);
    }
    notifyListeners();
  }
  addOrRemovePlayList({required String id})async{
    if(musicList.isNotEmpty){
      int index = musicList.indexWhere((element) => element.id == id);
      if(!playListIds.contains(id)) {
        if(index >= 0) {
          playList.add(musicList[index]);
          playListIds.add(id);
          await LocalDB.setPlayListItem(playList);
          print('added');
        }
      }else {
        if(index >= 0) {
          playList.remove(musicList[index]);
          playListIds.remove(id);
          await LocalDB.setPlayListItem(playList);
          print('remove');
        }
      }
    }
    notifyListeners();
  }
}

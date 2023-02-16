
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../local_db/local_db.dart';
import '../models/music_models.dart';

final playlistProvider = ChangeNotifierProvider((ref) => PlaylistProvider());

class PlaylistProvider  extends ChangeNotifier{

  List<MixMusicModel> mixPlayList = [];
  MusicModel? musicModel;
  bool addInPlayListTrueFalse = false;
  bool goMixPlaylistScreen = false;
  int index = 0;
  bool firstOrSecond = true;
  List<PlayListModel> mixMixPlaylist = [];
  bool changeToMixPlayListNow = false;
  String musicId = '';

  setMixPlaylistMusicId({String setMixPlaylistId = ''}){
    musicId = setMixPlaylistId;
    notifyListeners();
  }
  changePlaying({bool change = false}){
    changeToMixPlayListNow = change;
    notifyListeners();
  }
  createMusic(){
    mixPlayList.add(MixMusicModel(id: ""));
    notifyListeners();
  }
  clearMixPlayList(){
    mixPlayList = [];
    notifyListeners();
  }
  showMixPlayList({required bool goMixPlaylist}){
    goMixPlaylistScreen = goMixPlaylist;
    notifyListeners();
  }
  addInPlaylistTrue(){
    addInPlayListTrueFalse = true;
    notifyListeners();
  }
  addInPlaylistFalse(){
    addInPlayListTrueFalse = false;
    notifyListeners();
  }
  assignMixPlayList()async{
    mixMixPlaylist = await LocalDB.getMixPlayList() ?? [];
    notifyListeners();
  }
  createMixMusicPlaylist({required String mixTitle})async{
    if(mixPlayList.isNotEmpty){
      String id = '';
      for(int index = 0; index < mixPlayList.length;index++){
        if(mixPlayList[index].first != null && mixPlayList[index].second != null){
          id += "${mixPlayList[index].first!.id}${mixPlayList[index].second!.id}";
        }
      }
      mixMixPlaylist.add(PlayListModel(id: id,title: mixTitle,playListList: mixPlayList));
      mixPlayList = [];
      await LocalDB.setMixPlayList(mixMixPlaylist);
    }
    notifyListeners();
  }
  setIndex({required int setIndex}){
    index = setIndex;
    notifyListeners();
  }
  setMusicFirstOrSecond({required bool setFirstOrSecondMusic}){
    firstOrSecond = setFirstOrSecondMusic;
    notifyListeners();
  }
  bool checkIds(int index){
    for(int idx = 0; idx < mixPlayList.length; idx++){
      if(idx != index){
        if(mixPlayList[idx].id == mixPlayList[index].id){
          return true;
        }else {
            String reverseId = mixPlayList[index].id.split('').reversed.join();

            if(mixPlayList[idx].id == reverseId){
                return true;
            }
        }
      }
    }
    return false;
  }
  setMusic({required MusicModel setMusicModel}){
    musicModel = setMusicModel;
    if(firstOrSecond){
      mixPlayList[index].first = musicModel;
    }else{
      mixPlayList[index].second = musicModel;
    }
    mixPlayList[index].id = "${mixPlayList[index].first?.id}${mixPlayList[index].second?.id}";
    bool check = checkIds(index);
    if(check){
      mixPlayList.removeAt(index);
    }
    notifyListeners();
  }
  clearPlaylist(){
    mixPlayList = [];
    notifyListeners();
  }
}
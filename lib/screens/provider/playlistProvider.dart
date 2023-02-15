
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/music_models.dart';

final playlistProvider = ChangeNotifierProvider((ref) => PlaylistProvider());

class PlaylistProvider  extends ChangeNotifier{

  List<MixMusicModel?> mixPlayList = [];
  MusicModel? musicModel;
  bool addInPlayListTrueFalse = false;
  bool goMixPlaylistScreen = false;
  int index = 0;
  bool firstOrSecond = true;
  bool playFromPlaylist = false;

  createMusic(){
    mixPlayList.add(MixMusicModel(id: ""));
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
  setIndex({required int setIndex}){
    index = setIndex;
    notifyListeners();
  }
  setMusicFirstOrSecond({required bool setFirstOrSecondMusic}){
    firstOrSecond = setFirstOrSecondMusic;
    notifyListeners();
  }
  setMusic({required MusicModel setMusicModel}){
    musicModel = setMusicModel;
    if(firstOrSecond){
      mixPlayList[index]?.first = musicModel;
    }else{
      mixPlayList[index]?.second = musicModel;
    }
    notifyListeners();
  }
  clearPlaylist(){
    mixPlayList = [];
    notifyListeners();
  }
  playFormPlaylistMethod({required bool playFromPlaylistOrNot}){
    playFromPlaylist = playFromPlaylistOrNot;
    notifyListeners();
  }
}
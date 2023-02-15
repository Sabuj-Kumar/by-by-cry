
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/music_models.dart';

final playlistProvider = ChangeNotifierProvider((ref) => PlaylistProvider());

class PlaylistProvider  extends ChangeNotifier{

  List<MixMusicModel> playList = [];
  bool addInPlayListTrueFalse = false;

  createMusic(){
    playList.add(MixMusicModel(id: ""));
    notifyListeners();
  }
  addInPlaylistTrue({required bool addPlayListTrue}){
    addInPlayListTrueFalse = addPlayListTrue;
    notifyListeners();
  }
  addInPlaylistFalse({required bool addPlayListFalse}){
    addInPlayListTrueFalse = addPlayListFalse;
    notifyListeners();
  }

}
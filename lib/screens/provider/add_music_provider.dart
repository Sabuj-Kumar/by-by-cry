import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../compoment/utils/image_link.dart';
import '../models/music_models.dart';

final addProvider = ChangeNotifierProvider((ref) => AddMusicProvider());

class AddMusicProvider extends ChangeNotifier {
  List<String> nameList = [];
  List<String> nameListTemp = [];
  List<MusicModel> musicList = [];
  bool homePage = true;
  addString(String name) {
    nameList.add(name);
    notifyListeners();
  }

  addMusic(){

    musicList.add(MusicModel(musicName: 'Canon blended', musicFile: "babyCry/Canon_blended.wav", id: 'Canon_blended', image: chainsaw));
    musicList.add(MusicModel(musicName: "Chainsaw", musicFile: "babyCry/Chainsaw.wav", id: "Chainsaw", image: vaccum));
    musicList.add(MusicModel(musicName: "Fanr", musicFile: "babyCry/Fanr3.wav", id: 'Fanr', image: jackhammer));
    musicList.add(MusicModel(musicName: "Hair Dryer", musicFile: "babyCry/Hair_Dryer.wav", id: "Hair_Dryer", image: blowdryer));
    musicList.add(MusicModel(musicName: 'Jackhammer', musicFile: "babyCry/Jackhammer.wav", id: 'Jackhammer', image: lawnmower));
    musicList.add(MusicModel(musicName: "Lawn Mower", musicFile: "babyCry/Lawn_Mower.wav", id: "Lawn_Mower", image: washer));
    musicList.add(MusicModel(musicName: 'Ocean', musicFile: "babyCry/Ocean.wav", id: 'Ocean', image: ocean));
    musicList.add(MusicModel(musicName: 'Rain', musicFile: "babyCry/Rain.wav", id: 'Rain', image: dummy));
    musicList.add(MusicModel(musicName: "Sushing", musicFile: "babyCry/Sushing.wav", id: "Sushing", image: dummy));
    musicList.add(MusicModel(musicName: "Vacuum", musicFile: "babyCry/Vacuum.wav", id: "Vacuum", image: dummy));

    notifyListeners();
  }
  initialisedNameList(List<String> nameList2) {
    nameList = List.from(nameList2);
    /*for(int index = 0; index < nameList2.length; index++){
      nameList.add(nameList2[index]);
    }*/
    notifyListeners();
  }
  changeHomePage(){
    homePage = false;
    notifyListeners();
  }
}

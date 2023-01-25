import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addProvider = ChangeNotifierProvider((ref) => AddMusicProvider());

class AddMusicProvider extends ChangeNotifier {
  List<String> nameList = [];
  List<String> nameListTemp = [];
  List<String> musicList = [];
  bool homePage = true;
  addString(String name) {
    nameList.add(name);
    notifyListeners();
  }

  addMusic(){

    musicList.add("babyCry/Canon blended loop single FINAL (1).wav");
    musicList.add("babyCry/Chainsaw r3.wav");
    musicList.add("babyCry/Fanr3.wav");
    musicList.add("babyCry/Hair Dryer r1c.wav");
    musicList.add("babyCry/Jackhammer r3.wav");
    musicList.add("babyCry/Lawn Mower r3.wav");
    musicList.add("babyCry/Ocean r3_Updated.wav");
    musicList.add("babyCry/Rain r1a_Updated.wav");
    musicList.add("babyCry/Sushing r4c.wav");
    musicList.add("babyCry/Vacuum Still r3.wav");

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

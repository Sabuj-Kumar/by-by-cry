import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addProvider = ChangeNotifierProvider((ref) => AddMusicProvider());

class AddMusicProvider extends ChangeNotifier {
  List<String> nameList = [];
  List<String> nameListTemp = [];
  bool homePage = true;
  addString(String name) {
    nameList.add(name);
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addProvider = ChangeNotifierProvider((ref) => AddMusicProvider());

class AddMusicProvider extends ChangeNotifier {
  List<String> nameList = [];

  addString(String name) {
    nameList.add(name);
    notifyListeners();
  }

  initialised(List<String> nameList2) {

    for(int index = 0; index < nameList2.length; index++){
      nameList.add(nameList2[index]);
    }

    notifyListeners();
  }
}

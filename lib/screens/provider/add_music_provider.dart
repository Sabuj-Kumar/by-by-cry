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
    nameList = nameList2;
    notifyListeners();
  }
}

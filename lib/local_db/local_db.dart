
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/models/music_models.dart';

class LocalDB{

  static setMixPlayListItem(List<MixMusicModel> mixMusicList)async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("mixPlayList")) { prefs.remove("mixPlayList");}
    prefs.setString("mixPlayList",jsonEncode(mixMusicList));
  }
  static Future<List<MixMusicModel>?>getMixPlayListItem()async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("mixPlayList")) {
      List<dynamic> jsonData = jsonDecode(prefs.getString("mixPlayList")??"[]");
      List<MixMusicModel> realData = jsonData.map((e) => MixMusicModel.fromJson(e)).toList();
      return realData;
    }
    return null;
  }

  static setPlayListItem(List<MusicModel> musicPlayList)async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("playList")) { prefs.remove("playList");}
    prefs.setString("playList",jsonEncode(musicPlayList.map((e) => e.toJson()).toList()));
  }
  static Future<List<MusicModel>?>getPlayListItem()async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("playList")) {
      List<dynamic> jsonData = jsonDecode(prefs.getString("playList")??"[]");
      List<MusicModel> realData = jsonData.map((e) => MusicModel.fromJson(e)).toList();
      return realData;
    }
    return null;
  }
}
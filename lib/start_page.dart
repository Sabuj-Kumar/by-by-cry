
import 'package:bye_bye_cry_new/screens/blog_screen.dart';
import 'package:bye_bye_cry_new/screens/botom_nev_bar/bootom_nav_bar.dart';
import 'package:bye_bye_cry_new/screens/home_screen.dart';
import 'package:bye_bye_cry_new/screens/mix_screen.dart';
import 'package:bye_bye_cry_new/screens/now_palying_screen.dart';
import 'package:bye_bye_cry_new/screens/playList_screen.dart';
import 'package:bye_bye_cry_new/screens/sound_edit_screen.dart';
import 'package:bye_bye_cry_new/screens/sound_screen.dart';
import 'package:flutter/material.dart';
class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var selectedIndex = 0;
  List<Widget> pageList = [];

  @override
  void initState() {
    initialized();
    super.initState();
  }

  initialized(){
      pageList = [
        const HomePage(),
        const SoundScreen(),
        MixScreen(onPressed: (){
          setState(() {
            selectedIndex = 1;
          });
          print("from mix $selectedIndex");
        },),
        const PlayListScreen(),
        const BlogScreen(),
      ];
      setState(() {});
    print("asche");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(
        onPressed: (index) {
          setState(() {
            selectedIndex = index;
            print('${selectedIndex}');
          });
        },
        index: selectedIndex,
      ),
      body: pageList.isEmpty?const SizedBox():pageList[selectedIndex],
    );
  }
}
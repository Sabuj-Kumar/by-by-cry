
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
  List<Widget> pageList = [

    const HomePage(),
    const SoundScreen(),
    const MixScreen(),
    const PlayListScreen(),
    const BlogScreen(),
  ];
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
      ),
      body: pageList[selectedIndex],
    );
  }
}
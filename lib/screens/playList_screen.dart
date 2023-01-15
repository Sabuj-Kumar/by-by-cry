import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_text.dart';
import 'package:flutter/material.dart';

import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_navigation.dart';
import '../compoment/shared/custom_svg.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';
import 'add_to_playlist.dart';
import 'now_palying_screen.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    final height = ScreenSize(context).height;

    List<String> textList = [
      'Witching Hour',
      'Goodbye CO',
      'Yard Work',
      'Beach Naps',
      'Grandma’s House',
    ];
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Playlist',
        actionTitle: 'Edit',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 10, bottom: 10),
              child: Container(
                height: 60,
                margin: const EdgeInsets.all(8),
                color: secondaryWhiteColor2,
                child: ListTile(
                  dense: true,
                  title: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: blackColorA0,fontSize: 14,fontWeight: FontWeight.w400),
                        hintText: 'Search music', border: InputBorder.none
                    ),
                    // onChanged: (text) {
                    //   if (text.length > 0) {
                    //     searching = true;
                    //     filtered.value = [];
                    //     users.forEach((user) {
                    //       if (user['name']
                    //           .toString()
                    //           .toLowerCase()
                    //           .contains(text.toLowerCase()) ||
                    //           user['tel'].toString().contains(text)) {
                    //         filtered.value.add(user);
                    //       }
                    //     });
                    //   } else {
                    //     searching = false;
                    //     filtered.value = [];
                    //   }
                    // },
                  ),
                  trailing: GestureDetector(onTap:(){},child: const CustomSvg(svg: "asset/images/search_icon.svg",)),
                ),
              ),
            ),
            Column(
              children: List.generate(
                textList.length,
                (index) => musicList(musicName: textList[index]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: height * .07,
              color: pinkLightColor,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: height * .05,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddToPlayListPage()));
                      },
                      child: const CustomText(
                        text: 'Add Playlist',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: blackColor2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget musicList({required String musicName}) {
    final height = ScreenSize(context).height;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5, bottom: 5),
      child: Row(
        //  crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: height * .07,
                width: height * .07,
                decoration: const BoxDecoration(
                    color: primaryPinkColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              const SizedBox(
                width: 20,
              ),
              CustomText(
                text: musicName,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigation.navigatePages(context, const NowPlayingScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.1)
              ),
              child: const Padding(
                padding: EdgeInsets.all(1.0),
                child: CustomImage(
                  imageUrl: playButton,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_text.dart';
import 'package:flutter/material.dart';

import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';

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
        title: 'My Sounds',
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
                        hintText: 'Search music', border: InputBorder.none),
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
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    onPressed: () {
                      // searchController.clear();
                      // searching = false;
                      // filtered.value = [];
                      // if (searchFocus.hasFocus) searchFocus.unfocus();
                    },
                  ),
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
              color: primaryPinkColor,
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
                    const CustomText(
                      text: 'Add Playlist',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
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
          const CustomImage(imageUrl: 'asset/images/icon_png/playlist.png',
          height: 30,
            width: 30,
          ),
        ],
      ),
    );
  }
}

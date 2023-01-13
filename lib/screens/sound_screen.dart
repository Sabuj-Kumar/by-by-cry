import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_text.dart';
import 'package:bye_bye_cry_new/screens/sound_edit_screen.dart';
import 'package:flutter/material.dart';

import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_navigation.dart';
import '../compoment/utils/color_utils.dart';
import 'now_palying_screen.dart';

class SoundScreen extends StatelessWidget {
  const SoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List<String> imageUrl = [
      'asset/images/sounds_image/Chainsaw.png',
      'asset/images/sounds_image/Vaccum.png',
      'asset/images/sounds_image/Jackhammer.png',
      'asset/images/sounds_image/Blowdryer.png',
      'asset/images/sounds_image/Lawnmower.png',
      'asset/images/sounds_image/Washer.png',
      'asset/images/sounds_image/Ocean.png',
      'asset/images/sounds_image/dummy.png',
      'asset/images/sounds_image/dummy2.png',
    ];
    List<String> textUrl = [
      'Chainshaw',
      'Vaccum',
      'Jackhammer',
      'Blowdryer',
      'Lawnmower',
      'Washer',
      'Ocean',
      'Ocean + Rain',
      'Lawnmower + Ocean',
      'Mix Two Sounds'
    ];
    return Scaffold(
        appBar: CustomAppBar(
            title: 'My Sounds',
            actionTitle: 'Edit',
            onPressed: () {
              Navigation.navigatePages(context, const SoundEditScreen());
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //     height: 200, width: 400, child: searchableUsersWidget()),
                Container(
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
                Column(
                    children: List.generate(
                  imageUrl.length,
                  (index) => imageList(
                    context: context,
                      imageLink: imageUrl[index], textLink: textUrl[index]),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: primaryPinkColor,
                      ),
                      child: const CustomImage(
                        imageUrl: 'asset/images/icon_png/plus.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustomText(
                      text: 'Mix Two Sounds',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget imageList({required String imageLink, required String textLink,required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomImage(imageUrl: imageLink),
            const SizedBox(
              width: 10,
            ),
            CustomText(text: textLink),
          ],
        ),
        InkWell(
          onTap: (){
            Navigation.navigatePages(context,  const NowPlayingScreen(),);
          },
          child: const CustomImage(
            imageUrl: 'asset/images/icon_png/playlist.png',
            height: 30,
            width: 30,
          ),
        ),
      ],
    );
  }
}

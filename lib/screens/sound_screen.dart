import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_svg.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_text.dart';
import 'package:bye_bye_cry_new/screens/provider/add_music_provider.dart';
import 'package:bye_bye_cry_new/screens/sound_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_navigation.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';
import 'models/music_models.dart';
import 'now_palying_screen.dart';

class SoundScreen extends ConsumerStatefulWidget {
  const SoundScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends ConsumerState<SoundScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List<String> imageUrl = [
      chainsaw,
      vaccum,
      jackhammer,
      blowdryer,
      lawnmower,
      washer,
      ocean,
      dummy,
      dummy,
      dummy,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //     height: 200, width: 400, child: searchableUsersWidget()),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
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
                ref.watch(addProvider).musicList.isNotEmpty?10:ref.watch(addProvider).musicList.length,
                (index) => Column(
                  children: [
                    Container(
                      color: index % 2 == 0?Colors.transparent:pinkLightColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: imageList(
                          context: context,musicModel: ref.watch(addProvider).musicList[index]),
                      ),
                    ),// const SizedBox(height: 5,)
                  ],
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                     // height: 50,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: primaryPinkColor,
                      ),
                      child: const CustomImage(
                        boxFit: BoxFit.fill,
                        imageUrl: whitePlus,
                        scale: 1,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustomText(
                      text: 'Mix Two Sounds',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: blackColor50,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15,)
            ],
          ),
        ));
  }

  Widget imageList({required MusicModel musicModel,required BuildContext context,}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: CustomImage(imageUrl: musicModel.image),
            ),
            const SizedBox(
              width: 10,
            ),
            CustomText(text: musicModel.musicName,color: blackColor50,fontWeight: FontWeight.w600,fontSize: 20,),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: (){
              Navigation.navigatePages(context, NowPlayingScreen(musicModel: musicModel));
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
        ),
      ],
    );
  }
}

import 'package:bye_bye_cry_new/screens/provider/add_music_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_image.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';

class SoundEditScreen extends ConsumerStatefulWidget {
  const SoundEditScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SoundEditScreen> createState() => _SoundEditScreenState();
}

class _SoundEditScreenState extends ConsumerState<SoundEditScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> imageUrl = [
    'asset/images/sounds_image/Chainsaw.png',
    'asset/images/sounds_image/Vaccum.png',
    'asset/images/sounds_image/Jackhammer.png',
    'asset/images/sounds_image/Blowdryer.png',
    'asset/images/sounds_image/Lawnmower.png',
    'asset/images/sounds_image/Washer.png',
    'asset/images/sounds_image/Ocean.png',
  ];
  List<String> textUrl = [
    'Chainshaw',
    'Vaccum',
    'Jackhammer',
    'Blowdryer',
    'Lawnmower',
    'Washer',
    'Ocean',
  ];

  List<String> dummyImage = [
    'asset/images/sounds_image/dummy.png',
    'asset/images/sounds_image/dummy2.png',
  ];

  List<String> mixedSong = [
    'Ocean + Rain',
    'Lawnmower + Ocean',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilized();
  }

  initilized() {
    if (mounted) {
      WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
        ref.read(addProvider).initialised(textUrl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Edit My Sounds',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                ref.watch(addProvider).nameList.length,
                (index) => imageList(
                    imageLink: imageUrl[index],
                    textLink: ref.watch(addProvider).nameList[index],
                    context: context),
              )),
              const SizedBox(
                height: 10,
              ),
              Column(
                  children: List.generate(
                mixedSong.length,
                (index) => imageList(
                    imageLink: dummyImage[index],
                    textLink: mixedSong[index],
                    alart: true,
                    context: context),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageList(
      {required String imageLink,
      required String textLink,
      bool alart = false,
      required BuildContext context}) {
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
        alart
            ? InkWell(
                onTap: () {
                  _showDialog(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        scale: 2,
                        image: AssetImage(
                          'asset/images/icon_png/delete.png',
                        ),
                      ),
                      shape: BoxShape.circle,
                      color: secondaryAwashColor),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    final height = ScreenSize(context).height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              AlertDialog(
                title: const CustomText(
                  text: 'You have removed',
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CustomText(
                      text: 'Lawnmower + Ocean',
                      fontSize: 18,
                      color: primaryGreyColor,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'from sound list',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
                actions: <Widget>[
                  OutLineButton(
                    height: height * .05,
                    width: height * .08,
                    text: 'Ok',
                    textColor: secondaryBlackColor2,
                    textFontSize: 20,
                    textFontWeight: FontWeight.w600,
                    borderRadius: 50,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

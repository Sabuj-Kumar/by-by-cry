import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:flutter/material.dart';

import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

int _value = 1;

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  @override
  Widget build(BuildContext context) {
    final height = ScreenSize(context).height;
    final width = ScreenSize(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Now Playing',
        iconButton: true,
        onPressedButton: null,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: width * .07),
                child: const CustomImage(
                  imageUrl: 'asset/images/icon_png/now_playing_icon/Sun.png',
                ),
              ),
            ],
          ),
          CustomImage(
            imageUrl: 'asset/images/chainsaw_now_playing.png',
            height: width * .8,
            width: width * .8,
            boxFit: BoxFit.cover,
          ),
          const CustomText(
            text: 'Chainsaw',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: secondaryBlackColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    CustomImage(imageUrl: 'asset/images/icon_png/love.png'),
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      text: 'Add To Playlist',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    CustomImage(
                        imageUrl: 'asset/images/icon_png/another_sound.png'),
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      text: 'Mix Another\n Sound ',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * .05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomText(
                  text: '2:50',
                  fontSize: 10,
                  color: blackColor2,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: '1:30',
                  fontSize: 10,
                  color: blackColor2,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          SizedBox(
            //color: Colors.green,
            width: width * .95,
            child: SliderTheme(
              data: const SliderThemeData(
                  trackShape: RectangularSliderTrackShape(),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
              child: Slider(
                  value: _value.toDouble(),
                  min: 1.0,
                  max: 20.0,
                  divisions: 100,
                  activeColor: primaryPinkColor,
                  inactiveColor: primaryGreyColor2,
                  onChanged: (double newValue) {
                    setState(() {
                      _value = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  }),
            ),
          ),
          Container(
            color: Colors.green,
            //height: width * 0.3,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  const CustomImage(
                    imageUrl:
                        'asset/images/icon_png/now_playing_icon/sound.png',
                  ),
                  const CustomImage(
                    imageUrl:
                        'asset/images/icon_png/now_playing_icon/left_shift.png',
                  ),
                  Container(
                    color: Colors.red,
                    height: width * 0.2,
                    width: width * 0.2,
                    child: const CustomImage(
                      //color: Colors.blue,
                      boxFit: BoxFit.fill,
                      imageUrl:
                          'asset/images/icon_png/now_playing_icon/pause.png',
                    ),
                  ),
                  const CustomImage(
                    imageUrl:
                        'asset/images/icon_png/now_playing_icon/right_shft.png',
                  ),
                  const CustomImage(
                    imageUrl: 'asset/images/icon_png/now_playing_icon/time.png',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

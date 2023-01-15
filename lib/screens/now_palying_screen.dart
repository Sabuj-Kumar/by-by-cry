import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_svg.dart';
import 'package:flutter/material.dart';

import '../compoment/bottom_sheet.dart';
import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';

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
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){
              CustomBottomSheet.bottomSheet(context, child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) updateState) {
                return bottomSheet(context);
              },));
            },
            child: const CustomText(
              text: 'Chainsaw',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: secondaryBlackColor,
            ),
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
            color: Colors.transparent,
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
                   // color: Colors.red,
                    height: width * 0.14,
                    width: width * 0.14,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: secondaryWhiteColor2,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.transparent,width:0),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color:secondaryWhiteColor2
                        )
                      ]
                    ),
                    child: const Padding(
                      padding:  EdgeInsets.all(17),
                      child:  CustomSvg(
                        //color: Colors.blue,
                        svg:pouseButton,
                      ),
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

  Widget bottomSheet(BuildContext context){
    final width = ScreenSize(context).width;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Wrap(
        children: [
          Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryPinkColor
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(1.0),
                              child: CustomImage(
                                imageUrl: playButton,
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                CustomText(text: "Witching Hour",fontWeight: FontWeight.w600,fontSize: 20,color: blackColor50),
                                SizedBox(height: 5),
                                CustomText(text: "chainsaw + Ocean is playing",fontWeight: FontWeight.w400,fontSize: 14,color: blackColor50)
                              ],
                            ),
                          )
                        ],
                      ),
                      const CustomSvg(svg: arrow_foreword),
                    ],
                  ),
                ),
                Container(height: 2, color: blackColorD9),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(3, (index) => Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Sound Set ${index+1}",fontSize: 16,fontWeight: FontWeight.w600,color: blackColor50),
                            SizedBox(height: width * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width * 0.35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: width * 0.1,
                                                    width: width * 0.1,
                                                    child: const CustomImage(imageUrl: "asset/images/chainshaw.png",boxFit: BoxFit.fill,)),
                                                const Padding(
                                                  padding:  EdgeInsets.all(10.0),
                                                  child: CustomText(text: "Chainsaw",fontSize: 16,fontWeight: FontWeight.w600,color: blackColor50),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: const [
                                              CustomSvg(svg: volume),
                                              Padding(
                                                padding:  EdgeInsets.all(10.0),
                                                child: CustomText(text: "20%",fontSize: 16,fontWeight: FontWeight.w600,color: blackColor50),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: width * 0.03),
                                    Container(
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                           width: width * 0.35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: width * 0.1,
                                                    width: width * 0.1,
                                                    child: const CustomImage(imageUrl: "asset/images/chainshaw.png",boxFit: BoxFit.fill)),
                                                const Padding(
                                                  padding:  EdgeInsets.all(10.0),
                                                  child: CustomText(text: "Ocean",fontSize: 16,fontWeight: FontWeight.w600,color: blackColor50),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: const [
                                              CustomSvg(svg: volume),
                                              Padding(
                                                padding:  EdgeInsets.all(10.0),
                                                child: CustomText(text: "60%",fontSize: 16,fontWeight: FontWeight.w600,color: blackColor50),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    //CustomImage(imageUrl: "asset/images/chainsaw_now_playing.png")
                                  ],
                                ),
                                Row(
                                  children: const [
                                    CustomSvg(svg: timer),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: CustomText(text: "8 min",fontWeight: FontWeight.w600,fontSize: 12,color: primaryGreyColor,),
                                    )
                                  ],
                                ),
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.1)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: index % 2 == 0?const CustomImage(
                                      imageUrl: playButton,
                                      height: 30,
                                      width: 30,
                                      color: blackColor97,
                                    ): const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: CustomSvg(svg: pouseButton,height: 15,
                                        width: 15,
                                        color: blackColor97,),
                                    )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20)
                          ],
                        ),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

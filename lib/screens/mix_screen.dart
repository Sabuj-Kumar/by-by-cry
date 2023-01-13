import 'package:bye_bye_cry_new/compoment/font_class.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:flutter/material.dart';

import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class MixScreen extends StatefulWidget {
  const MixScreen({Key? key}) : super(key: key);

  @override
  State<MixScreen> createState() => _MixScreenState();
}

class _MixScreenState extends State<MixScreen> {
  double currentvol = 1;
  double currentvol2 = 1;

  @override
  void initState() {
    PerfectVolumeControl.hideUI = false;
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
      currentvol2 = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
    });

    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentvol = volume;
      });
    });
    PerfectVolumeControl.stream.listen((volume2) {
      setState(() {
        currentvol2 = volume2;
      });
    });
    super.initState();
  }

  int _value = 1;
  int _value2 = 1;

  @override
  Widget build(BuildContext context) {
    final width = ScreenSize(context).width;
    final height = ScreenSize(context).height;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Mix',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: height * .03,
          ),
          const CustomText(
            text: 'Create Your Own Sound',
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: height * .03,
          ),

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomImage(
                    imageUrl: 'asset/images/chainsaw_mix_new.png',
                    height: width * .4,
                    width: width * .4,
                    boxFit: BoxFit.cover,
                  ),
                  Icon(
                    Icons.add,
                    size: height * .05,
                    color: primaryPinkColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      height: width * .4,
                      width: width * .4,
                      decoration: const BoxDecoration(
                          color: primaryPinkColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const CustomImage(
                          imageUrl: 'asset/images/icon_png/music.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CustomText(
                    text: 'Chainsaw',
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(),
                  CustomText(
                    text: 'Add a sound',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * .45,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomText(
                          text: 'Set sound ${_value} volume',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * .45,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Slider(
                              value: _value2.toDouble(),
                              min: 1.0,
                              max: 20.0,
                              divisions: 100,
                              activeColor: primaryPinkColor,
                              inactiveColor: primaryGreyColor2,
                              onChanged: (double newValue) {
                                setState(() {
                                  _value2 = newValue.round();
                                });
                              },
                              semanticFormatterCallback: (double newValue) {
                                return '${newValue.round()} dollars';
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomText(
                          text: 'Set sound ${_value2} volume',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          CustomImage(
            imageUrl: 'asset/images/icon_png/play_button.png',
            height: height * .2,
            width: height * .2,
          ),
          OutLineButton(
            height: height * .09,
            text: 'Save To My Sounds ',
            textColor: secondaryBlackColor2,
            textFontSize: 22,
            textFontWeight: FontWeight.w600,
            borderRadius: 50,
            onPressed: () {},
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}


import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:flutter/material.dart';
import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class MixScreen extends StatefulWidget {
  final VoidCallback? onPressed;
  const MixScreen({Key? key,this.onPressed}) : super(key: key);

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomImage(
                      imageUrl: 'asset/images/chainsaw_mix_new.png',
                      height: width * .35,
                      width: width * .35,
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
                        height: width * .35,
                        width: width * .35,
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
                  children: [
                    const CustomText(
                      text: 'Chainsaw',
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: primaryGreyColor,
                    ),
                    const SizedBox(),
                    GestureDetector(
                      onTap:widget.onPressed,
                      child: Container(
                        color: Colors.transparent,
                        child: const CustomText(
                          text: 'Add a sound',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: primaryGreyColor,
                        ),
                      ),
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
          ),
          CustomImage(
            imageUrl: 'asset/images/icon_png/play_button.png',
            height: height * .12,
            width: height * .12,
          ),
          OutLineButton(
            height: height * .06,
            text: 'Save To My Sounds ',
            textColor: secondaryBlackColor,
            textFontSize: 22,
            textFontWeight: FontWeight.w600,
            borderRadius: 50,
            onPressed: () {
              _showDialog(context);
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                backgroundColor: secondaryPinkColor,
                title: const CustomText(
                  text: 'Name Your Sound',
                  textAlign: TextAlign.center,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: secondaryBlackColor,
                ),
                content: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 20),
                        child: CustomText(
                          text: 'Lawnmower + Ocean',
                          fontSize: 18,
                          color: primaryGreyColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actionsPadding: const EdgeInsets.only(bottom: 10),
                actions: <Widget>[
                  OutLineButton(
                    height: height * .06,
                    width: height * .25,
                    text: 'Save',
                    textColor: secondaryBlackColor2,
                    textFontSize: 20,
                    textFontWeight: FontWeight.w600,
                    borderRadius: 48,
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


import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_image.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';

class AddToPlayListPage extends StatefulWidget {
  const AddToPlayListPage({Key? key}) : super(key: key);

  @override
  State<AddToPlayListPage> createState() => _AddToPlayListPageState();
}

class _AddToPlayListPageState extends State<AddToPlayListPage> {
  double currentvol = 1;
  double currentvol2 = 1;
  @override
  void initState() {
    /*PerfectVolumeControl.hideUI = false;
    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
     // currentvol2 = await PerfectVolumeControl.getVolume();
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
        //currentvol2 = volume2;
      });
    });*/
    super.initState();
  }
  int _value = 1;
  int _value2 = 1;
  @override
  Widget build(BuildContext context) {
    final width = ScreenSize(context).width;
    final height = ScreenSize(context).height;

    return Scaffold(
      appBar: const CustomAppBar(title: 'My Playlist',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: List.generate(3, (index) =>Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomText(text: "Sound Set ${index+1}",fontWeight: FontWeight.w600,fontSize: 20,color: primaryGreyColor),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const  CustomText(text: "Chainsaw",fontSize: 20,fontWeight: FontWeight.w600,color: blackColor77,),
                            CustomImage(
                              imageUrl: 'asset/images/chainsaw_mix_new.png',
                              height: width * .35,
                              width: width * .35,
                              boxFit: BoxFit.cover,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.add,
                          size: height * .05,
                          color: primaryPinkColor,
                        ),
                        Column(
                          children: [
                            const CustomText(text: "Ocean",fontSize: 20,fontWeight: FontWeight.w600,color: blackColor77),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0,top: 10),
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
              ),),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    color: primaryGreyColor,
                  ),
                  CustomText(text: "Add another Sound Set",fontSize: 16,fontWeight: FontWeight.w600,color: primaryGreyColor),
                ],
              ),
            ),
            const SizedBox(height: 40),
            OutLineButton(
              height: height * .06,
              text: 'Save To My Playlist',
              textColor: secondaryBlackColor,
              textFontSize: 22,
              textFontWeight: FontWeight.w600,
              borderRadius: 50,
              onPressed: () {
                Navigator.pop(context);
                //_showDialog(context);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

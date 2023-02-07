
import 'package:bye_bye_cry_new/screens/provider/mix_music_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_image.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';

class AddToPlayListPage extends ConsumerStatefulWidget {
  const AddToPlayListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddToPlayListPage> createState() => _AddToPlayListPageState();
}

class _AddToPlayListPageState extends ConsumerState<AddToPlayListPage> {
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
              children: List.generate(ref.watch(mixMusicProvider).mixPlaylist.length, (index) =>Padding(
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
                            CustomText(text: "${ref.watch(mixMusicProvider).mixPlaylist[index].first?.musicName}",fontSize: 20,fontWeight: FontWeight.w600,color: blackColor77,),
                            CustomImage(
                                height: width * .35,
                                width: width * .35,
                                boxFit: BoxFit.cover,
                                imageUrl: "${ref.watch(mixMusicProvider).mixPlaylist[index].second?.image}"),
                          ],
                        ),
                        Icon(
                          Icons.add,
                          size: height * .05,
                          color: primaryPinkColor,
                        ),
                        Column(
                          children: [
                            CustomText(text: "${ref.watch(mixMusicProvider).mixPlaylist[index].second?.musicName}",fontSize: 20,fontWeight: FontWeight.w600,color: blackColor77,),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0,top: 10),
                              child: Container(
                                height: width * .35,
                                width: width * .35,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                                child: CustomImage(
                                    boxFit: BoxFit.fill,
                                    imageUrl: "${ref.watch(mixMusicProvider).mixPlaylist[index].second?.image}"),
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
                                  value: 5,
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
                            const Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 15.0),
                              child: CustomText(
                                text: 'Set sound 5 volume',
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
                                    value:5,
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
                            const Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 15.0),
                              child: CustomText(
                                text: 'Set sound 5 volume',
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
            ref.watch(mixMusicProvider).mixPlaylist.length <=3?GestureDetector(
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
            ):const SizedBox(),
            const SizedBox(height: 40),
            OutLineButton(
              height: height * .06,
              text: 'Save To My Playlist',
              textColor: secondaryBlackColor,
              textFontSize: 22,
              textFontWeight: FontWeight.w600,
              borderRadius: 50,
              onPressed: () {
               // Navigator.pop(context);
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


import 'package:bye_bye_cry_new/screens/provider/add_music_provider.dart';
import 'package:bye_bye_cry_new/screens/provider/mix_music_provider.dart';
import 'package:bye_bye_cry_new/screens/provider/playlistProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_image.dart';
import '../compoment/shared/custom_svg.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';

class AddToPlayListPage extends ConsumerStatefulWidget {
  final VoidCallback? onPressed;
  const AddToPlayListPage({Key? key,this.onPressed}) : super(key: key);

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
      appBar: CustomAppBar(title: 'My Playlist',onPressed: widget.onPressed),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: List.generate(ref.watch(playlistProvider).playList.length, (index) =>Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomText(text: "Sound Set ${index+1}",fontWeight: FontWeight.w600,fontSize: 20,color: primaryGreyColor),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    ref.read(addProvider).showPlusPlaylist(playlistPlusBottom:true);
                                    ref.read(addProvider).changePage(1);
                                    ref.read(mixMusicProvider).selectedMixSound(selectSound: true);
                                  },
                                  child: Column(
                                    children: [
                                      ref.watch(playlistProvider).playList[index].first == null?Container(
                                        height: width * .3,
                                        width: width * .3,
                                        decoration: BoxDecoration(
                                            color: secondaryPickColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(25.0),
                                          child: CustomSvg(
                                            svg: musicJust,
                                          ),
                                        ),
                                      ):CustomImage(
                                        imageUrl: "${ref.watch(playlistProvider).playList[index].first?.image}",
                                        height: width * .35,
                                        width: width * .35,
                                        boxFit: BoxFit.cover,
                                      ),
                                      SizedBox(height: width * 0.04),
                                      Center(
                                        child: CustomText(
                                          text: ref.watch(playlistProvider).playList[index].first?.musicName ?? "Add a Sound",
                                          textAlign: TextAlign.center,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: primaryGreyColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  size: height * .05,
                                  color: primaryPinkColor,
                                ),
                                GestureDetector(
                                  onTap:(){
                                    ref.read(addProvider).showPlusPlaylist(playlistPlusBottom:true,);
                                    ref.read(addProvider).changePage(1);
                                    ref.read(mixMusicProvider).selectedMixSound(selectSound: false);
                                  },
                                  child: Column(
                                    children: [
                                      ref.watch(playlistProvider).playList[index].second  == null?Container(
                                        height: width * .3,
                                        width: width * .3,
                                        decoration: BoxDecoration(
                                            color: secondaryPickColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(25.0),
                                          child: CustomSvg(
                                            svg: musicJust,
                                          ),
                                        ),
                                      ):CustomImage(
                                        imageUrl: ref.watch(playlistProvider).playList[index].second!.musicName ,
                                        height: width * .35,
                                        width: width * .35,
                                        boxFit: BoxFit.cover,
                                      ),
                                      SizedBox(height: width * 0.04),
                                      Center(
                                        child: Container(
                                          color: Colors.transparent,
                                          child: CustomText(
                                            text: ref.watch(mixMusicProvider).musicModelSecond?.musicName??"Add a Sound",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: primaryGreyColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
                                    value: 0.1,
                                    min: 0.0,
                                    max: 1.0,
                                    divisions: 100,
                                    activeColor: primaryPinkColor,
                                    inactiveColor: primaryGreyColor2,
                                    onChanged: (double newValue) async{
                                     /* setState(() {
                                        currentVolume = newValue;
                                        print("volume $currentVolume");
                                      });
                                      await PerfectVolumeControl.setVolume(currentVolume);*/
                                    },
                                  ),
                                ),
                                const Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 15.0),
                                  child: CustomText(
                                    text: 'Set sound 1 volume',
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
                                  child: Slider(
                                    value: 0.1,
                                    min: 0.0,
                                    max: 1.0,
                                    divisions: 100,
                                    activeColor: primaryPinkColor,
                                    inactiveColor: primaryGreyColor2,
                                    onChanged: (double newValue) async{
                                     /* setState(() {
                                        currentVolume1 = newValue;
                                        print("volume $currentVolume1");
                                      });
                                      await PerfectVolumeControl.setVolume(currentVolume1);*/
                                    },
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: CustomText(
                                    text: 'Set sound 1 volume',
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
                  ],
                ),
              ),),
            ),
            ref.watch(playlistProvider).playList.length <3?const SizedBox(height: 20):const SizedBox(),
            ref.watch(playlistProvider).playList.length <3?GestureDetector(
              onTap: (){
                ref.read(playlistProvider).createMusic();
              },
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

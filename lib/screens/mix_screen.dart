
import 'package:audioplayers/audioplayers.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_snackbar.dart';
import 'package:bye_bye_cry_new/screens/provider/add_music_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_svg.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';


import '../compoment/utils/image_link.dart';
import 'models/music_models.dart';

class MixScreen extends ConsumerStatefulWidget {
  final VoidCallback? onPressed;
  const MixScreen({Key? key,this.onPressed}) : super(key: key);

  @override
  ConsumerState<MixScreen> createState() => _MixScreenState();
}

class _MixScreenState extends ConsumerState<MixScreen> {
  double currentvol = 1;
  double currentvol2 = 1;
  bool playPause = false;
  int index = 0;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  List<MusicModel> musicList = [];
  @override
  void initState() {
    startPlayer();
    addMixList();
    super.initState();
  }

  addMixList(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(mounted){
        if(ref.watch(addProvider).musicModelFirst != null){
          musicList.add(ref.watch(addProvider).musicModelFirst!);
        }
      }
      if(mounted){
        if(ref.watch(addProvider).musicModelSecond != null){
          musicList.add(ref.watch(addProvider).musicModelSecond!);
        }
      }
    });
  }
  startPlayer()async{

    audioPlayer.onPlayerStateChanged.listen((state) {
      playPause = state == PlayerState.playing;
      if(mounted){
        print("in method $playPause");
        print("duration ${_duration.inSeconds.toInt()}");
        print("position ${_position.inSeconds.toInt()}");
        if(!playPause){
          print("ses");
          if(_duration.inSeconds.toInt() == _position.inSeconds.toInt() || (_duration.inSeconds.toInt() - 1 == _position.inSeconds.toInt())){
            print("ses check");
            if(index < musicList.length-1){
              if(mounted){
                setState(() {
                  index++;
                });
                pausePlayMethod();
              }
              print("Index increase");
            }else{
              if(mounted){
                setState(() {
                  index = 0;
                });
                print("Index 0");
              }
            }
          }else{
            print("else duration ${_duration.inSeconds.toInt()}");
            print("else position ${_position.inSeconds.toInt()}");
          }
        }

        setState(() {});
      }
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      _duration = newDuration;
      if(mounted){
        setState(() {});
      }
    });
    audioPlayer.onPositionChanged.listen((newPositions) {
      _position = newPositions;
      if(mounted){
        setState(() {});
      }
    });
    if(mounted){
      setState(() {});
    }
  }

  pausePlayMethod()async{
    if(playPause){
      await audioPlayer.pause();
      print("pause");
    }else{
      String url = musicList[index].musicFile;
      await audioPlayer.play(AssetSource(url));
      print("play");
    }
    if(mounted){
      setState(() {});
    }
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = ScreenSize(context).width;
    final height = ScreenSize(context).height;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Mix',
      ),
      body: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: width * .1,
                ),
                const CustomText(
                  text: 'Create Your Own Sound',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: height * .03,
                ),
              ],
            ),
          ),
          ref.watch(addProvider).musicModelFirst?.image == null && ref.watch(addProvider).musicModelSecond?.image == null?const SizedBox():Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomImage(
                        imageUrl: "${ref.watch(addProvider).musicModelFirst?.image}",
                        height: width * .35,
                        width: width * .35,
                        boxFit: BoxFit.cover,
                      ),
                      Icon(
                        Icons.add,
                        size: height * .05,
                        color: primaryPinkColor,
                      ),
                      CustomImage(
                        imageUrl: ref.watch(addProvider).musicModelSecond?.image ?? music,
                        height: width * .35,
                        width: width * .35,
                        boxFit: BoxFit.cover,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    text: "${ref.watch(addProvider).musicModelFirst?.musicName}",
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: primaryGreyColor,
                  ),
                  const SizedBox(),
                  GestureDetector(
                    onTap:(){
                      if(ref.watch(addProvider).musicModelSecond?.musicName == null){
                        ref.read(addProvider).showPlusPlaylist(playlistPlusBottom:true);
                        ref.read(addProvider).changePage(1);
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: CustomText(
                        text: ref.watch(addProvider).musicModelSecond?.musicName ?? "Add a Sound",
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
                            value: 5,
                            min: 1.0,
                            max: 20.0,
                            divisions: 100,
                            activeColor: primaryPinkColor,
                            inactiveColor: primaryGreyColor2,
                            onChanged: (double newValue) {
                              setState(() {
                                //_value = newValue.round();
                              });
                            },
                            semanticFormatterCallback: (double newValue) {
                              return '${newValue.round()} dollars';
                            }),
                      ),
                      const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomText(
                          text: 'Set sound ${5} volume',
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
                              value: 5,
                              min: 1.0,
                              max: 20.0,
                              divisions: 100,
                              activeColor: primaryPinkColor,
                              inactiveColor: primaryGreyColor2,
                              onChanged: (double newValue) {
                                setState(() {
                                  //_value2 = newValue.round();
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
                          text: 'Set sound ${5} volume',
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
         Column(
           children: [
             Container(
               // color: Colors.red,
               height: width * 0.18,
               width: width * 0.18,
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
               child: Padding(
                 padding: const EdgeInsets.all(22),
                 child:  GestureDetector(
                   onTap: ()async{
                     pausePlayMethod();
                   },
                   child: CustomSvg(
                     //color: Colors.blue,
                     svg:playPause?pouseButton:playButtonSvg,
                   ),
                 ),
               ),
             ),
             const SizedBox(height: 5),
             OutLineButton(
               height: height * .06,
               text: 'Save To My Sounds ',
               textColor: secondaryBlackColor,
               textFontSize: 22,
               textFontWeight: FontWeight.w600,
               borderRadius: 50,
               onPressed: () {
                 _showDialog(context,firstMusicName: ref.watch(addProvider).musicModelFirst?.musicName??"", secondMusicName: ref.watch(addProvider).musicModelSecond?.musicName ?? "");
               },
             ),
             const SizedBox(
               height: 30,
             ),
           ],
         )
        ],
      ),
    );
  }
  void _showDialog(BuildContext context,{required String firstMusicName,required String secondMusicName}) {
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 20),
                        child: CustomText(
                          text: '$firstMusicName + $secondMusicName',
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
                      if(musicList.isNotEmpty && musicList.length > 1){
                        print("mix add hocche");
                        ref.read(addProvider).createMix(MixMusicModel(id: "${musicList[0].id}${musicList[1].id}",first: musicList[0],second: musicList[1]));
                        Navigator.pop(context);
                      }else{
                        ShowSnackBar.toastSnackBar(context: context, seconds: 2, text: "Add At least 2 music",color: Colors.white);
                        print("add another music");
                      }
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

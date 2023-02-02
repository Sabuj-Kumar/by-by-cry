import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_svg.dart';
import 'package:bye_bye_cry_new/screens/provider/add_music_provider.dart';
import 'package:bye_bye_cry_new/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import '../compoment/bottom_sheet.dart';
import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';
import 'models/music_models.dart';

class NowPlayingScreen extends ConsumerStatefulWidget {
  final MusicModel musicModel;
  final VoidCallback? onPressed;
  const NowPlayingScreen({Key? key,required this.musicModel,this.onPressed}) : super(key: key);

  @override
  ConsumerState<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends ConsumerState<NowPlayingScreen> with TickerProviderStateMixin{

  int _value = 1;
  double _value2 = 1;
  List<String> times = [
    "0",
    "5 min",
    "10 min",
    "30 min",
    "60 min",
    "90 min",
    "120 min",
    "150 min",
  ];
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Duration _slider = Duration(seconds: 0);
  double currentVolume = 0.0;
  bool issongplaying = false;
  double brightness = 0.5;
  late StreamSubscription<double> _subscription;

  @override
  void initState() {
    startPlayer();
    changeVolume();
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _subscription.cancel();
    super.dispose();
  }

  changeVolume(){
    PerfectVolumeControl.hideUI = true;
    Future.delayed(Duration.zero, () async {
      currentVolume = await PerfectVolumeControl.getVolume();
      setState(() {
        //refresh UI
      });
    });
    _subscription = PerfectVolumeControl.stream.listen((volume) {
      currentVolume = volume;
      if(mounted){
        print('sound $currentVolume');
        setState(() {});
      }
    });
  }
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      brightness = await FlutterScreenWake.brightness; //get the current screen brightness
      if(brightness > 1){
        brightness = brightness / 10;
        // sometime it gives value ranging 0.0 - 10.0, so convert it to range 0.0 - 1.0
      }
      print(brightness);
      setState(() {
        brightness = brightness;
        //change the variable value and update screen UI
      });

    } on PlatformException {
      brightness = 0.0;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }
  startPlayer()async{
    _position = _slider;
    audioCache.prefix = "asset";
    audioPlayer.onPlayerStateChanged.listen((state) {
      issongplaying = state == PlayerState.playing;
      if(mounted){
        print("in method $issongplaying");
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

  @override
  Widget build(BuildContext context) {
    final height = ScreenSize(context).height;
    final width = ScreenSize(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Now Playing',
        iconButton: true,
        onPressedButton: null,
        onPressed: widget.onPressed,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: (){
                    _showDialogBrightNess(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: width * .07),
                    child:  CustomImage(
                      imageUrl: 'asset/images/icon_png/now_playing_icon/Sun.png',
                      color: Colors.orangeAccent.shade100,
                    ),
                  ),
                ),
              ),
            ],
          ),
          CustomImage(
            imageUrl: widget.musicModel.image,
            height: width * .8,
            width: width * .8,
            boxFit: BoxFit.fill,
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){
              CustomBottomSheet.bottomSheet(context, isDismiss: true,child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) updateState) {
                return bottomSheet(context);
              },));
            },
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     CustomText(
                      text: widget.musicModel.musicName,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: secondaryBlackColor,
                    ),
                    const SizedBox( height:8,child: CustomSvg(svg: down_arrow,color: blackColorA0,)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: width * 0.07,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:  [
                    GestureDetector(
                        onTap: (){
                            ref.read(addProvider).addOrRemovePlayList(id:  widget.musicModel.id);
                        },
                        child: CustomImage(imageUrl: 'asset/images/icon_png/love.png',color: ref.watch(addProvider).playListIds.contains(widget.musicModel.id)? Colors.red:blackColorA0,)),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustomText(
                      text: 'Add To Playlist',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const CustomImage(
                        imageUrl: 'asset/images/icon_png/another_sound.png',
                        color: blackColorA0,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: (){
                          ref.read(addProvider).changePage(2);
                          ref.read(addProvider).clearMixMusics();
                          ref.read(addProvider).mixFirstMusic(widget.musicModel);
                         // Navigator.push(context, MaterialPageRoute(builder: (context) => const StartPage()));
                        },
                        child: const CustomText(
                          text: 'Mix Another\n Sound',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: width * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: '${_position.inSeconds ~/ 60} : ${(_position.inSeconds % 60).toInt()}',
                  fontSize: 10,
                  color: blackColor2,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: '${_duration.inSeconds ~/ 60} : ${(_duration.inSeconds % 60).toInt()}',
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
                  value: _position.inSeconds.toDouble(),
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  divisions: 100,
                  activeColor: primaryPinkColor,
                  inactiveColor: primaryGreyColor2,
                  onChanged: (double newValue) async{
                    _value = newValue.round();
                    print("slider");
                    if(_position.inSeconds.toInt()>=_duration.inSeconds.toInt()){
                      String url = widget.musicModel.musicFile;
                      await audioPlayer.play(AssetSource(url));
                    }
                    await audioPlayer.seek(Duration(seconds: newValue.toInt()));
                    await audioPlayer.resume();
                    if(_position.inSeconds.toInt()<_duration.inSeconds.toInt()){
                      String url = widget.musicModel.musicFile;
                      await audioPlayer.play(AssetSource(url));
                      print("play less");
                    }
                    setState(() {});
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  }),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  IconButton(
                    padding: const EdgeInsets.only(left: 10),
                      onPressed: (){
                        _showDialogVolume(context);
                      },
                      icon: Container(
                          color: Colors.transparent,
                          child: const CustomSvg(svg: volume,color: blackColor2))),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()async{
                        if(_position.inSeconds.toInt() - 5 > 0){
                          await audioPlayer.seek(Duration(seconds: _position.inSeconds.toInt() - 5));
                          String url = widget.musicModel.musicFile;
                          await audioPlayer.play(AssetSource(url));
                          print('click');
                        }
                      },
                      icon: const CustomSvg(svg: left_shift,color: primaryPinkColor)),
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
                    child: GestureDetector(
                      onTap: ()async {
                        if (issongplaying) {
                          await audioPlayer.pause();
                          print("pause solution");
                        } else {
                          String url = widget.musicModel.musicFile;
                          await audioPlayer.play(AssetSource(url));
                          print("play");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child:  CustomSvg(
                          color: primaryPinkColor,
                          svg:issongplaying?pouseButton:playButtonSvg,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()async{
                          //await audioPlayer.pause();
                          await audioPlayer.seek(Duration(seconds: _position.inSeconds.toInt() + 5));
                          await audioPlayer.resume();
                          print('click');

                          if(_position.inSeconds.toInt()>=_duration.inSeconds.toInt()){
                            await audioPlayer.pause();
                          }
                      },
                      icon: const CustomSvg(svg: right_shift,color: primaryPinkColor)),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        _showDialog(context);
                      },
                      icon: Container(
                          color: Colors.transparent,
                          child: const Padding(
                            padding:  EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomSvg(svg: timer,color: blackColor2,),
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _showDialogBrightNess(BuildContext context) {
    final height = ScreenSize(context).height;
    final width = ScreenSize(context).width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) updateState) { return Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              children: [
                Container(
                  color: Colors.transparent,
                  height: width * 0.27,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    backgroundColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    content: SizedBox(
                      height: width * 0.25,
                      child: Row(
                        children: [
                          Expanded(
                            child: SliderTheme(
                              data: const SliderThemeData(
                                  trackShape: RectangularSliderTrackShape(),
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
                              child: Slider(
                                  value: brightness,
                                  min: 0.0,
                                  max: 1.0,
                                  divisions: 100,
                                  activeColor: primaryPinkColor,
                                  inactiveColor: primaryGreyColor2,
                                  onChanged: (double newValue) async{
                                    updateState(() {
                                     // Screen.setBrightness(newValue);
                                      brightness = newValue;
                                      print("$brightness");
                                    });
                                    await FlutterScreenWake.setBrightness(brightness);
                                  },
                                  semanticFormatterCallback: (double newValue) {
                                    return '${newValue.round()} dollars';
                                  }
                                 ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              color: Colors.transparent,
                              height: width * 0.1,
                              child: const CustomImage(
                                boxFit: BoxFit.fill,
                                imageUrl: 'asset/images/icon_png/now_playing_icon/Sun.png',
                                color: primaryPinkColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );  },
        );
      },
    );
  }
  void _showDialogVolume(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) updateState) { return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform(
                transform:  Matrix4.identity()..rotateZ(-90 * 3.1415927 / 180),
                child: AlertDialog(
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  backgroundColor: Colors.white,
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0,top:15,right: 0,bottom: 0),
                          child: Transform(
                            alignment: Alignment.topCenter,
                            transform:  Matrix4.identity()..rotateZ(90 * 3.1415927 / 180),
                            child: const CustomSvg(svg: volume,color: Colors.red,),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: currentVolume,
                            min: 0.0,
                            max: 1.0,
                            divisions: 100,
                            activeColor: primaryPinkColor,
                            inactiveColor: primaryGreyColor2,
                            onChanged: (double newValue) async{
                              updateState(() {
                                // Screen.setBrightness(newValue);
                                currentVolume = newValue;
                                print("$currentVolume");
                              });
                              await PerfectVolumeControl.setVolume(currentVolume);
                            },
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );  },
        );
      },
    );
  }
  void _showDialog(BuildContext context) {
    final height = ScreenSize(context).height;
    final width = ScreenSize(context).width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) updateState) { return  Align(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  backgroundColor: Colors.white,
                  title: const CustomText(
                    text: 'Select Duration',
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: primaryGreyColor,
                  ),
                  content: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: greyEC,
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 9),
                          child: CustomText(
                            text: '${(_value2 ~/ 60).toString().padLeft(2,'0')}:${(_value2 % 60).toString().padLeft(2,'0')}',
                            fontSize: 20,
                            color: secondaryBlackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                            trackShape: RectangularSliderTrackShape(),
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
                        child: Slider(
                            value: _value.toDouble(),
                            min: 0.0,
                            max: 150.0,
                            divisions: 100,
                            activeColor: primaryPinkColor,
                            inactiveColor: primaryGreyColor2,
                            onChanged: (double newValue) {
                              updateState(() {
                                _value = newValue.round();
                              });
                            },
                            semanticFormatterCallback: (double newValue) {
                              return '${newValue.round()} dollars';
                            }),
                      ),
                      SizedBox(
                        width: width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(times.length, (index) => CustomText(text: times[index],fontWeight: FontWeight.w400,fontSize: 6,color: secondaryBlackColor) ),
                        ),
                      )
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.start,
                  actionsPadding: const EdgeInsets.only(left: 48,bottom: 30),
                  actions: <Widget>[
                    Row(
                      children: [
                        Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryPinkColor,width: 2)
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        const CustomText(text: "continuous play",fontSize: 16,fontWeight: FontWeight.w400,color: primaryGreyColor,)
                      ],
                    )
                  ],
                ),
              ],
            ),
          );  },
        );
      },
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
                            Column(
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
                                                    padding:  EdgeInsets.all(20.0),
                                                    child: CustomText(text: "20%",fontSize: 12,fontWeight: FontWeight.w600,color: blackColor50),
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
                                                    child: CustomText(text: "60%",fontSize: 12,fontWeight: FontWeight.w600,color: blackColor50),
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
                              ],
                            ),
                            index < 2?const SizedBox(height: 10):const SizedBox(),
                            index < 2?Container(width: width,height: 1.5,color: blackColorD9,):const SizedBox(),
                            const SizedBox(height: 20)
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

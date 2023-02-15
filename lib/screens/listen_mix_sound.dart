import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_svg.dart';
import 'package:bye_bye_cry_new/screens/models/music_models.dart';
import 'package:bye_bye_cry_new/screens/provider/mix_music_provider.dart';
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

class ListenMixSound extends ConsumerStatefulWidget {
  final String?  mixMusicModelId;
  final VoidCallback? onPressed;
  const ListenMixSound({Key? key,required this.mixMusicModelId,this.onPressed}) : super(key: key);

  @override
  ConsumerState<ListenMixSound> createState() => _ListenMixSoundState();
}

class _ListenMixSoundState extends ConsumerState<ListenMixSound> with TickerProviderStateMixin{

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
  List<int> selectedTimes = [
    0,
    5,
    10,
    30,
    60,
    90,
    120,
    150
  ];
  int selectedTime = 0;
  bool playPouse = true;
  int setDuration = 0;
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer1 = AudioPlayer();
  AudioPlayer audioPlayer2 = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Duration _duration2 = Duration.zero;
  Duration _position2 = Duration.zero;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  double currentVolume = 0.0;
  bool issongplaying1 = false;
  bool issongplaying2 = false;
  double brightness = 0.5;
  late StreamSubscription<double> _subscription;
  int musicIndex = 0;
  List<MusicModel> musicList = [];
  int index = 0;
  bool check = false;
  TextEditingController minController = TextEditingController();
  TextEditingController secController = TextEditingController();

  @override
  void initState() {
    startPlayer1();
    startPlayer2();
    changeVolume();
    brightNess();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    initialization();
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    audioPlayer1.dispose();
    audioPlayer2.dispose();
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
  Future<void> brightNess() async {

    try {
      brightness = await FlutterScreenWake.brightness; //get the current screen brightness
      if(brightness > 1){
        brightness = brightness / 10;
      }
      print(brightness);
      setState(() {
        brightness = brightness;
      });

    } on PlatformException {
      brightness = 0.0;
    }
    if (!mounted) return;
  }

  startPlayer1()async{
    audioPlayer1.onPlayerStateChanged.listen((state){
      issongplaying1 = state == PlayerState.playing;
      if(!issongplaying1 || !issongplaying2){
        if(setDuration > 0){
          setDuration -= _duration.inSeconds;
          if(mounted){
            setState(() {});
            pausePlayMethod();
          }
        }
      }
      if(mounted){
        setState(() {});
      }
    });
    audioPlayer1.onDurationChanged.listen((newDuration) {
      _duration = newDuration;
     print("first music duration ${_duration.inSeconds}");
      if(mounted){
        setState(() {});
      }
    });
    audioPlayer1.onPositionChanged.listen((newPositions) {
      _position = newPositions;
      if(mounted){
        setState(() {});
      }
    });
    if(mounted){
      setState(() {});
    }
  }
  startPlayer2()async{
    audioPlayer2.onPlayerStateChanged.listen((state){
      issongplaying2 = state == PlayerState.playing;
      if(!issongplaying1 || !issongplaying2){
        if(setDuration > 0){
          setDuration -= _duration.inSeconds;
          if(mounted){
            setState(() {});
            pausePlayMethod();
          }
        }
      }
      if(mounted){
        setState(() {});
      }
    });
    audioPlayer2.onDurationChanged.listen((newDuration) {
      _duration2 = newDuration;
      print("second music duration ${_duration2.inSeconds}");
      if(mounted){
        setState(() {});
      }
    });
    audioPlayer2.onPositionChanged.listen((newPositions) {
      _position2 = newPositions;
      if(mounted){
        setState(() {});
      }
    });
    if(mounted){
      setState(() {});
    }
  }
  initialization(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      musicIndex = ref.read(mixMusicProvider).combinationList.indexWhere((element) => element.id == widget.mixMusicModelId);
      print("music index $musicIndex");
      if(mounted){
        setState(() {});
      }
      checkMounted();
    });
  }
  changeIndex({bool changeIndex = false}){
      if(changeIndex){
        musicIndex = (musicIndex + 1) % ref.watch(mixMusicProvider).combinationList.length;
      }else{
        musicIndex = (musicIndex - 1);
        if(musicIndex < 0){
          musicIndex = ref.watch(mixMusicProvider).combinationList.length-1;
        }
      }
      /*if(mounted){
        musicList = [];
        musicList.add(ref.watch(mixMusicProvider).combinationList[musicIndex].first!);
        musicList.add(ref.watch(mixMusicProvider).combinationList[musicIndex].second!);
        index = 0;
        setState((){});
      }*/
  }
  pausePlayMethod()async{
    if(issongplaying1 || issongplaying2){
      await audioPlayer1.pause();
      await audioPlayer2.pause();
    }else{
      String url1 = ref.watch(mixMusicProvider).combinationList[musicIndex].first?.musicFile??"";
      String url2 = ref.watch(mixMusicProvider).combinationList[musicIndex].second?.musicFile??"";
      print("${audioPlayer1.getDuration().then((value) => print("duration value$value"))}");
      await audioPlayer1.play(AssetSource(url1));
      await audioPlayer2.play(AssetSource(url2));
    }
    if(mounted){
      setState(() {});
    }
  }
  playMusic()async{
    String url1 = ref.watch(mixMusicProvider).combinationList[musicIndex].first?.musicFile??"";
    String url2 = ref.watch(mixMusicProvider).combinationList[musicIndex].second?.musicFile??"";
    await audioPlayer1.play(AssetSource(url1));
    await audioPlayer2.play(AssetSource(url2));
    if(mounted){
      setState(() {});
    }
  }
  checkMounted()async{
    if(mounted){
      setState(() {});
      pausePlayMethod();
    }
    print("duration2 ${_duration2.inSeconds}  duration${_duration.inSeconds}");
  }
/*if(_duration.inSeconds.toInt() == _position.inSeconds.toInt() || (_duration.inSeconds.toInt() - 1 == _position.inSeconds.toInt())) {
        if(mounted){
          setState(() {
            if(setDuration>0){
              setDuration -= _duration.inSeconds.toInt();
            }
          });
        }
      }*/
  /* if(!issongplaying){
          if(_duration.inSeconds.toInt() == _position.inSeconds.toInt() || (_duration.inSeconds.toInt() - 1 == _position.inSeconds.toInt())){
            if(mounted){
              if(index < 1){
                index = 1;
                print("index++ $index");
                pausePlayMethod();
              }else{
                index = 0;
              }
              setState(() {});
            }
          }else{
            print("else duration ${_duration.inSeconds.toInt()}");
          }
      }
      if(mounted){
        if(playPouse){
          if(_duration.inSeconds.toInt() == _position.inSeconds.toInt() || (_duration.inSeconds.toInt() - 1 == _position.inSeconds.toInt())){
            if(!issongplaying){
              print("not stop");
              if(mounted){
                setState((){});
              }
              if(setDuration > 0){
                pausePlayMethod();
              }
            }
          }
        }
      }*/
  @override
  Widget build(BuildContext context) {
    final height = ScreenSize(context).height;
    final width = ScreenSize(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Witching Hour',
        iconButton: false,
        onPressedButton: null,
        onPressed: widget.onPressed,
      ),
      body: SingleChildScrollView(
        child: Column(
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
              imageUrl: ref.watch(mixMusicProvider).combinationList[musicIndex].first?.image??"",
              height: width * .7,
              width: width * .9,
              boxFit: BoxFit.fill,
            ),
            GestureDetector(
              onTap: (){
                CustomBottomSheet.bottomSheet(context, isDismiss: true,child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) updateState) {
                  return bottomSheet(context:context,id: ref.watch(mixMusicProvider).combinationList[musicIndex].id);
                },));
              },
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "${ref.watch(mixMusicProvider).combinationList[musicIndex].first?.musicName}+${ref.watch(mixMusicProvider).combinationList[musicIndex].second?.musicName}",
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: secondaryBlackColor,
                            ),
                            const SizedBox(height:8,child: CustomSvg(svg: down_arrow,color: blackColorA0,)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: width * 0.06),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children:  [
                      GestureDetector(
                          onTap: (){
                            ref.read(mixMusicProvider).addOrRemoveMixPlayList(id: ref.watch(mixMusicProvider).combinationList[musicIndex].id);
                          },
                          child: CustomImage(imageUrl: 'asset/images/icon_png/love.png',color: ref.watch(mixMusicProvider).mixPlayListIds.contains(ref.watch(mixMusicProvider).combinationList[musicIndex].id)? Colors.red:blackColorA0,)),
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
                ],
              ),
            ),
            SizedBox(height: width * 0.1),
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
                    value: position.inSeconds.toDouble() < _position2.inSeconds.toDouble()?_position.inSeconds.toDouble():_position2.inSeconds.toDouble(),
                    min: 0,
                    max: _duration.inSeconds.toDouble() < _duration2.inSeconds.toDouble()?_duration.inSeconds.toDouble():_duration2.inSeconds.toDouble(),
                    divisions: 100,
                    activeColor: primaryPinkColor,
                    inactiveColor: primaryGreyColor2,
                    onChanged: (double newValue) async{
                      if(newValue.toInt() <= _duration.inSeconds){
                        await audioPlayer1.seek(Duration(seconds: newValue.toInt()));
                      }
                      if(newValue.toInt() <= _duration2.inSeconds){
                        await audioPlayer2.seek(Duration(seconds: newValue.toInt()));
                      }
                      await audioPlayer1.resume();
                      await audioPlayer2.resume();
                      if(mounted){
                        setState(() {});
                      }
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
                          changeIndex(changeIndex: false);
                          if(mounted){
                            playMusic();
                          }
                          if(mounted){
                            setState(() {});
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
                          if(playPouse){
                            await audioPlayer1.pause();
                            await audioPlayer2.pause();
                          }else{
                            String url1 = ref.watch(mixMusicProvider).combinationList[musicIndex].first?.musicFile??"";
                            String url2 = ref.watch(mixMusicProvider).combinationList[musicIndex].second?.musicFile??"";
                            await audioPlayer1.play(AssetSource(url1));
                            await audioPlayer2.play(AssetSource(url2));
                          }
                          playPouse = !playPouse;
                          if(mounted){setState(() {});}
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(22),
                          child:  CustomSvg(
                            color: primaryPinkColor,
                            svg:(issongplaying1 || issongplaying2)?pouseButton:playButtonSvg,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: ()async{
                          changeIndex(changeIndex: true);
                          if(mounted){
                            playMusic();
                          }
                          if(mounted){
                            setState(() {});
                          }
                        },
                        icon: const CustomSvg(svg: right_shift,color: primaryPinkColor)),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          ref.read(mixMusicProvider).alertDialogStart();
                          if(mounted){
                            setState(()  {
                              check = false;
                              selectedTime = 0;
                            });
                            _showDialog(context);
                          }
                        },
                        icon: Container(
                            color: Colors.transparent,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomSvg(svg: timer,color: blackColor2),
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                  height: width * 0.24,
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
        final width = ScreenSize(context).width;
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
                    child: Stack(
                      children: [
                        Row(
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
                                    print("volume $currentVolume");
                                  });
                                  await PerfectVolumeControl.setVolume(currentVolume);
                                },
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            right: width * 0.25,
                            top: 10,
                            child: Transform(
                                transform:  Matrix4.identity()..rotateZ(90 * 3.1415927 / 180),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: secondaryBlackColor.withOpacity(0.2),
                                        blurRadius: 0.2,
                                        spreadRadius: 0.5
                                      )
                                    ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 5),
                                    child: Center(child: CustomText(text: "${(currentVolume * 100).toInt().toString().padLeft(2,"0")}%",fontSize: 10,color: secondaryBlackColor,fontWeight: FontWeight.w600,)),
                                  ),
                                )))
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
          builder: (BuildContext context, void Function(void Function()) state) {
           /* if(mounted) {
              //startTimer(state);
              if(mounted){
                state((){});
              }
            }*/
            return  Align(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  backgroundColor: Colors.white,
                  title: Column(
                    children: const [
                       CustomText(
                        text: 'Select Duration',
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: primaryGreyColor,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                  content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.17,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: greyEC,
                        ),
                        child: Center(child: CustomText(text: "${(selectedTimes[selectedTime] ~/ 60).toString().padLeft(2,"0")} : ${(selectedTimes[selectedTime] % 60).toString().padLeft(2,"0")}")),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                            trackShape: RectangularSliderTrackShape(),
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
                        child: Slider.adaptive(
                            value: selectedTime.toDouble(),
                            min: 0,
                            max: 7,
                            divisions: 7,
                            activeColor: primaryPinkColor,
                            inactiveColor: primaryGreyColor2,
                            onChanged: (double newValue) async{
                              state(() {
                                setDuration = 1;
                                selectedTime = check?0:newValue.toInt();
                                setDuration = selectedTimes[selectedTime];
                                setDuration *= 60;
                                print("index $selectedTime");
                              });
                              setState(() {});
                            },
                            semanticFormatterCallback: (double newValue) {
                              return '${newValue.round()} dollars';
                            }),
                      ),
                      SizedBox(
                        width: width * 0.59,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(times.length, (index) => CustomText(text: times[index],fontWeight: FontWeight.w400,fontSize: 8,color: secondaryBlackColor) ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.start,
                  actionsPadding: const EdgeInsets.only(left: 48,bottom: 30),
                  actions: <Widget>[
                    Row(
                      children: [
                        Checkbox(
                            side: const BorderSide(color: blackColorA0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            activeColor: primaryPinkColor,
                            value: check,
                            onChanged: (newValue){
                              state(() {
                                check = newValue!;
                                if(check){
                                  selectedTime = 0;
                                }
                              });
                        }),
                        TextButton(onPressed: check?() async{
                          if(mounted){
                            Navigator.pop(context);
                          }
                        }:null,
                        child: const CustomText(text: "continuous play",fontSize: 16,fontWeight: FontWeight.w400,color: primaryGreyColor,))
                      ],
                    )
                  ],
                ),
              ],
            ),
          );  },
        );
      },
    ).then((value) {
      if(mounted){
        ref.read(mixMusicProvider).alertDialogStop();
       if(mounted){
         setState(() {
           secController.text = "";
           minController.text = "";
           print("asche");
         });
       }
      }
    });
  }
  Widget bottomSheet({required BuildContext context,required String id}){
    final width = ScreenSize(context).width;
    int playIndex = ref.watch(mixMusicProvider).combinationList.indexWhere((element) => element.id == id);
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
                              mainAxisSize: MainAxisSize.min,
                              children:  [
                                const CustomText(text: "Witching Hour",fontWeight: FontWeight.w600,fontSize: 20,color: blackColor50),
                                const SizedBox(height: 5),
                                Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                        color: Colors.transparent,
                                        width: width * 0.67,
                                        child: CustomText(text: "${ref.watch(mixMusicProvider).combinationList[playIndex].first?.musicName} + ${ref.watch(mixMusicProvider).combinationList[playIndex].second?.musicName} is playing",fontWeight: FontWeight.w400,fontSize: 14,color: blackColor50)))
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
                      children: List.generate(ref.watch(mixMusicProvider).combinationList.length, (index) => Container(
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
                                                width: width * 0.44,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        height: width * 0.1,
                                                        width: width * 0.1,
                                                        child:  CustomImage(imageUrl: "${ref.watch(mixMusicProvider).combinationList[index].first?.image}",boxFit: BoxFit.fill,)),
                                                     Expanded(
                                                       child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: CustomText(text: "${ref.watch(mixMusicProvider).combinationList[index].first?.musicName}",fontSize: 16,fontWeight: FontWeight.w600,color: blackColor50),
                                                    ),
                                                     ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children:  [
                                                  const CustomSvg(svg: volume),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                    child: CustomText(text: "${(currentVolume * 100).toInt().toString().padLeft(2,"0")}%",fontSize: 12,fontWeight: FontWeight.w600,color: blackColor50),
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
                                                width: width * 0.44,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        height: width * 0.1,
                                                        width: width * 0.1,
                                                        child:  CustomImage(imageUrl: "${ref.watch(mixMusicProvider).combinationList[index].second?.image}",boxFit: BoxFit.fill)),
                                                     Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: CustomText(text: "${ref.watch(mixMusicProvider).combinationList[index].second?.musicName}",fontSize: 16,fontWeight: FontWeight.w600,color: blackColor50),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children:  [
                                                  const CustomSvg(svg: volume),
                                                  Padding(
                                                    padding:const EdgeInsets.symmetric(horizontal: 5.0),
                                                    child: CustomText(text: "${(currentVolume * 100).toInt().toString().padLeft(2,"0")}%",fontSize: 12,fontWeight: FontWeight.w600,color: blackColor50),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
                                          child: ref.watch(mixMusicProvider).combinationList[index].id != id?const CustomImage(
                                            imageUrl: playButton,
                                            height: 30,
                                            width: 30,
                                            color: blackColor97,
                                          ):issongplaying1?const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: CustomSvg(svg: pouseButton,height: 15,
                                              width: 15,
                                              color: blackColor97),
                                          ):const CustomImage(
                                            imageUrl: playButton,
                                            height: 30,
                                            width: 30,
                                            color: blackColor97,
                                          ),
                                      ))
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

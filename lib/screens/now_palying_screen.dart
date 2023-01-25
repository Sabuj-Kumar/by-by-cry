import 'package:audioplayers/audioplayers.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../compoment/bottom_sheet.dart';
import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';
import 'models/music_models.dart';

class NowPlayingScreen extends ConsumerStatefulWidget {
  final MusicModel musicModel;
  const NowPlayingScreen({Key? key,required this.musicModel}) : super(key: key);

  @override
  ConsumerState<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

int _value = 1;
int _value2 = 1;
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
class _NowPlayingScreenState extends ConsumerState<NowPlayingScreen> with TickerProviderStateMixin{

  late AnimationController _animationIconController1;
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Duration _slider = Duration(seconds: 0);
  double durationvalue = 0;
  bool issongplaying = false;

  @override
  void initState() {
    _position = _slider;
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
      reverseDuration: const Duration(milliseconds: 750),
    );
    audioCache.prefix = "asset";
    audioPlayer.onPlayerStateChanged.listen((state) {
      issongplaying = state == PlayerState.playing;
      if(mounted){
        setState(() {});
      }
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPositions) {
      setState(() {
        _position = newPositions;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
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
                    const SizedBox( height:8,child: CustomSvg(svg: down_arrow)),
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
            height: width * .2,
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
                    await audioPlayer.seek(Duration(seconds: newValue.toInt()));
                    await audioPlayer.resume();
                    setState(() {});
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
                  const CustomSvg(svg: volume),
                  const CustomSvg(svg: left_shift),
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
                         await audioPlayer.setVolume(0.5);
                          if(issongplaying){
                           await audioPlayer.pause();
                          }else{
                            String url = widget.musicModel.musicFile;
                            await audioPlayer.play(AssetSource(url));
                          }
                        },
                        child: CustomSvg(
                          //color: Colors.blue,
                          svg:issongplaying?pouseButton:playButtonSvg,
                        ),
                      ),
                    ),
                  ),
                  const CustomSvg(svg: right_shift),
                  GestureDetector(
                      onTap: (){
                        _showDialog(context);
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: const Padding(
                            padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 2),
                            child: CustomSvg(svg: timer),
                          ))),
                 /* const CustomImage(
                    imageUrl: 'asset/images/icon_png/now_playing_icon/time.png',
                  ),*/
                ],
              ),
            ),
          )
        ],
      ),
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
                            value: _value2.toDouble(),
                            min: 0.0,
                            max: 150.0,
                            divisions: 100,
                            activeColor: primaryPinkColor,
                            inactiveColor: primaryGreyColor2,
                            onChanged: (double newValue) {
                              updateState(() {
                                _value2 = newValue.round();
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

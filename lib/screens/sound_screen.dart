
import 'package:audioplayers/audioplayers.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_svg.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_text.dart';
import 'package:bye_bye_cry_new/compoment/shared/screen_size.dart';
import 'package:bye_bye_cry_new/screens/provider/add_music_provider.dart';
import 'package:bye_bye_cry_new/screens/provider/mix_music_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../compoment/shared/custom_app_bar.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';
import 'listen_mix_sound.dart';
import 'models/music_models.dart';
import 'now_palying_screen.dart';

class SoundScreen extends ConsumerStatefulWidget {
  const SoundScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends ConsumerState<SoundScreen> {

  TextEditingController searchController = TextEditingController();
  bool changeToPlayNow = false;
  bool changeToMixPlayNow = false;
  MusicModel? music;
  String mixMusicId = '';
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  bool issongplaying = false;
  int index = 0;
  String musicId = "";
  bool deleteShow = false;

  List<String> imageUrl = [
    chainsaw,
    vaccum,
    jackhammer,
    blowdryer,
    lawnmower,
    washer,
    ocean,
    dummy,
    dummy,
    dummy,
  ];
  List<String> textUrl = [
    'Chainshaw',
    'Vaccum',
    'Jackhammer',
    'Blowdryer',
    'Lawnmower',
    'Washer',
    'Ocean',
    'Ocean + Rain',
    'Lawnmower + Ocean',
    'Mix Two Sounds'
  ];

  startPlayer()async{
    audioPlayer.onPlayerStateChanged.listen((state) {
      issongplaying = state == PlayerState.playing;
      if(mounted){
        setState((){});
      }
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      if(mounted){
        setState(() {});
      }
    });
    audioPlayer.onPositionChanged.listen((newPositions) {
      if(mounted){
        setState(() {});
      }
    });
    if(mounted){
      setState(() {});
    }
  }
  pausePlayMethod()async{
    if(issongplaying){
      await audioPlayer.pause();
      print("pause");
    }else{
      String url = ref.watch(addProvider).musicList[index].musicFile;
      await audioPlayer.play(AssetSource(url));
      print("play");
    }
    if(mounted){
      setState(() {});
    }
  }
  playMusic({required String id}) async{
      print("playlist play button click");
      int _index = ref.watch(addProvider).musicList.indexWhere((element) => element.id == id);
      if(_index >= 0){
        if(_index == index){
          if(issongplaying){
            await audioPlayer.pause();
          }else{
            String url = ref.watch(addProvider).musicList[index].musicFile;
            await audioPlayer.play(AssetSource(url));
          }
        }else{
          index = _index;
          String url = ref.watch(addProvider).musicList[index].musicFile;
          await audioPlayer.play(AssetSource(url));
        }
      }
      if(mounted){
        setState(() {});
      }
  }
  initialized(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(mounted){
        if(ref.watch(mixMusicProvider).changeToMixPlayNow){
            mixMusicId = ref.watch(mixMusicProvider).musicId;
            if(mounted){
              ref.read(mixMusicProvider).setMusicId();
            }
        }
      }
      if(mounted){
        if(ref.read(addProvider).changeToPlayNow){
          musicId = ref.watch(addProvider).musicId;
          if(mounted){
            ref.read(addProvider).setMusicId();
          }
        }
      }
      if(mounted){
        changeToMixPlayNow = ref.read(mixMusicProvider).changeToMixPlayNow;
      }
      if(mounted){
        changeToPlayNow = ref.read(addProvider).changeToPlayNow;
      }
      if(mounted){
        ref.read(addProvider).changePlay(change: false);
      }
      if(mounted){
        ref.read(mixMusicProvider).changeMixPlay(change: false);
      }
      if(mounted){setState((){});}
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
  @override
  void initState() {
    initialized();
    startPlayer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return changeToPlayNow?NowPlayingScreen(
        musicId: musicId,
        onPressed: (){
          setState(() {
            changeToPlayNow = false;
          });
        },
    ):changeToMixPlayNow?ListenMixSound(mixMusicModelId: mixMusicId,onPressed: (){
      setState(() {
        changeToMixPlayNow = false;
      });
    }):Scaffold(
        appBar: CustomAppBar(
            title: deleteShow?'Edit My Sounds':'My Sounds',
            actionTitle: deleteShow?"":'Edit',
            onPressedButton: (){
              deleteShow = true;
              if(mounted){
                setState(() {});
              }
            },
            onPressed: () {
              deleteShow = false;
              if(ref.watch(addProvider).showAddPlaylist){
                ref.read(addProvider).showPlusPlaylist();
              }
              if(mounted){
                setState(() {});
              }
            }),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  color: secondaryWhiteColor2,
                  child: ListTile(
                    dense: true,
                    title: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: blackColorA0,fontSize: 14,fontWeight: FontWeight.w400),
                          hintText: 'Search music', border: InputBorder.none
                      ),
                    ),
                    trailing: GestureDetector(onTap:(){},child: const CustomSvg(svg: "asset/images/search_icon.svg",)),
                  ),
                ),
              ),//combinationList
              Column(
                  children: List.generate(
                ref.watch(addProvider).musicList.isEmpty?0:ref.watch(addProvider).musicList.length,
                (index) => Column(
                  children: [
                    Container(
                      color: index % 2 == 0?Colors.transparent:pinkLightColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: imageList(
                          context: context,musicModel: ref.watch(addProvider).musicList[index]),
                      ),
                    ),// const SizedBox(height: 5,)
                  ],
                ),
              )),
              Column(
                  children: List.generate(
                    ref.watch(mixMusicProvider).combinationList.isEmpty?0:ref.watch(mixMusicProvider).combinationList.length,
                        (index) => Column(
                      children: [
                        Container(
                          color: index % 2 == 0?Colors.transparent:pinkLightColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: mixImageList(
                                context: context,mixMusicModel: ref.watch(mixMusicProvider).combinationList[index]),
                          ),
                        ),// const SizedBox(height: 5,)
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                     // height: 50,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: primaryPinkColor,
                      ),
                      child: const CustomImage(
                        boxFit: BoxFit.fill,
                        imageUrl: whitePlus,
                        scale: 1,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const CustomText(
                      text: 'Mix Two Sounds',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: blackColor50,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15,)
            ],
          ),
        ));
  }

  Widget imageList({required MusicModel musicModel,required BuildContext context,}) {
    return GestureDetector(
      onTap: ref.watch(addProvider).showAddPlaylist?null:(){
        setState(() {
          music = musicModel;
          musicId = musicModel.id;
          changeToPlayNow = ref.watch(addProvider).showAddPlaylist?false:deleteShow?false:true;
          print("change");
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: CustomImage(imageUrl: musicModel.image),
              ),
              const SizedBox(
                width: 10,
              ),
              CustomText(text: musicModel.musicName,color: blackColor50,fontWeight: FontWeight.w600,fontSize: 20,),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.05)
                  ),
                  child: ref.read(addProvider).showAddPlaylist?GestureDetector(
                    onTap:()async {
                      musicId = musicModel.id;
                      if(mounted){
                        playMusic(id: musicId);
                      }
                    },
                    child: musicId == musicModel.id?Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: issongplaying? const CustomSvg(svg:pouseButton,color: blackColor97,height: 12,width: 12,):const CustomImage(
                        imageUrl:playButton,
                        scale: 0.8,
                      ),
                    ):const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CustomImage(
                        scale: 0.8,
                        imageUrl:playButton,
                      ),
                    ),
                  ):deleteShow?const SizedBox():const Padding(
                    padding: EdgeInsets.all(15.0),
                    child:  CustomImage(
                      imageUrl:playButton,
                    ),
                  ),
                ),
                ref.read(addProvider).showAddPlaylist?Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.1)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        ref.read(addProvider).changePage(2);
                        ref.read(mixMusicProvider).mixSecondMusic(musicModel);
                        ref.read(addProvider).showPlusPlaylist(playlistPlusBottom: false);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.add,color: blackColorA0,),
                      ),
                    ),
                  ),
                ):const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget mixImageList({required MixMusicModel mixMusicModel,required BuildContext context}) {
    return GestureDetector(
      onTap: (){
        setState(() {
          mixMusicId = mixMusicModel.id;
          changeToMixPlayNow = ref.watch(addProvider).showAddPlaylist?false:deleteShow?false:true;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: CustomImage(imageUrl: dummy),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                        color: Colors.transparent,
                        //width: ScreenSize(context).width * 0.55,
                        child: CustomText(text: "${mixMusicModel.first?.musicName} + ${mixMusicModel.second?.musicName}",color: blackColor50,fontWeight: FontWeight.w600,fontSize: 20,))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ref.watch(addProvider).showAddPlaylist?const SizedBox():deleteShow?const SizedBox():Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.1)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CustomImage(
                      imageUrl: playButton,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
               deleteShow?Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.1)
                    ),
                    child: GestureDetector(
                      onTap: (){
                        _showDialog(firstMusicName: mixMusicModel.first?.musicName??"", secondMusicName: mixMusicModel.second?.musicName??'',context,mixId:mixMusicModel.id);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CustomSvg(svg: deleteSvg),
                      ),
                    ),
                  ),
                ):const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showDialog(BuildContext context,{required String firstMusicName,required String secondMusicName,required String mixId}) {
    final width = ScreenSize(context).width;
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
                backgroundColor: Colors.white,
                title: const CustomText(
                  text: 'You ave removed',
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: secondaryBlackColor,
                ),
                content: Column(
                  children: [
                    CustomText(
                      text: '$firstMusicName + $secondMusicName',
                      fontSize: 18,
                      color: primaryGreyColor,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 13,),
                    const CustomText(
                      text: 'from Sound List',
                      fontSize: 20,
                      color: secondaryBlackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actionsPadding: const EdgeInsets.only(bottom: 20),
                actions: <Widget>[
                  OutLineButton(
                    height: width * .08,
                    width: width * .16,
                    text: 'Ok',
                    textColor: primaryGreyColor,
                    textFontSize: 20,
                    textFontWeight: FontWeight.w600,
                    borderRadius: 48,
                    onPressed:(){
                      ref.read(mixMusicProvider).deleteMix(mixId: mixId);
                      if(mounted){
                        Navigator.pop(context);
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

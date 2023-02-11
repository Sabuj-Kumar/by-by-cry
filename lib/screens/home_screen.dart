import 'package:bye_bye_cry_new/compoment/shared/custom_svg.dart';
import 'package:bye_bye_cry_new/screens/provider/add_music_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../compoment/shared/custom_image.dart';
import '../compoment/shared/custom_image_text.dart';
import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';
import '../compoment/utils/image_link.dart';
import 'home_page_again.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<String> imageUrl = [
    'asset/images/blowdryer.png',
    'asset/images/chainshaw.png',
    'asset/images/jackhammer.png',
    'asset/images/lawnmower.png',
    'asset/images/vaccum.png',
    'asset/images/washer.png'
  ];

  List<String> textUrl = [
    'Jackhammer',
    'Chainshaw',
    'Vaccum',
    'Blowdryer',
    'Lawnmower',
    'Washer',
  ];

  List<String> socialMedia = [
    'asset/images/icon_png/fb.png',
    'asset/images/icon_png/linkedIn.png',
    'asset/images/icon_png/insta.png',
  ];

  bool subscription = true;
  @override
  Widget build(BuildContext context) {
    return const HomePageAgain();
  }

}

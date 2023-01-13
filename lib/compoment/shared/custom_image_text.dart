import 'package:bye_bye_cry_new/compoment/shared/screen_size.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomImageText extends StatelessWidget {
  const CustomImageText({Key? key, required this.text, required this.imageUrl})
      : super(key: key);
  final String text;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    final width = ScreenSize(context).width;
    final height = ScreenSize(context).height;
    return Column(
      children: [
        Container(
          height: width * .25,
          width: width * .25,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(imageUrl))),

        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(
          text: text,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

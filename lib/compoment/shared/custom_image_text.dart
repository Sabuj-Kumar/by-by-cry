import 'package:bye_bye_cry_new/compoment/shared/screen_size.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
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
          height: width * .24,
          width: width * .24,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(imageUrl)),
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 3),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1
              ),
              BoxShadow(
                offset: Offset(2,1),
                color: Colors.black.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 1
              ),
            ]
          ),

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

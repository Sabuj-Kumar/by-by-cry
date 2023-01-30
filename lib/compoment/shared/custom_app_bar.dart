import 'package:bye_bye_cry_new/compoment/shared/custom_image.dart';
import 'package:bye_bye_cry_new/compoment/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? actionTitle;
  final double? height;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedButton;
  final bool iconButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.height = 60,
    this.actionTitle,
    this.onPressed,
    this.onPressedButton,
    this.iconButton = false,
    // this.iconB,
  });

  @override
  Size get preferredSize => Size.fromHeight(height!);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      toolbarHeight: preferredSize.height,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(2.0),
          decoration: const BoxDecoration(
              color: primaryPinkColor, shape: BoxShape.circle),
          child: IconButton(
            iconSize: 15,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: secondaryBlackColor,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
      title: CustomText(
        text: title,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: secondaryBlackColor,
      ),
      actions: <Widget>[
        if (actionTitle != null)
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Center(
              child: InkWell(
                onTap: onPressedButton,
                child: CustomText(
                  text: actionTitle!,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        if (iconButton == true)
          InkWell(
            onTap: onPressedButton,
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: CustomImage(
                  imageUrl:
                      'asset/images/icon_png/now_playing_icon/three_dot.png'),
            ),
          ),
      ],
      backgroundColor: secondaryPinkColor,
      centerTitle: true,
    );
  }
}

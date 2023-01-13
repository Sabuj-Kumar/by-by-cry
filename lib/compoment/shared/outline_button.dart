import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import 'custom_svg.dart';
import 'custom_text.dart';

class OutLineButton extends StatelessWidget {
  const OutLineButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color = primaryPinkColor,
    this.textColor = primaryWhiteColor,
    this.splashColor = Colors.transparent,
    this.borderRadius = 15,
    this.borderWidthStyle = 10.0,
    this.iconSize = 10,
    this.height = 24,
    this.width,
    this.iconColor = primaryWhiteColor,
    this.borderColor = Colors.transparent,
    this.textFontWeight = FontWeight.w500,
    this.textFontSize = 12,
    this.anotherText,
    this.anotherTextColor = secondaryBlackColor,
    this.anotherTextFontWeight = FontWeight.w400,
    this.anotherTextFontSize = 16,
    this.textPaddingVertical = 0,
    this.otherTextPaddingVertical = 0,
    this.otherTextPaddingHorizontal = 0,
    this.textPaddingHorizontal = 0
  }) : super(key: key);

  final String text;
  final String? anotherText;
  final double borderRadius;
  final double height;
  final double? width;
  final double borderWidthStyle;
  final Color color;
  final Color splashColor;
  final Color textColor;
  final Color anotherTextColor;
  final Color iconColor;
  final String? icon;
  final double iconSize;
  final VoidCallback onPressed;
  final Color borderColor;
  final FontWeight textFontWeight;
  final FontWeight anotherTextFontWeight;
  final double textFontSize;
  final double anotherTextFontSize;
  final double textPaddingVertical;
  final double otherTextPaddingVertical;
  final double textPaddingHorizontal;
  final double otherTextPaddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith(
            (states) => BorderSide(
              color: borderColor,
              width: borderWidthStyle,
            ),
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => color,
          ),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => splashColor,
          ),
        ),
        onPressed: onPressed,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: textPaddingHorizontal,vertical: textPaddingVertical),
              child: CustomText(
                text: text,
                fontWeight: textFontWeight,
                fontSize: textFontSize,
                color: textColor,
              ),
            ),
            if (anotherText != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: otherTextPaddingHorizontal,vertical: otherTextPaddingVertical),
                child: CustomText(
                  text: anotherText!,
                  fontWeight: anotherTextFontWeight,
                  fontSize: anotherTextFontSize,
                  color: anotherTextColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

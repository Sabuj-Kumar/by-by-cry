import 'package:bye_bye_cry_new/compoment/utils/color_utils.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet{

  static bottomSheet(
      BuildContext context,{
        required StatefulBuilder child,
        Color? barrierColor,
        Color? bottomSheetColor,
        double? bottomSheetHeight,
        double? bottomSheetWidth
      }){
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
      ),
      backgroundColor: primaryWhiteColor,
      isScrollControlled: true,
      context: context,
      barrierColor: barrierColor,
      builder: (context) => Container(
        color: bottomSheetColor,
        height: bottomSheetHeight,
        width: bottomSheetWidth,
        child: child,
      ),
    );
  }
}
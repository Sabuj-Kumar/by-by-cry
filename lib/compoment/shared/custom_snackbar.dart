
import 'package:bye_bye_cry_new/compoment/shared/screen_size.dart';
import 'package:flutter/material.dart';

class ShowSnackBar{

  static toastSnackBar({ required BuildContext context,required int seconds,required String text,Color color = Colors.green,Color textColor = Colors.black}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Text(text??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,fontFamily: 'CircularStd',color: textColor,),maxLines: 1,textAlign: TextAlign.center,),/*const CustomText(text: "Swipe up for next",fontWeight: FontWeight.w500,fontSize: 14,fontFamily: 'CircularStd',textColor: whiteColor,),*/
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).width * 0.15,vertical: ScreenSize(context).width * 0.24),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: seconds),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )
    );
  }
}
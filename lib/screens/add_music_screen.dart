import 'package:flutter/material.dart';

import '../compoment/shared/custom_text.dart';
import '../compoment/shared/outline_button.dart';
import '../compoment/shared/screen_size.dart';
import '../compoment/utils/color_utils.dart';

class AddMusicScreen extends StatelessWidget {
  const AddMusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = ScreenSize(context).width;

    return Row(
      children: [
        Container(
          height: width * .05,
          width: width * .05,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryPinkColor,
          ),
        ),
        const CustomText(
          text: 'Ocean + Rain',
          textAlign: TextAlign.center,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        InkWell(
          onTap: () {
            _showDialog(context);
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  scale: 2,
                  image: AssetImage(
                    'asset/images/icon_png/delete.png',
                  ),
                ),
                shape: BoxShape.circle,
                color: secondaryAwashColor),
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    final height = ScreenSize(context).height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              AlertDialog(
                title: const CustomText(
                  text: 'You have removed',
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CustomText(
                      text: 'Lawnmower + Ocean',
                      fontSize: 18,
                      color: primaryGreyColor,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'from sound list',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
                actions: <Widget>[
                  OutLineButton(
                    height: height * .05,
                    width: height * .08,
                    text: 'Ok',
                    textColor: secondaryBlackColor2,
                    textFontSize: 20,
                    textFontWeight: FontWeight.w600,
                    borderRadius: 50,
                    onPressed: () {
                      Navigator.pop(context);
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

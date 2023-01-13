
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({
    Key? key,
    required this.svg,
    this.height = 18,
    this.width = 18,
    this.color,
  }) : super(key: key);

  final String svg;
  final double height;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(svg,
      height: height,
      width: width,
      color: color,
    );
  }
}

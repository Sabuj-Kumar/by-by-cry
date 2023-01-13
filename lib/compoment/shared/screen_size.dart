import 'package:flutter/material.dart';

class ScreenSize{

  final BuildContext context;

  ScreenSize(this.context);

  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;
  bool get landScape => MediaQuery.of(context).orientation == Orientation.landscape;
}
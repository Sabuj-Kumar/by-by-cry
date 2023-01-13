import 'package:flutter/material.dart';

import '../../screens/sound_edit_screen.dart';

class Navigation {
  static navigatePages(BuildContext context, Widget pages) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pages),
    );
  }
}

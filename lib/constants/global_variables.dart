import 'dart:io';

import 'package:flutter/material.dart';

String uri =
    Platform.isAndroid ? 'http://192.168.2.178:3000' : 'http://localhost:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  //static const secondaryColor = Colors.green;
  static const secondaryColor = Color(0xff7AB41D);

  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const selectedNavBarColor = Color(0xff006331);
  static const unselectedNavBarColor = Colors.black87;
  static const blue = Color(0xff0085CA);
  static const buttonColor = Color(0xff006331);
}

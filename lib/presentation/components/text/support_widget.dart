import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors/colors.dart';

class AppText {
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
      color: textPrimary,
      fontSize: 38.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Outfit',
    );
  }

  static TextStyle lightTextFieldStyle() {
    return TextStyle(
      color: textSecondary,
      fontFamily: 'Outfit',
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBoldTextFieldStyle() {

    return TextStyle(
      color: textPrimary,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Outfit',
    );
  }


  static TextStyle WithShadoSemiBoldTextFieldStyle() {
    return TextStyle(

      color: textPrimary,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Outfit',
      shadows: [
        Shadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],

    );
  }

  static TextStyle SmalllightTextFieldStyle() {
    return TextStyle(
      color: Colors.black.withValues(alpha: 1),
      fontFamily: 'Outfit',
      fontSize: 15,
      fontWeight: FontWeight.w500,
      shadows: [
        Shadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

}


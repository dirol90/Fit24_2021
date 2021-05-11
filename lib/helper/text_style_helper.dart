
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/material.dart';

enum TextStyleColors{darkBlack, black, white, grey, darkGrey, orange, violet, darkText, spaceGrey}

class TextStyleBuilder{

  static TextStyle textStyleBuilder(int fontSize, int fontWeight, /*int fontHeight,*/ TextStyleColors color, FontStyle fStyle, BuildContext context, {bool isUnderline = false}){

    var textColor;

    switch (color) {
      case TextStyleColors.darkBlack:
        textColor = Color(0xFF000000);
        break;
      case TextStyleColors.black:
        textColor = Color(0xFF161616);
        break;
      case TextStyleColors.white:
        textColor = Color(0xFFFFFFFF);
        break;
      case TextStyleColors.grey:
        textColor = Color(0xFFC4C4C4);
        break;
      case TextStyleColors.darkGrey:
        textColor = Color(0xFF999999);
        break;
      case TextStyleColors.orange:
        textColor = Color(0xFFFF6B4A);
        break;
      case TextStyleColors.violet:
        textColor = Color(0xFF5C4AED);
        break;
      case TextStyleColors.darkText:
      textColor =  Color(0xFF1D1D1D);
      break;
      case TextStyleColors.spaceGrey:
        textColor =  Color(0xFFC1C1CB);
        break;
      default:
        textColor = Color(0xFF000000);
            break;
    }

    var fw;
    switch(fontWeight) {
      case 100 : fw = FontWeight.w100; break;
      case 200 :fw = FontWeight.w200; break;
      case 300 :fw = FontWeight.w300; break;
      case 400 :fw = FontWeight.w400; break;
      case 500 :fw = FontWeight.w500; break;
      case 600 :fw = FontWeight.w600; break;
      case 700 :fw = FontWeight.w700; break;
      case 800 :fw = FontWeight.w800; break;
      case 900 :fw = FontWeight.w900; break;
      default: fw = FontWeight.normal; break;
    }

    return TextStyle(decoration: isUnderline ? TextDecoration.underline : TextDecoration.none, fontSize: fontSize.toDouble()*UIScaler.getUiScaleFactor(context), fontWeight: fw,/* height: fontHeight.toDouble(),*/ color: textColor, fontStyle: fStyle, fontFamily: 'Rubik-Regular');
  }



}
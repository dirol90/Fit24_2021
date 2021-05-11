import 'dart:math';

import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserQuestionnaireScreen3 extends StatefulWidget {
  static const String routName = '/UserQuestionnaireScreen3';
  static var isColdBoot = true;

  Function f;

  UserQuestionnaireScreen3({this.f});

  @override
  _UserQuestionnaireScreen3State createState() =>
      _UserQuestionnaireScreen3State();
}

class _UserQuestionnaireScreen3State extends State<UserQuestionnaireScreen3> {


  var percent = 0.0;
  var indexing = -1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //SystemChrome.setEnabledSystemUIOverlays([]);

    if (UserQuestionnaireScreen3.isColdBoot) {
      UserQuestionnaireScreen3.isColdBoot = false;
      changeMaterials();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                  height: MediaQuery.of(context).size.width/3*2.25,
                  width: MediaQuery.of(context).size.width/3*2.25,
                  child: FlareActor("assets/animated/anim.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "01d")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Align(
              alignment: Alignment.center,
              child: percent < 100.0 ? Text(
                '${percent.toStringAsFixed(0)}%',
                style: TextStyleBuilder.textStyleBuilder(28, 500, TextStyleColors.white, FontStyle.normal, context),
              ) : Image.asset('assets/img/big_ok.png', height: 45, width: 58,),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                height: 152*UIScaler.getUiScaleFactor(context),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Calculating \n ${indexing == -1 ? 'your basal metabolic rate...' :
                        indexing == 0 ? 'your daily calorie needs...' :
                        indexing == 1 ? 'your body mass index...' :
                        'your personal workout plan...'
                        }',
                        style: TextStyleBuilder.textStyleBuilder(21, 600, TextStyleColors.darkText, FontStyle.normal, context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: percent == 0.0 ? widgetCreateTextBlock(indexing++)
                          : percent == 15.0 ? widgetCreateTextBlock(indexing++)
                          : percent == 50.0 ? widgetCreateTextBlock(indexing++)
                          : percent == 80.0 ? widgetCreateTextBlock(indexing++)
                          : widgetCreateTextBlock(indexing),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetCreateTextBlock (int indexing){

    switch (indexing) {
      case 0 : {

        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your daily calorie needs...',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Your body mass index...',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Setting up your personal workout plan...',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
//              Text(
//                'Your basal metabolic rate',
//                style:
//                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal),
//                textAlign: TextAlign.center,
//              ),
            ],
          ),
        );
      }
      case 1 : {

        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              Text(
//                'Your daily calorie needs...',
//                style:
//                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal),
//                textAlign: TextAlign.center,
//              ),
              Text(
                'Your body mass index...',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Setting up your personal workout plan...',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Your basal metabolic rate',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.orange, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
      case 2 : {
//        textColor2 = TextStyleColors.orange;

        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

//              Text(
//                'Your body mass index...',
//                style:
//                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal),
//                textAlign: TextAlign.center,
//              ),
              Text(
                'Setting up your personal workout plan...',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Your basal metabolic rate',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.orange, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Your daily calorie needs',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.orange, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
      default: {

        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

//            Text(
//              'Setting up your personal workout plan...',
//              style:
//              TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.grey, FontStyle.normal),
//              textAlign: TextAlign.center,
//            ),
              Text(
                'Your basal metabolic rate',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.orange, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Your daily calorie needs',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.orange, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
              Text(
                'Your body mass index',
                style:
                TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.orange, FontStyle.normal, context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );}
    }


  }

  void changeMaterials() {
    Future.delayed(Duration(milliseconds: Random().nextInt(100)), () {
      setState(() {
        if (percent <= 100.0) {
          percent += 1.0;
          changeMaterials();
        } else {
//          textColor3 = TextStyleColors.orange;
        }
      });
    });
  }
}

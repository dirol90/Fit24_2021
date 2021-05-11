
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/info_arguments.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'extra_info_screen.dart';

class VideoSplashScreen extends StatelessWidget {
  static const String routName = '/VideoSplashScreen';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //SystemChrome.setEnabledSystemUIOverlays([]);

      return Scaffold(
        body: Stack(children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height + 100,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayerScreen('assets/video/bg_vide_start.mp4', false, -1.0, -1.0)),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 128),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40.0*UIScaler.getUiScaleFactor(context),
                  child: RaisedButton(
                    color: Color(0xffFF6B4A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Theme.of(context).accentColor)),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(UserRegistrationController.routName);
                    },
                    child: Text(
                      "START".toUpperCase(),
                      style: TextStyleBuilder.textStyleBuilder(15, 500, TextStyleColors.white, FontStyle.normal, context),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.only(left: 48.0*UIScaler.getUiScaleFactor(context), right: 48.0*UIScaler.getUiScaleFactor(context)),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 52),
                  child: Container(
                    height: 75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('By pressing Start, you agree to',
                            style: TextStyleBuilder.textStyleBuilder(14, 400, TextStyleColors.white, FontStyle.normal, context),
                          ),
                        ],),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Fit and Ripped 24\'s',
                              style: TextStyleBuilder.textStyleBuilder(14, 400, TextStyleColors.white, FontStyle.normal, context),
                            ),
                          ],),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed(
                                  ExtraInfoScreen.routName,
                                  arguments:
                                  ScreenArguments(2),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Terms of Use',
                                style: TextStyleBuilder.textStyleBuilder(16, 600, TextStyleColors.white, FontStyle.normal, context, isUnderline: true)
                          ),
                              ),
                            ),
                            Text(' and ',
                            style: TextStyleBuilder.textStyleBuilder(14, 400, TextStyleColors.white, FontStyle.normal, context)
                          ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed(
                                  ExtraInfoScreen.routName,
                                  arguments:
                                  ScreenArguments(3),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Privacy Policy',
                                style: TextStyleBuilder.textStyleBuilder(16, 600, TextStyleColors.white, FontStyle.normal, context, isUnderline: true)
                          ),
                              ),
                            ),
                          ],),
                      ],
                    ),
                  )
                ),
              ),
            ),
          ),
        ]),
    );
  }
}

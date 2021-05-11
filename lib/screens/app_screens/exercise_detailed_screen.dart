import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExerciseDetailed extends StatelessWidget {
  static const String routName = '/ExerciseDetailed';
  var vFileName = '';
  Function f;

  ExerciseDetailed({this.vFileName, this.f});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffFF6B4A),
      // screens.navigation bar color
      statusBarColor: Color(0xffFF6B4A), // status bar color
    ));

    var player =
        VideoPlayerScreen('assets/video/$vFileName.mp4', true, -1.0, -1.0);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Align(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: player),
            ),
          ),
          GestureDetector(
              onTap: () {
                f();
              },
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2 -
                        MediaQuery.of(context).size.width / 2 +
                        16,
                    left: 32 * UIScaler.getUiScaleFactor(context)),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(29, 29, 29, 0.25),
                          borderRadius: BorderRadius.all(Radius.circular(
                              4.0 * UIScaler.getUiScaleFactor(context))),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 32 * UIScaler.getUiScaleFactor(context),
                        ))),
              )),
        ],
      ),
    );
  }
}

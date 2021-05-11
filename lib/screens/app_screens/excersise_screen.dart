import 'dart:async';
import 'dart:math';

import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/exercise_base.dart';
import 'package:Fit24/model/static_exercises_list.dart';
import 'package:Fit24/model/training_base.dart';
import 'package:Fit24/screens/screeen_holder/screen_main_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';

import 'exercise_done.dart';

class TrainingStartScreen extends StatefulWidget {
  static const String routName = '/WarmUpScreen';
  final TrainingBase training;
  final Training trainingDB;

  TrainingStartScreen({this.training, this.trainingDB});

  @override
  _TrainingStartScreenState createState() => _TrainingStartScreenState();
}

class _TrainingStartScreenState extends State<TrainingStartScreen>
    with WidgetsBindingObserver {
  IconData btnIcon = Icons.pause;

  var isClosePressed = false;
  var isShowTimer = false;
  var isPausePressed = false;
  var isMutePressed = false;

  var isExitPressedFromAlert = false;

  List currentWorkExercisesList;
  List currentWorkExercisesTimeList;
  var currentExerciseIndex = 0;
  var totalExerciseIndex = 0;

  ExerciseBase currentExercise;
  var tc = -1;
  var tcMainPartFullTime = -1;

  Timer tMain;
  Timer tExercise;
  Timer tMainExercisesGroup;

  var totalTime = 0;
  var startTrainingCounter = 6;
  var trainingText = 'Start Warm-up?';
  var btnText = 'START';

  var listOrderIndex = 0;
  var isRestTime = false;

  ScrollController _controller;
  double scrollStopPos = 0;
  bool programicalyScrolled = false;
  bool isTimerStart = false;
  var startBtnPressed = false;
  bool rightDirection = true;

  bool isSkipPressed = true;

  TrainingDao _t_dao;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()
      ..addListener(() {
        rightDirection =
            _controller.position.userScrollDirection == ScrollDirection.forward;

        if (isPausePressed || isRestTime) {
          _controller
              .animateTo(
            totalExerciseIndex * MediaQuery.of(context).size.width,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 125),
          )
              .then((_) {
            programicalyScrolled = false;
          });
        } else {
          if (scrollStopPos == 0 && !isTimerStart) {
            programicalyScrolled = true;
            _controller
                .animateTo(
              scrollStopPos,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 125),
            )
                .then((_) {
              programicalyScrolled = false;
            });
          } else if (rightDirection) {
            programicalyScrolled = true;
            _controller
                .animateTo(
              scrollStopPos,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 125),
            )
                .then((_) {
              programicalyScrolled = false;
            });
          } else if (!programicalyScrolled && !rightDirection) {
            /**tc = 0;
                scrollStopPos = (totalExerciseIndex)  * MediaQuery
                .of(context)
                .size
                .width;
             **/
            _controller
                .animateTo(
              scrollStopPos,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 0),
            )
                .then((_) {
              programicalyScrolled = true;
            });
          }
        }
      });

    WidgetsBinding.instance.addObserver(this);
  }

  var prevExercise;
  var perSideText;

  @override
  Widget build(BuildContext context) {
    Screen.setBrightness(0.8);
    Screen.keepOn(true);

    if (_t_dao == null) {
      _t_dao = Provider.of<TrainingDao>(context);
    }

    currentWorkExercisesList == null
        ? currentWorkExercisesList =
            widget.training.trainingStartExerciseIdsList
        : currentWorkExercisesList = currentWorkExercisesList;
    currentWorkExercisesTimeList == null
        ? currentWorkExercisesTimeList =
            widget.training.trainingStartExerciseTimeList
        : currentWorkExercisesTimeList = currentWorkExercisesTimeList;

    currentExercise = StaticExercisesList.getExerciseById(
        currentWorkExercisesList[currentExerciseIndex]);
    tc == -1
        ? tc = currentWorkExercisesTimeList[currentExerciseIndex]
        : tc = tc;
    if (currentExercise != prevExercise &&
        currentExercise.exerciseExtraWords != '') {
      prevExercise = currentExercise;
      perSideText = tc / 2 >= 1000
          ? '${tc / 2 / 1000.toInt() > 60 ? '${tc / 2 / 1000.toInt() ~/ 60} min : ${tc / 2 ~/ 1000 % 60} sec' : '${tc / 2 ~/ 1000} sec'}'
          : tc > 0 ? '${tc ~/ 2} times' : '';
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  ListView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: generateWidgetsList(),
                  ),
                  isShowTimer ? timerDialog(context) : Container(),
                ],
              )),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 56.0 * UIScaler.getUiScaleFactor(context),
                      left: 16.0 * UIScaler.getUiScaleFactor(context),
                      right: 16.0 * UIScaler.getUiScaleFactor(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isClosePressed = !isClosePressed;
                            isPausePressed = true;
                            if (isPausePressed) {
                              btnIcon = Icons.play_arrow;
                            } else {
                              btnIcon = Icons.pause;
                            }
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF1D1D1D),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            width: 32 * UIScaler.getUiScaleFactor(context),
                            height: 32 * UIScaler.getUiScaleFactor(context),
                            child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 16,), ),
                      ),
//                      GestureDetector(
//                        onTap: () {
//                          if (startBtnPressed) {
//                            setState(() {
//                              isPausePressed = !isPausePressed;
//                              if (isPausePressed) {
//                                btnIcon = Icons.play_arrow;
//                              } else {
//                                btnIcon = Icons.pause;
//                              }
//                            });
//                          }
//                        },
//                        child: Container(
//                            decoration: BoxDecoration(
//                                color: !startBtnPressed
//                                    ? Colors.white
//                                    : Color(0xFFF6F6F8),
//                                borderRadius:
//                                    BorderRadius.all(Radius.circular(4.0))),
//                            width: 32 * UIScaler.getUiScaleFactor(context),
//                            height: 32 * UIScaler.getUiScaleFactor(context),
//                            child:
//                                !startBtnPressed ? Container() : Icon(btnIcon)),
//                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMutePressed = !isMutePressed;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF1D1D1D),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              width: 32 * UIScaler.getUiScaleFactor(context),
                              height: 32 * UIScaler.getUiScaleFactor(context),
                              child: Icon(Icons.volume_up, color: Colors.white, size: 16,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: 32.0),
                  child: Container(
                    height: 464,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            !isShowTextOnCard
                                ? Container()
                                : Container(
//                        height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    trainingText,
                                    style: TextStyleBuilder.textStyleBuilder(
                                      24,
                                      500,
                                      TextStyleColors.darkBlack,
                                      FontStyle.normal,
                                      context,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Container(
                                      height: 40 * UIScaler.getUiScaleFactor(context),
                                      width: 132 * UIScaler.getUiScaleFactor(context),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0 *
                                                UIScaler.getUiScaleFactor(context)),
                                            side: BorderSide(
                                                color: Theme.of(context).buttonColor)),
                                        child: Text(
                                          btnText,
                                          style: TextStyleBuilder.textStyleBuilder(
                                              15,
                                              500,
                                              TextStyleColors.white,
                                              FontStyle.normal,
                                              context),
                                        ),
                                        onPressed: () {
                                          if (!isRestTime) isShowTextOnCard = false;
                                          playLogic();
                                          setState(() {
                                            startBtnPressed = true;
                                            if (trainingText != 'Start Warm-up?'){
                                              isPausePressed = false;
                                            }
                                          });
                                        },
                                        color: Theme.of(context).buttonColor,
                                      ),
                                    ),
                                  ),
                                  trainingText == 'Rest time'
                                      ? Text(
                                    'Next exercise:',
                                    style: TextStyleBuilder.textStyleBuilder(
                                        14,
                                        500,
                                        TextStyleColors.white,
                                        FontStyle.normal,
                                        context),
                                  )
                                      : Container(),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        8.0 * UIScaler.getUiScaleFactor(context)),
                                    child: trainingText == 'Rest time'
                                        ? Text(
                                      '${currentWorkExercisesList.length > currentExerciseIndex + 1 ? '${StaticExercisesList.getExerciseById(currentWorkExercisesList[currentExerciseIndex + 1]).exerciseName} '
                                          ' ${currentWorkExercisesTimeList[currentExerciseIndex + 1] >= 1000 ? '${tc ~/ 1000 > 60 ? '${currentWorkExercisesTimeList[currentExerciseIndex + 1] / 1000.toInt() ~/ 60} : ${currentWorkExercisesTimeList[currentExerciseIndex + 1] ~/ 1000 % 60}' : '${currentWorkExercisesTimeList[currentExerciseIndex + 1] ~/ 1000} sec'}' : currentWorkExercisesTimeList[currentExerciseIndex + 1] > 0 ? 'Х ${currentWorkExercisesTimeList[currentExerciseIndex + 1]}' : 'Done'}' : StaticExercisesList.getExerciseById(widget.training.trainingEndExerciseIdsList[0]).exerciseName}',
                                      style: TextStyleBuilder.textStyleBuilder(
                                          24,
                                          500,
                                          TextStyleColors.white,
                                          FontStyle.normal,
                                          context),
                                      textAlign: TextAlign.center,
                                    )
                                        : Container(),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 164 * UIScaler.getUiScaleFactor(context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Time Elapsed',
                                    style: TextStyleBuilder.textStyleBuilder(
                                        14,
                                        400,
                                        TextStyleColors.darkBlack,
                                        FontStyle.normal,
                                        context),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 4 *
                                            UIScaler.getUiScaleFactor(context),
                                        bottom: 4.0 *
                                            UIScaler.getUiScaleFactor(context),),
                                    child: Text(
                                      totalTime == 0 ? '00:00' :'${totalTime~/60000 < 10 ? '0${totalTime~/60000 }' : '${totalTime~/60000 }'}:${(totalTime%60000)~/1000 < 10 ? '0${(totalTime%60000)~/1000}' : '${(totalTime%60000)~/1000}' } ',
                                      style: TextStyleBuilder.textStyleBuilder(
                                          20,
                                          600,
                                          TextStyleColors.orange,
                                          FontStyle.normal,
                                          context),
                                    ),
                                  ),
                                  currentExercise.exerciseExtraWords != '' && !isRestTime
                                      ? Container(
//                  height: 20,
                                    child: Center(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text(
                                          '$perSideText ${currentExercise.exerciseExtraWords}',
                                          style: TextStyleBuilder.textStyleBuilder(
                                              16,
                                              600,
                                              TextStyleColors.darkBlack,
                                              FontStyle.normal,
                                              context),
                                        ),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 2, 16, 2),
                                      child: SizedBox(
                                        height: 28 * UIScaler.getUiScaleFactor(context),
                                        child: Text(
                                          '${!isRestTime ? currentExercise.exerciseName : 'Rest'}',
                                          textAlign: TextAlign.center,
                                          style: TextStyleBuilder.textStyleBuilder(
                                              20,
                                              600,
                                              TextStyleColors.darkBlack,
                                              FontStyle.normal,
                                              context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                      child: Text(
                                        '${tc >= 1000 ? '${tc / 1000.toInt() > 60 ? '${tc / 1000.toInt() ~/ 60} min : ${tc ~/ 1000 % 60} sec' : '${tc ~/ 1000} sec'}' : tc > 0 ? '$tc times' : 'Done'}',
                                        style: TextStyleBuilder.textStyleBuilder(
                                            20,
                                            600,
                                            TextStyleColors.darkBlack,
                                            FontStyle.normal,
                                            context),
                                      ),
                                    ),
                                  ),
//                              !isSkipPressed &&
//                                  startBtnPressed &&
//                                  (startTrainingCounter == 6 ||
//                                      startTrainingCounter == 0)
//                                  ? Container(
//                                height: 28 * UIScaler.getUiScaleFactor(context),
//                                width: 132 * UIScaler.getUiScaleFactor(context),
//                                child: RaisedButton(
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(30.0 *
//                                          UIScaler.getUiScaleFactor(context)),
//                                      side: BorderSide(
//                                          color: Theme.of(context).buttonColor)),
//                                  child: Text(
//                                    'NEXT >',
//                                    style: TextStyleBuilder.textStyleBuilder(
//                                        15,
//                                        500,
//                                        TextStyleColors.white,
//                                        FontStyle.normal,
//                                        context),
//                                  ),
//                                  onPressed: () {
//                                    setState(() {
//                                      isSkipPressed = true;
//                                      tc = 0;
//                                    });
//                                  },
//                                  color: Theme.of(context).buttonColor,
//                                ),
//                              )
//                                  : Container(),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 8.0*UIScaler.getUiScaleFactor(context), bottom: 8.0*UIScaler.getUiScaleFactor(context), left: 8.0*UIScaler.getUiScaleFactor(context), right: 8.0*UIScaler.getUiScaleFactor(context)),
                              child: Center(
                                child: LinearPercentIndicator(
                                  percent: !isRestTime && currentWorkExercisesList != null ? (currentExerciseIndex / currentWorkExercisesList.length) : 0,
                                  progressColor: Theme
                                      .of(context)
                                      .accentColor,
                                  backgroundColor: Color(0xFFF6F6F8),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width-32,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if (startBtnPressed) {
                                          setState(() {
                                            isPausePressed = !isPausePressed;
                                            if (isPausePressed) {
                                              btnIcon = Icons.play_arrow;
                                            } else {
                                              btnIcon = Icons.pause;
                                            }
                                          });
                                        }
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'pause'.toUpperCase(),
                                            style: TextStyleBuilder.textStyleBuilder(
                                                15,
                                                500,
                                                TextStyleColors.darkBlack,
                                                FontStyle.normal,
                                                context),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF1D1D1D),
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(4.0))),
                                              width: 32 * UIScaler.getUiScaleFactor(context),
                                              height: 32 * UIScaler.getUiScaleFactor(context),
                                              child: Icon(Icons.pause, color: Colors.white, size: 16,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSkipPressed = true;
                                          tc = 0;
                                        });
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'next'.toUpperCase(),
                                            style: TextStyleBuilder.textStyleBuilder(
                                                15,
                                                500,
                                                TextStyleColors.darkBlack,
                                                FontStyle.normal,
                                                context),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF1D1D1D),
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(32.0))),
                                              width: 32 * UIScaler.getUiScaleFactor(context),
                                              height: 32 * UIScaler.getUiScaleFactor(context),
                                              child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 4.0 * UIScaler.getUiScaleFactor(context),
                                  bottom: 28 * UIScaler.getUiScaleFactor(context)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F8),
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      4.0 * UIScaler.getUiScaleFactor(context))),
                                ),
                                height: 80 * UIScaler.getUiScaleFactor(context),
                                width: MediaQuery.of(context).size.width / 2 - 32,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.0 * UIScaler.getUiScaleFactor(context),
                                          left:
                                          12 * UIScaler.getUiScaleFactor(context)),
                                      child: Text(
                                        (listOrderIndex == 1 && tcMainPartFullTime > 0)
                                            ? 'Timer'
                                            : 'Exercises Completed',
                                        style: TextStyleBuilder.textStyleBuilder(
                                            14,
                                            500,
                                            TextStyleColors.orange,
                                            FontStyle.normal,
                                            context),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 4 *
                                                  UIScaler.getUiScaleFactor(context),
                                              bottom: 11.0 *
                                                  UIScaler.getUiScaleFactor(context),
                                              left: 11.0 *
                                                  UIScaler.getUiScaleFactor(context)),
                                          child: Text(
                                            (listOrderIndex == 1 &&
                                                tcMainPartFullTime > 0)
                                                ? '${(tcMainPartFullTime / 1000 ~/ 60).toString()} : ${(tcMainPartFullTime % 60000 ~/ 1000).toString()}'
                                                : '$currentExerciseIndex / ${currentWorkExercisesList.length}',
                                            style: TextStyleBuilder.textStyleBuilder(
                                                16,
                                                400,
                                                TextStyleColors.black,
                                                FontStyle.normal,
                                                context),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 4 *
                                                  UIScaler.getUiScaleFactor(context),
                                              bottom: 11.0 *
                                                  UIScaler.getUiScaleFactor(context),
                                              right: 11.0 *
                                                  UIScaler.getUiScaleFactor(context)),
                                          child: Container(
                                              height: 20 *
                                                  UIScaler.getUiScaleFactor(context),
                                              child: Image.asset(
                                                'assets/img/exercise_complited.png',
                                                height: 24 *
                                                    UIScaler.getUiScaleFactor(context),
                                                width: 24 *
                                                    UIScaler.getUiScaleFactor(context),
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 4.0 * UIScaler.getUiScaleFactor(context),
                                  bottom: 28 * UIScaler.getUiScaleFactor(context)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F8),
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                ),
                                height: 80 * UIScaler.getUiScaleFactor(context),
                                width: MediaQuery.of(context).size.width / 2 - 32,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.0 * UIScaler.getUiScaleFactor(context),
                                          left:
                                          12 * UIScaler.getUiScaleFactor(context)),
                                      child: Text(
                                        'Calories',
                                        style: TextStyleBuilder.textStyleBuilder(
                                            18,
                                            500,
                                            TextStyleColors.orange,
                                            FontStyle.normal,
                                            context),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 4 *
                                                  UIScaler.getUiScaleFactor(context),
                                              bottom: 11.0 *
                                                  UIScaler.getUiScaleFactor(context),
                                              left: 11.0 *
                                                  UIScaler.getUiScaleFactor(context)),
                                          child: Text(
                                            '${isTimerStart ? widget.training.trainingCalories : 0}',
                                            style: TextStyleBuilder.textStyleBuilder(
                                                16,
                                                400,
                                                TextStyleColors.black,
                                                FontStyle.normal,
                                                context),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 4 *
                                                  UIScaler.getUiScaleFactor(context),
                                              bottom: 11.0 *
                                                  UIScaler.getUiScaleFactor(context),
                                              right: 11.0 *
                                                  UIScaler.getUiScaleFactor(context)),
                                          child: Container(
                                              height: 20 *
                                                  UIScaler.getUiScaleFactor(context),
                                              child: Image.asset(
                                                'assets/img/callories_img.png',
                                                height: 2 *
                                                    UIScaler.getUiScaleFactor(context),
                                                width: 24 *
                                                    UIScaler.getUiScaleFactor(context),
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

//                Center(
//                  child: Padding(
//                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
//                    child: Text(
//                      '< Swipe left to skip',
//                      style: TextStyleBuilder.textStyleBuilder(
//                          16, 500, TextStyleColors.black, FontStyle.normal),
//                    ),
//                  ),
//                ),

              ],
            ),
          ),
          isClosePressed ? closeDialog(context) : Container(),
        ],
      ),
    );
  }



  var isExitFromWorkoutBody = false;
  Widget closeDialog(BuildContext context) {
    if (!startBtnPressed && !isExitFromWorkoutBody) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => MainScreenHolder()),
            ModalRoute.withName(MainScreenHolder.routName));
        tMain.cancel();
      });

      return Container();
    } else {
      return Container(
        color: Color.fromRGBO(22, 22, 22, 0.78),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: !isExitPressedFromAlert
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Are you sure you want\nto quit workout?',
                    style: TextStyleBuilder.textStyleBuilder(24, 600,
                        TextStyleColors.white, FontStyle.normal, context),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                    child: Container(
                      height: 40 * UIScaler.getUiScaleFactor(context),
                      width: 250 * UIScaler.getUiScaleFactor(context),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).buttonColor)),
                        child: Text(
                          'Quit workout',
                          style: TextStyleBuilder.textStyleBuilder(15, 500,
                              TextStyleColors.white, FontStyle.normal, context),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          setState(() {
                            isExitPressedFromAlert = !isExitPressedFromAlert;
                          });
                        },
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 40 * UIScaler.getUiScaleFactor(context),
                      width: 250 * UIScaler.getUiScaleFactor(context),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).buttonColor)),
                        child: Text(
                          'Quit and mark done',
                          style: TextStyleBuilder.textStyleBuilder(15, 500,
                              TextStyleColors.white, FontStyle.normal, context),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () async {

                          var training =
                              widget.trainingDB.copyWith(isDone: true);
                          if (training.userWeightAfterTraining == null) {
                            training = training.copyWith(
                                userWeightAfterTraining: '0.0');
                          }
                          _t_dao.updateTraining(training).then((_) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ExerciseDoneScreen(
                                            training: widget.trainingDB,
                                            setsDone: totalExerciseIndex,
                                            totalSetsForDone: widget
                                                    .training
                                                    .trainingStartExerciseIdsList
                                                    .length +
                                                 widget
                                                    .training
                                                    .trainingMainExerciseIdsList
                                                    .length +
                                         widget
                                                    .training
                                                    .trainingEndExerciseIdsList
                                                    .length,
                                            kkalSpent: widget.training.trainingCalories,
                                            timeSpent: totalTime)),
                                ModalRoute.withName(
                                    ExerciseDoneScreen.routName));
                          });

//                  setState(() {
//                    isExitPressedFromAlert =
//                    !isExitPressedFromAlert;
//                  });
                        },
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        8.0 * UIScaler.getUiScaleFactor(context)),
                    child: Container(
                      height: 40 * UIScaler.getUiScaleFactor(context),
                      width: 250 * UIScaler.getUiScaleFactor(context),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).buttonColor)),
                        child: Text(
                          'Continue workout',
                          style: TextStyleBuilder.textStyleBuilder(15, 500,
                              TextStyleColors.white, FontStyle.normal, context),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          setState(() {
                            isClosePressed = !isClosePressed;
                            if (!isExitFromWorkoutBody){
                            if (isPausePressed) isPausePressed = false;
                            if (isPausePressed) {
                              btnIcon = Icons.play_arrow;
                            } else {
                              btnIcon = Icons.pause;
                            }} else {
                              isShowTimer = false;
                            }
                          });
                        },
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Why are you quitting?',
                    style: TextStyleBuilder.textStyleBuilder(24, 600,
                        TextStyleColors.white, FontStyle.normal, context),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                    child: Container(
                      height: 40 * UIScaler.getUiScaleFactor(context),
                      width: 250 * UIScaler.getUiScaleFactor(context),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).buttonColor)),
                        child: Text(
                          'Too easy',
                          style: TextStyleBuilder.textStyleBuilder(15, 500,
                              TextStyleColors.white, FontStyle.normal, context),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreenHolder()),
                                ModalRoute.withName(MainScreenHolder.routName));
                            tMain.cancel();
                          });
                        },
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40 * UIScaler.getUiScaleFactor(context),
                      width: 250 * UIScaler.getUiScaleFactor(context),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).buttonColor)),
                        child: Text(
                          'Too hard',
                          style: TextStyleBuilder.textStyleBuilder(15, 500,
                              TextStyleColors.white, FontStyle.normal, context),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreenHolder()),
                                ModalRoute.withName(MainScreenHolder.routName));
                            tMain.cancel();
                          });
                        },
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40 * UIScaler.getUiScaleFactor(context),
                      width: 250 * UIScaler.getUiScaleFactor(context),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).buttonColor)),
                        child: Text(
                          'Will do it later',
                          style: TextStyleBuilder.textStyleBuilder(15, 500,
                              TextStyleColors.white, FontStyle.normal, context),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreenHolder()),
                                ModalRoute.withName(MainScreenHolder.routName));
                            tMain.cancel();
                          });
                        },
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40 * UIScaler.getUiScaleFactor(context),
                      width: 250 * UIScaler.getUiScaleFactor(context),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Theme.of(context).buttonColor)),
                        child: Text(
                          'Another reason',
                          style: TextStyleBuilder.textStyleBuilder(15, 500,
                              TextStyleColors.white, FontStyle.normal, context),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreenHolder()),
                                ModalRoute.withName(MainScreenHolder.routName));
                            tMain.cancel();
                          });
                        },
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                ],
              ),
      );
    }
  }

  Widget timerDialog(BuildContext context) {
    return Container(
      color: Color.fromRGBO(22, 22, 22, 0.78),
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          startTrainingCounter > 0 ? startTrainingCounter.toString() : 'START',
          style: TextStyleBuilder.textStyleBuilder(
              92, 500, TextStyleColors.white, FontStyle.normal, context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  var isMoveToNext = true;

  void playLogic() async {
    if (btnText == '+ 20 sec') {
      tc += 20000;
    }

    if (tMain == null) {
      tMain = Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
        if (!isPausePressed) {
          totalTime += 1000;
          if (totalTime % 60000 == 0) {
            setState(() {
              widget.training.trainingCalories += 7 + Random().nextInt(3);
            });
          }
        }
      });

      tExercise = Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
        isShowTimer = false;

        if (!isPausePressed) {
          if (startTrainingCounter > 0) {
            startTrainingCounter--;
            isShowTimer = true;
            setState(() {
              if (startTrainingCounter == 1) {
                isSkipPressed = false;
              }
            });
          } else {
            if (tc > 999) {
              if (!isMoveToNext) {
                isMoveToNext = true;
                totalExerciseIndex -= 1;
              }

              isTimerStart = true;
              tc -= 1000;
              if (tcMainPartFullTime > 0) tcMainPartFullTime -= 1000;
              setState(() {});
            } else if (tc > 0) {
              if (!isMoveToNext) {
                isMoveToNext = true;
                totalExerciseIndex -= 1;
              }

              isTimerStart = true;
              if (tcMainPartFullTime > 0) tcMainPartFullTime -= 1000;
              setState(() {});
            } else if ((tc <= 0) &&
                !isRestTime &&
                listOrderIndex != 0 &&
                listOrderIndex != 2) {
              isRestTime = true;
              tc = widget.training.restTime;
              if (tc > 0) {
                if (isMoveToNext) {
                  isMoveToNext = false;
                  totalExerciseIndex += 1;
                  scrollStopPos =
                      totalExerciseIndex * MediaQuery.of(context).size.width;
                  programicalyScrolled = true;
                  _controller
                      .animateTo(
                    scrollStopPos,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 125),
                  )
                      .then((_) {
                    programicalyScrolled = false;
                  });
                }

                trainingText = 'Rest time';
                btnText = '+ 20 sec';
                setState(() {
                  isShowTextOnCard = true;
                  isSkipPressed = false;
                });
              }
            } else if (totalExerciseIndex <
                widget.training.trainingStartExerciseIdsList.length +
                    widget.training.trainingMainExerciseIdsList.length +
                    widget.training.trainingEndExerciseIdsList.length -
                    1) {
              isShowTextOnCard = false;
              isRestTime = false;
              startTrainingCounter = 6;

              currentExerciseIndex += 1;
              totalExerciseIndex += 1;

              scrollStopPos =
                  totalExerciseIndex * MediaQuery.of(context).size.width;
              programicalyScrolled = true;
              _controller
                  .animateTo(
                scrollStopPos,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 125),
              )
                  .then((_) {
                programicalyScrolled = false;
              });

              tc = -1;
              startTrainingCounter = 6;
              setState(() {});
            } else {
              isShowTextOnCard = false;
              isRestTime = false;
              startTrainingCounter = 6;

              totalExerciseIndex += 1;
              scrollStopPos =
                  totalExerciseIndex * MediaQuery.of(context).size.width;
              programicalyScrolled = true;
              _controller
                  .animateTo(
                scrollStopPos,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 125),
              )
                  .then((_) {
                programicalyScrolled = false;
              });

              tExercise?.cancel();
              setState(() {});
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => ExerciseDoneScreen(
                          training: widget.trainingDB,
                          setsDone: totalExerciseIndex,
                          totalSetsForDone: widget.training.trainingStartExerciseIdsList.length +
                              widget
                                  .training.trainingMainExerciseIdsList.length +
                              widget.training.trainingEndExerciseIdsList.length,
                          kkalSpent: widget.training.trainingCalories,
                          timeSpent: totalTime)),
                  ModalRoute.withName(ExerciseDoneScreen.routName));
              tMain.cancel();
            }
          }
        }

        if (currentExerciseIndex == currentWorkExercisesList.length &&
            tcMainPartFullTime <= 0) {
          if (listOrderIndex == 0) {

            //TODO: app fix closing with dialog
            setState(() {
              isExitFromWorkoutBody = true;
              isPausePressed = true;
              startBtnPressed = false;
              trainingText = 'Warm-up completed\n     Start Workout?';
              btnText = 'START';
              isShowTextOnCard = true;
            });

            tcMainPartFullTime == -1
                ? tcMainPartFullTime =
                    widget.training.trainingMainExerciseFullTime
                : tcMainPartFullTime = tcMainPartFullTime;
            currentWorkExercisesList =
                widget.training.trainingMainExerciseIdsList;
            currentWorkExercisesTimeList =
                widget.training.trainingMainExerciseTimeList;
            currentExerciseIndex = 0;
            listOrderIndex++;
            setState(() {});
          } else if (listOrderIndex == 1) {

            setState(() {
              isExitFromWorkoutBody = true;
              isPausePressed = true;
              startBtnPressed = false;
              trainingText = 'Exercise completed\n    Start Cooldown?';
              btnText = 'START';
              isShowTextOnCard = true;
            });

            currentWorkExercisesList =
                widget.training.trainingEndExerciseIdsList;
            currentWorkExercisesTimeList =
                widget.training.trainingEndExerciseTimeList;
            currentExerciseIndex = 0;
            listOrderIndex++;
          }
        } else if (currentExerciseIndex == currentWorkExercisesList.length &&
            tcMainPartFullTime > 1000) {
          totalExerciseIndex -= currentExerciseIndex;
          currentExerciseIndex = 0;
          setState(() {});
        }
      });

      tMainExercisesGroup =
          Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
        if (!isPausePressed) {
          {}
        }
      });
    }
  }

  var isShowTextOnCard = true;

  List<Widget> generateWidgetsList() {
    var length = widget.training.trainingStartExerciseIdsList.length +
        widget.training.trainingMainExerciseIdsList.length +
        widget.training.trainingEndExerciseIdsList.length;
    List<Widget> widgets = [];
    for (int x = 0; x < length; x++) {
      var videoId = StaticExercisesList.getExerciseById(widget
                      .training.trainingStartExerciseIdsList.length >
                  x
              ? widget.training.trainingStartExerciseIdsList[x]
              : widget.training.trainingStartExerciseIdsList.length +
                          widget.training.trainingMainExerciseIdsList.length >
                      x
                  ? widget.training.trainingMainExerciseIdsList[
                      x - widget.training.trainingStartExerciseIdsList.length]
                  : widget.training.trainingEndExerciseIdsList[x -
                      (widget.training.trainingStartExerciseIdsList.length +
                          widget.training.trainingMainExerciseIdsList.length)])
          .id;
      var player =
          VideoPlayerScreen('assets/video/$videoId.mp4', true, -1.0, -1.0);
      widgets.add(Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: player),
              !isShowTextOnCard
                  ? Container()
                  : Container(
                      color: Color.fromRGBO(22, 22, 22, 0.78),
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                    ),


//                !isShowTextOnCard ? Container() :Align(alignment: Alignment.bottomCenter, child: Padding(
//                  padding: EdgeInsets.only(bottom: 16.0),
//                  child: Container(
//                    width: MediaQuery.of(context).size.width,
//                    child: Text('< Swipe left to continue' , style: TextStyleBuilder.textStyleBuilder(
//                        16, 500, TextStyleColors.white,
//                        FontStyle.normal, context), textAlign: TextAlign.center,),
//                  ),
//                ),)
            ],
          )));
    }
    return widgets;
  }

  @override
  void dispose() {
    tMain?.cancel();
    tExercise?.cancel();
    tMainExercisesGroup?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.inactive) {
    } else if (state == AppLifecycleState.paused) {
      setState(() {
        isPausePressed = true;
        btnIcon = Icons.play_arrow;
      });
    }
  }
}

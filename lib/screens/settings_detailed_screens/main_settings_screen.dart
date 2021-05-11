import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/data/moor_trainings_database.dart';
import 'package:Fit24/data/moor_user_database.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/info_arguments.dart';
import 'package:Fit24/screens/introduction_screens/extra_info_screen.dart';
import 'package:Fit24/widget/chart_widget/my_animated_line_chart.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/my_cupertino_text_field.dart';
import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widget/chart_widget/my_line_chart.dart';

class MainSettingsScreen extends StatefulWidget {
  final Function f;
  final bool isShowSubscriptionAlert;

  MainSettingsScreen(this.f, this.isShowSubscriptionAlert);

  @override
  _MainSettingsScreenState createState() => _MainSettingsScreenState();
}

class _MainSettingsScreenState extends State<MainSettingsScreen> {
  User user;
  UserDao dao;
  String appID = "";
  var dialogWidget = MyDialog();
  Widget dialogWidget2 = MyEditTextDialog();
  var wHeight = 200;
  Widget dialogPart;

  final myController = TextEditingController();

  @override
  void initState() {
    myController.addListener(_printLatestValue);

    super.initState();
  }

  _printLatestValue() {}

  List<Map<DateTime, double>> series;
  Map<DateTime, double> line;
  List<Training> trainingsList;
  MyLineChart lineChart;

  TrainingDao _t_dao;
  UserDao _u_dao;

  @override
  Widget build(BuildContext context) {
    if (_u_dao == null || _t_dao == null) {
      _u_dao = Provider.of<UserDao>(context);
      _t_dao = Provider.of<TrainingDao>(context);
    }

    var weightListItems = new List();
    for (double x = 30.0; x < 300.0; x++) {
      weightListItems.add(x);
    }

    var currentIserWeight = 0.0;
    if (user != null)
      currentIserWeight =
          weightListItems[double.parse(user.weightIndex).toInt()];

    _t_dao.allUserTrainings.then((val) {
      if (val.length > 0) {
        series = List();
        line = Map();
        trainingsList = List();

        trainingsList = val;

        trainingsList.sort((a, b) => a.trainingDate.millisecondsSinceEpoch
            .compareTo(b.trainingDate.millisecondsSinceEpoch));

        var lastWeightVal = 0.0;
        for (int i = 0; i < trainingsList.length; i++) {
//          print('CHART $i ${double.parse(trainingsList[i].userWeightAfterTraining)}');

          if (double.parse(trainingsList[i].userWeightAfterTraining) == 0.0) {
            line[trainingsList[i].trainingDate] =
                lastWeightVal == 0.0 ? currentIserWeight : lastWeightVal;
          } else {
            lastWeightVal =
                double.parse(trainingsList[i].userWeightAfterTraining);
            line[trainingsList[i].trainingDate] =
                double.parse(trainingsList[i].userWeightAfterTraining);
          }
          if (trainingsList.length > i + 1) {
            if (trainingsList[i + 1].trainingDate.millisecondsSinceEpoch -
                    trainingsList[i].trainingDate.millisecondsSinceEpoch !=
                86400000) {
              if (double.parse(trainingsList[i].userWeightAfterTraining) ==
                  0.0) {
                line[DateTime.fromMillisecondsSinceEpoch(
                        trainingsList[i].trainingDate.millisecondsSinceEpoch +
                            (86400000))] =
                    lastWeightVal == 0.0 ? currentIserWeight : lastWeightVal;
              } else {
                line[DateTime.fromMillisecondsSinceEpoch(
                        trainingsList[i].trainingDate.millisecondsSinceEpoch +
                            (86400000))] =
                    double.parse(trainingsList[i].userWeightAfterTraining);
              }
            }
          }
        }

        var addeDaysCounter = 0;
        if (7 - trainingsList.length > 0) {
          for (int i = 0; i < 7 - trainingsList.length; i++) {
            if (double.parse(trainingsList[trainingsList.length - 1]
                    .userWeightAfterTraining) ==
                0.0) {
              line[DateTime.fromMillisecondsSinceEpoch(
                  trainingsList[trainingsList.length - 1]
                          .trainingDate
                          .millisecondsSinceEpoch +
                      (86400000 * (addeDaysCounter + 1)))] = currentIserWeight;
            } else {
              line[DateTime.fromMillisecondsSinceEpoch(
                  trainingsList[trainingsList.length - 1]
                          .trainingDate
                          .millisecondsSinceEpoch +
                      (86400000 * (addeDaysCounter + 1)))] = double.parse(
                  trainingsList[trainingsList.length - 1]
                      .userWeightAfterTraining);
            }
            addeDaysCounter++;
          }
        }

        line.forEach((e, v) {
          var dateTime = DateTime(e.year, e.month, e.day);
          var today = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day);
          if (dateTime.millisecondsSinceEpoch == today.millisecondsSinceEpoch) {
            line[e] = user != null
                ? weightListItems[double.parse(user.weightIndex).toInt()]
                : 0.0;
          }
        });

        series.add(line);
        lineChart = MyLineChart.fromDateTimeMaps(
            series.reversed.toList(), [Colors.orange], ['']);
        setState(() {});
      }
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 52 * UIScaler.getUiScaleFactor(context)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
            child: StreamBuilder(
                stream: _u_dao.watchAllUsers(),
                builder: (context, AsyncSnapshot<List<User>> snapshot) {
                  final users = snapshot.data ?? List();
                  user = users.length > 0 ? users[0] : null;

                  return user != null
                      ? Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
//                          Navigator.of(context).pushNamed(
//                              AboutUserSettingDetailedScreen.routName);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF6F6F8),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        height: 122 *
                                            UIScaler.getUiScaleFactor(context),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0, left: 12),
                                              child: Text(
                                                'Workouts \nCompleted',
                                                style: TextStyleBuilder
                                                    .textStyleBuilder(
                                                        14,
                                                        500,
                                                        TextStyleColors.orange,
                                                        FontStyle.normal,
                                                        context),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 11.0,
                                                      left: 11.0),
                                                  child: Text(
                                                    '${user.trainingsDone}',
                                                    style: TextStyleBuilder
                                                        .textStyleBuilder(
                                                        16,
                                                        400,
                                                        TextStyleColors.black,
                                                        FontStyle.normal,
                                                        context),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 11.0,
                                                          right: 11.0),
                                                  child: Container(
                                                      height: 20 *
                                                          UIScaler
                                                              .getUiScaleFactor(
                                                                  context),
                                                      child: Image.asset(
                                                        'assets/img/exercise_img.png',
                                                        height: 24,
                                                        width: 24,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
//                          Navigator.of(context).pushNamed(
//                              PlanUserSettingDetailedScreen.routName);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF6F6F8),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        height: 122 *
                                            UIScaler.getUiScaleFactor(context),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0, left: 12),
                                              child: Text(
                                                'Kilo Calories \nBurned',
                                                style: TextStyleBuilder
                                                    .textStyleBuilder(
                                                        14,
                                                        500,
                                                        TextStyleColors.orange,
                                                        FontStyle.normal,
                                                        context),
                                              ),
                                            ),

                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding:const EdgeInsets.only(
                                                      bottom: 11.0,
                                                      left: 11.0),
                                                  child: Text(
                                                      '${user.trainingSpendCalories}',
                                                      style: TextStyleBuilder
                                                          .textStyleBuilder(
                                                          16,
                                                          400,
                                                          TextStyleColors.black,
                                                          FontStyle.normal,
                                                          context)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 11.0,
                                                          right: 11.0),
                                                  child: Container(
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/img/callories_img.png',
                                                        height: 22,
                                                        width: 19,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
//                          Navigator.of(context).pushNamed(
//                              NotificationsUserSettingDetailedScreen.routName);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF6F6F8),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        height: 122 *
                                            UIScaler.getUiScaleFactor(context),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    3 -
                                                8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0, left: 12),
                                              child: Text(
                                                'Total Time\nSpent',
                                                style: TextStyleBuilder
                                                    .textStyleBuilder(
                                                        14,
                                                        500,
                                                        TextStyleColors.orange,
                                                        FontStyle.normal,
                                                        context),
                                              ),
                                            ),

                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 11.0,
                                                      left: 11.0),
                                                  child: Text(
                                                      '${(double.parse(user.trainingSpendTime) / 1000 / 60).toInt()}',
                                                      style: TextStyleBuilder
                                                          .textStyleBuilder(
                                                          16,
                                                          400,
                                                          TextStyleColors.black,
                                                          FontStyle.normal,
                                                          context)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 11.0,
                                                          right: 11.0),
                                                  child: Container(
                                                      height: 20 *
                                                          UIScaler
                                                              .getUiScaleFactor(
                                                                  context),
                                                      child: Image.asset(
                                                        'assets/img/clock_img.png',
                                                        height: 25,
                                                        width: 24,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24.0, bottom: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  widget.f(1);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32.0, top: 10, bottom: 10),
                                        child: Text(
                                          'About you',
                                          style:
                                              TextStyleBuilder.textStyleBuilder(
                                                  16,
                                                  400,
                                                  TextStyleColors.black,
                                                  FontStyle.normal,
                                                  context),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  widget.f(2);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32.0, top: 10, bottom: 10),
                                        child: Text(
                                          'Your personal workout plan',
                                          style:
                                              TextStyleBuilder.textStyleBuilder(
                                                  16,
                                                  400,
                                                  TextStyleColors.black,
                                                  FontStyle.normal,
                                                  context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  widget.f(3);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32.0, top: 10, bottom: 10),
                                        child: Text(
                                          'Push notifications',
                                          style:
                                              TextStyleBuilder.textStyleBuilder(
                                                  16,
                                                  400,
                                                  TextStyleColors.black,
                                                  FontStyle.normal,
                                                  context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => showCustomDialog());
//                                widget.f(4);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32.0, top: 10, bottom: 10),
                                        child: Text(
                                          'Rate us',
                                          style:
                                              TextStyleBuilder.textStyleBuilder(
                                                  16,
                                                  400,
                                                  TextStyleColors.black,
                                                  FontStyle.normal,
                                                  context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  widget.f(5);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32.0, top: 10, bottom: 10),
                                        child: Text(
                                          'Subscription info',
                                          style:
                                              TextStyleBuilder.textStyleBuilder(
                                                  16,
                                                  400,
                                                  TextStyleColors.black,
                                                  FontStyle.normal,
                                                  context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  widget.f(6);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32.0, top: 10, bottom: 10),
                                        child: Text(
                                          'Workout history',
                                          style:
                                              TextStyleBuilder.textStyleBuilder(
                                                  16,
                                                  400,
                                                  TextStyleColors.black,
                                                  FontStyle.normal,
                                                  context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  widget.f(7);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32.0, top: 10, bottom: 10),
                                        child: Text(
                                          'Health tips',
                                          style:
                                              TextStyleBuilder.textStyleBuilder(
                                                  16,
                                                  400,
                                                  TextStyleColors.black,
                                                  FontStyle.normal,
                                                  context),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 48.0),
                              child: Container(
                                height:
                                    300 * UIScaler.getUiScaleFactor(context),
                                width: 300 * UIScaler.getUiScaleFactor(context),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                          child: lineChart != null
                                              ? MyAnimatedLineChart(lineChart)
                                              : Container()),
                                    ]),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 32,
                              height: 275 * UIScaler.getUiScaleFactor(context),
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F6F8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 178 *
                                            UIScaler.getUiScaleFactor(context),
                                        child: Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                  ExtraInfoScreen.routName,
                                                  arguments: ScreenArguments(0),
                                                );
                                              },
                                              child: Text(
                                                'Body Mass Index',
                                                style: TextStyleBuilder
                                                    .textStyleBuilder(
                                                        20,
                                                        500,
                                                        TextStyleColors.black,
                                                        FontStyle.normal,
                                                        context),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                  ExtraInfoScreen.routName,
                                                  arguments: ScreenArguments(0),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16, right: 0),
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.grey,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 94 *
                                          UIScaler.getUiScaleFactor(context),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              user != null
                                                  ? double.parse(
                                                          user.bodyMassIndex)
                                                      .toStringAsFixed(2)
                                                      .toString()
                                                  : '0.00',
                                              style: TextStyleBuilder
                                                  .textStyleBuilder(
                                                      36,
                                                      500,
                                                      TextStyleColors.black,
                                                      FontStyle.normal,
                                                      context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: SizedBox(
                                              width: 90.0 *
                                                  UIScaler.getUiScaleFactor(
                                                      context),
                                              height: 30.0 *
                                                  UIScaler.getUiScaleFactor(
                                                      context),
                                              child: RaisedButton(
                                                color: user != null
                                                    ? (double.parse(user
                                                                .bodyMassIndex) <
                                                            16.01
                                                        ? Color(0xFF87C5BA)
                                                        : double.parse(user.bodyMassIndex) <
                                                                18.51
                                                            ? Color(0xFF4C6C93)
                                                            : double.parse(user
                                                                        .bodyMassIndex) <
                                                                    25.01
                                                                ? Color(
                                                                    0xFF73DD77)
                                                                : double.parse(user.bodyMassIndex) <
                                                                        30.01
                                                                    ? Color(
                                                                        0xFFCEDA5C)
                                                                    : double.parse(user.bodyMassIndex) <
                                                                            35.01
                                                                        ? Color(
                                                                            0xFFFFB443)
                                                                        : Color(
                                                                            0xFFEA444E))
                                                    : Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  side: BorderSide(
                                                    color: user != null
                                                        ? (double.parse(user
                                                                    .bodyMassIndex) <
                                                                16.01
                                                            ? Color(0xFF87C5BA)
                                                            : double.parse(user
                                                                        .bodyMassIndex) <
                                                                    18.51
                                                                ? Color(
                                                                    0xFF4C6C93)
                                                                : double.parse(user.bodyMassIndex) <
                                                                        25.01
                                                                    ? Color(
                                                                        0xFF73DD77)
                                                                    : double.parse(user.bodyMassIndex) <
                                                                            30.01
                                                                        ? Color(
                                                                            0xFFCEDA5C)
                                                                        : double.parse(user.bodyMassIndex) <
                                                                                35.01
                                                                            ? Color(0xFFFFB443)
                                                                            : Color(0xFFEA444E))
                                                        : Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  user != null
                                                      ? (double.parse(user
                                                                  .bodyMassIndex) <
                                                              16.01
                                                          ? 'Severely underweight'
                                                          : double.parse(user
                                                                      .bodyMassIndex) <
                                                                  18.51
                                                              ? 'Underweight'
                                                              : double.parse(user
                                                                          .bodyMassIndex) <
                                                                      25.01
                                                                  ? 'Healthy weight'
                                                                  : double.parse(user
                                                                              .bodyMassIndex) <
                                                                          30.01
                                                                      ? 'Overweight'
                                                                      : double.parse(user.bodyMassIndex) <
                                                                              35.01
                                                                          ? 'Moderately obese'
                                                                          : 'Severely obese')
                                                      : 'No value',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      child: Image.asset(
                                        'assets/img/body_mass_index_img.png',
                                        width: 165 *
                                            UIScaler.getUiScaleFactor(context),
                                        height: 165 *
                                            UIScaler.getUiScaleFactor(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container();
                }),
          ),
        ),
      ),
    );
  }

  MyEditTextDialog w = MyEditTextDialog();

  Widget showCustomDialog() {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0 * UIScaler.getUiScaleFactor(context))),
      //this right here
      child: Container(
        height: wHeight.toDouble(),
        child: Padding(
          padding: EdgeInsets.all(12.0 * UIScaler.getUiScaleFactor(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.all(4.0 * UIScaler.getUiScaleFactor(context)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      wHeight == 520
                          ? Container()
                          : Text(
                              wHeight == 300 ? '' : dialogPart == null
                                  ? 'Rate our App'
                                  : 'Leave your Feedback',
                              textAlign: TextAlign.center,
                              style: TextStyleBuilder.textStyleBuilder(
                                  16,
                                  400,
                                  TextStyleColors.black,
                                  FontStyle.normal,
                                  context),
                            ),
                    ]),
              ),
              dialogPart == null ? dialogWidget : dialogWidget2,
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      },
                    child: Container(
                      width: 100 * UIScaler.getUiScaleFactor(context),
                      child: Text(
                        "Cancel",
                        style: TextStyleBuilder.textStyleBuilder(15, 400,
                            TextStyleColors.black, FontStyle.normal, context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                      height: 26 * UIScaler.getUiScaleFactor(context),
                      child: VerticalDivider(width: 3)),
                  GestureDetector(
                    onTap: () async {
                      if (wHeight == 300) {
                        LaunchReview.launch(
                            writeReview: false, iOSAppId: "1495041325");
                      }if (dialogWidget.getMark() >= 4) {
                        Navigator.of(context).pop();
                        wHeight = 300;
                        dialogWidget2 = IsGoToAppStoreDialog();
                        dialogPart = dialogWidget2;

                        showDialog(
                            context: context, builder: (_) => showCustomDialog());
                        setState(() {});

                      } else if (wHeight != 250) {
                        Navigator.of(context).pop();

                        if (wHeight == 355) {

                          if (w.getEmail().isNotEmpty) {
                            wHeight = 250;
                            dialogWidget2 = MyThxDialog();
                            dialogPart = dialogWidget2;

                            final MailOptions email = MailOptions(
                              subject: 'App Rating',
                              body: '${w.getMsg()}\n From : ${w.getEmail()}',
                              recipients: ['fitandripped24@gmail.com'],
                              isHTML: false,
                            );

                            await FlutterMailer.send(email);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please fill in email field",
                                toastLength: Toast
                                    .LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Color(
                                    0xFF666666),
                                textColor: Colors.white,
                                fontSize: 12.0
                            );
                          }
                        } else if (wHeight == 300){
                          LaunchReview.launch(writeReview: false, iOSAppId: "1495041325");
                        } else {
                          wHeight = 355;
                          dialogPart = dialogWidget2;
                        }

                        showDialog(
                            context: context,
                            builder: (_) => showCustomDialog());
                        setState(() {});
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: 100 * UIScaler.getUiScaleFactor(context),
                      child: Text(
                        "OK",
                        style: TextStyleBuilder.textStyleBuilder(15, 400,
                            TextStyleColors.black, FontStyle.normal, context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  int starLvlSelected = 0;

  int getMark() {
    return starLvlSelected;
  }

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return Padding(
      padding: EdgeInsets.all(8.0 * UIScaler.getUiScaleFactor(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                widget.starLvlSelected = 1;
                setState(() {});
              },
              child: Image.asset(
                widget.starLvlSelected < 1
                    ? 'assets/img/star_border.png'
                    : 'assets/img/star_filled.png',
                height: 32 * UIScaler.getUiScaleFactor(context),
                width: 32 * UIScaler.getUiScaleFactor(context),
              )),
          GestureDetector(
              onTap: () {
                widget.starLvlSelected = 2;
                setState(() {});
              },
              child: Image.asset(
                widget.starLvlSelected < 2
                    ? 'assets/img/star_border.png'
                    : 'assets/img/star_filled.png',
                height: 32 * UIScaler.getUiScaleFactor(context),
                width: 32 * UIScaler.getUiScaleFactor(context),
              )),
          GestureDetector(
              onTap: () {
                widget.starLvlSelected = 3;
                setState(() {});
              },
              child: Image.asset(
                widget.starLvlSelected < 3
                    ? 'assets/img/star_border.png'
                    : 'assets/img/star_filled.png',
                height: 32 * UIScaler.getUiScaleFactor(context),
                width: 32 * UIScaler.getUiScaleFactor(context),
              )),
          GestureDetector(
              onTap: () {
                widget.starLvlSelected = 4;
                setState(() {});
              },
              child: Image.asset(
                widget.starLvlSelected < 4
                    ? 'assets/img/star_border.png'
                    : 'assets/img/star_filled.png',
                height: 32 * UIScaler.getUiScaleFactor(context),
                width: 32 * UIScaler.getUiScaleFactor(context),
              )),
          GestureDetector(
              onTap: () {
                widget.starLvlSelected = 5;
                setState(() {});
              },
              child: Image.asset(
                widget.starLvlSelected < 5
                    ? 'assets/img/star_border.png'
                    : 'assets/img/star_filled.png',
                height: 32 * UIScaler.getUiScaleFactor(context),
                width: 32 * UIScaler.getUiScaleFactor(context),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}

class MyEditTextDialog extends StatefulWidget {
  String email;
  String msg;

  String getEmail() {
    return email;
  }

  String getMsg() {
    return msg;
  }

  @override
  _MyEditTextDialogState createState() => new _MyEditTextDialogState();
}

class _MyEditTextDialogState extends State<MyEditTextDialog> {
  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return Padding(
        padding: EdgeInsets.all(16.0 * UIScaler.getUiScaleFactor(context)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 32,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 36,
                  child:  MyCupertinoTextField(
                    onChanged: (val) {
                      widget.email = val;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.sentences,
                    placeholder: "Email",
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    padding: EdgeInsets.all(8.0*UIScaler.getUiScaleFactor(context)),
                    style: TextStyle(color: Colors.orange),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(4.0*UIScaler.getUiScaleFactor(context))),
                      border: Border.all(
                        color: Color(0xFFC1C1CB),
                        width: 1, //                   <--- border width here
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100 * UIScaler.getUiScaleFactor(context),
                width: MediaQuery.of(context).size.width - 36,
                child:
                MyCupertinoTextField(
                  onChanged: (val) {
                    widget.msg = val;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.sentences,
                  placeholder: "Message",
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  padding: EdgeInsets.all(8.0*UIScaler.getUiScaleFactor(context)),
                  style: TextStyle(color: Colors.orange),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(4.0*UIScaler.getUiScaleFactor(context))),
                    border: Border.all(
                      color: Color(0xFFC1C1CB),
                      width: 1, //                   <--- border width here
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}

class MyThxDialog extends StatefulWidget {
  @override
  _MyThxDialogState createState() => new _MyThxDialogState();
}

class _MyThxDialogState extends State<MyThxDialog> {
  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50 * UIScaler.getUiScaleFactor(context),
                width: MediaQuery.of(context).size.width - 32,
                child: Image.asset(
                  'assets/img/smile_img.png',
                  height: 44 * UIScaler.getUiScaleFactor(context),
                  width: 44 * UIScaler.getUiScaleFactor(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('We appreciate your opinion'),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}



class IsGoToAppStoreDialog extends StatefulWidget {
  @override
  _IsGoToAppStoreDialogState createState() => new _IsGoToAppStoreDialogState();
}

class _IsGoToAppStoreDialogState extends State<IsGoToAppStoreDialog> {
  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50 * UIScaler.getUiScaleFactor(context),
                width: MediaQuery.of(context).size.width - 32,
                child: Image.asset(
                  'assets/img/smile_img.png',
                  height: 44 * UIScaler.getUiScaleFactor(context),
                  width: 44 * UIScaler.getUiScaleFactor(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'If you like our application, we would greatly appreciate it if you could rate the app on the App Store. Thanks!'),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}

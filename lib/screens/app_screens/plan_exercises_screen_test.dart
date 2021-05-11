import 'dart:math';

import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/static_trainings_list.dart';
import 'package:Fit24/model/training_base.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exercise_time_line.dart';

class PlanScreenTest extends StatefulWidget {
  static const String routName = '/PlanScreen';

  @override
  _PlanScreenTestState createState() => _PlanScreenTestState();
}

class _PlanScreenTestState extends State<PlanScreenTest> {
  User user;

  List<Training> trainingsList = List();

  var lockUpdating = false;
  var itemsCount = 1;

//  var firstLaunchTime = 0;

  var trainingWeek = 0;
  TrainingDao _t_dao;
  UserDao _u_dao;

  @override
  Widget build(BuildContext context) {

    if (_u_dao == null || _t_dao == null  ) {
      _u_dao = Provider.of<UserDao>(context);
      _t_dao = Provider.of<TrainingDao>(context);
    }

    return Scaffold(
        body: StreamBuilder(
            stream: _u_dao.watchAllUsers(),
            builder: (context, AsyncSnapshot<List<User>> snapshot) {

              final users = snapshot.data;
              user = users == null ? null : users.length > 0 ? users[0] : null;

              return StreamBuilder(
                  stream:
                  _t_dao.watchAllTrainingsTest(),
                  builder:
                      (context, AsyncSnapshot<List<Training>> snapshot) {

                    itemsCount = 300; //user != null ? double.parse(user.trainingTimesPerWeek).toInt() : 1 ;

                    if (!lockUpdating) {

                      var traings = snapshot.data;

                      var thisMonday = DateTime.now().subtract(
                          Duration(days: DateTime
                              .now()
                              .weekday - 1));

                      thisMonday = DateTime(thisMonday.year, thisMonday.month, thisMonday.day, 9, 0, 0, 0, 0);

                      var thisSunday = thisMonday.add(Duration(days: 6));

                      var thisTuesday = thisMonday.add(
                          new Duration(days: 1));
                      var thisWednesday = thisMonday.add(
                          new Duration(days: 2));
                      var thisThursday = thisMonday.add(
                          new Duration(days: 3));
                      var thisFriday = thisMonday.add(
                          new Duration(days: 4));

                      if (traings != null && trainingsList != null) {

                        trainingsList = List();
                        for (int i = 0; i < traings.length; i++) {
                          if (traings[i].trainingDate.isAfter(
                              thisMonday.subtract(Duration(days: 1))) &&
                              traings[i].trainingDate.isBefore(
                                  thisSunday)) {
                            trainingsList.add(traings[i]);
                          }
                        }
                        trainingsList.sort((a, b) =>
                            a.id.compareTo(b.id));
                      }

                      if (user != null && trainingsList.isEmpty && traings != null) {
                        itemsCount = 300;//double.parse(user.trainingTimesPerWeek).toInt();

//                            var hardness = (double.parse(user.userQuestion1)
//                                .toInt() +
//                                double.parse(user.userQuestion2).toInt() +
//                                double.parse(user.userQuestion3).toInt()) ~/
//                                3;

                        List<TrainingBase> sortedExercises = [];

                        StaticTrainingList.sTrainingsList.forEach((val) {
//                              if (val.trainingHardness == hardness + 1) {
//                                if (user.fitnessStyleIndex == 2 && (val.trainingName.toLowerCase().contains('cardio') || val.trainingName.toLowerCase().contains('core'))){
//                                } else {
                          sortedExercises.add(val);
//                                }
//                              }
                        });

                        for (int i = 0; i < itemsCount; i++) {
//                              var isAdded = false;
//
//                              do {
                          var trainingDate = thisMonday;
//                                i == 0 ? thisMonday
//                                    : i == 1 ? itemsCount == 2
//                                    ? thisThursday
//                                    : itemsCount == 3
//                                    ? thisWednesday
//                                    : itemsCount == 4
//                                    ? thisTuesday
//                                    : thisTuesday
//                                    : i == 2 ? itemsCount == 3
//                                    ? thisFriday
//                                    : itemsCount == 4
//                                    ? thisThursday
//                                    : thisWednesday
//                                    : i == 3 ? itemsCount == 4
//                                    ? thisFriday
//                                    : thisThursday
//                                    : thisFriday;

                          var baseTraining = sortedExercises[i];


                          var imagePath = '';
                          if (trainingsList != null && trainingsList.isNotEmpty){
//                                  do {
                            imagePath = 'assets/img/${baseTraining.trainingName.toLowerCase().contains('cardio') ? 'cardio_${Random().nextInt(11)+1}' :
                            baseTraining.trainingName.toLowerCase().contains('core') ? 'core_${Random().nextInt(11)+1}' :
                            baseTraining.trainingName.toLowerCase().contains('upper') ? 'upper_body_${Random().nextInt(11)+1}' :
                            baseTraining.trainingName.toLowerCase().contains('lower') ? 'lower_body_${Random().nextInt(11)+1}' :
                            'full_body_${Random().nextInt(11)+1}'
                            }.png';
                            for (var x = 0; x < trainingsList.length; x++){
                              if (imagePath == trainingsList[x].imagePath){
                                imagePath = '';
                              }
                            }
//                                  } while (imagePath == '');

                          } else {
                            imagePath = 'assets/img/${baseTraining.trainingName.toLowerCase().contains('cardio') ? 'cardio_${Random().nextInt(11)+1}' :
                            baseTraining.trainingName.toLowerCase().contains('core') ? 'core_${Random().nextInt(11)+1}' :
                            baseTraining.trainingName.toLowerCase().contains('upper') ? 'upper_body_${Random().nextInt(11)+1}' :
                            baseTraining.trainingName.toLowerCase().contains('lower') ? 'lower_body_${Random().nextInt(11)+1}' :
                            'full_body_${Random().nextInt(11)+1}'
                            }.png';
                          }

                          var t = Training(
                              id: i,
                              name: baseTraining.trainingName,
                              trainingDate: trainingDate,
                              exercisesGroupId: baseTraining.id,
                              isDone: false,
                              extraExerciseExitIndex: 3,
                              isAlertEnable: true,
                              alertStartTime : trainingDate,
                              imagePath: imagePath
                          );

                          if (trainingsList == null) {
                            trainingsList = List();
                          }

                          trainingsList.add(t);

//                                if (trainingsList != null) {
//                                  if (trainingsList.isEmpty) {
//                                    trainingsList.add(t);
////                                    isAdded = true;
//                                  } else {
//                                    var isOnList = false;
//                                    for (int x = 0;
//                                    x < trainingsList.length;
//                                    x++) {
//                                      if (trainingsList[x].exercisesGroupId ==
//                                          t.exercisesGroupId) {
//                                        isOnList = true;
//                                        break;
//                                      }
//                                    }
//                                    if (!isOnList) {
//                                      trainingsList.add(t);
////                                      isAdded = true;
//                                    }
//                                  }
//                                } else {
////                                  isAdded = true;
//                                }
////                              } while (!isAdded);
                        }

                        //TODO: TEST
//                            if (trainingsList != null) {
//                              trainingsList = List();
//                              sortedExercises = StaticTrainingList.sTrainingsList;
//                            }
//
//                            for (int i = 0 ; i < sortedExercises.length; i++){
//                              var baseTraining = sortedExercises[i];
//                              var trainingDate = thisMonday;
//                              var t = Training(
//                                  id: Random().nextInt(4294967295),
//                                  name: baseTraining.trainingName,
//                                  trainingDate: trainingDate,
//                                  exercisesGroupId: baseTraining.id,
//                                  isDone: false,
//                                  extraExerciseExitIndex: 3,
//                                  isAlertEnable: true,
//                                  alertStartTime : trainingDate,
//                                  imagePath: 'assets/img/${baseTraining.trainingName.toLowerCase().contains('cardio') ? 'cardio_${Random().nextInt(11)+1}' :
//                                  baseTraining.trainingName.toLowerCase().contains('core') ? 'core_${Random().nextInt(11)+1}' :
//                                  baseTraining.trainingName.toLowerCase().contains('upper') ? 'upper_body_${Random().nextInt(11)+1}' :
//                                  baseTraining.trainingName.toLowerCase().contains('lower') ? 'lower_body_${Random().nextInt(11)+1}' :
//                                  'full_body_${Random().nextInt(11)+1}'
//                                  }.png'
//                              );
//                              trainingsList.add(t);
//                            }
                        //TODO: TEST

                        _t_dao.insertTrainings(trainingsList).then((_){
                          _loadCurrentWeekTrainingsCounter().then((v){
                            setState(() {trainingWeek = v + 1; _saveCurrentWeekTrainingsCounter(v + 1);});
                          });
                        });
                        lockUpdating = true;

                        SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {}));

                      }
                    }


                    if (trainingWeek == 0) {
                      _loadCurrentWeekTrainingsCounter().then((v) {
                        setState(() {trainingWeek = v;});
                      });
                    }

                    if (trainingsList != null) trainingsList.sort((a, b) =>
                        a.id.compareTo(b.id));

                    return Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:  EdgeInsets.only(
                                top: 52*UIScaler.getUiScaleFactor(context), left: 16, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style:
                                    TextStyleBuilder.textStyleBuilder(
                                        24,
                                        600,
                                        TextStyleColors.black,
                                        FontStyle.normal, context),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Plan '),
                                      TextSpan(
                                        text: 'week ${trainingWeek == 0 || trainingWeek == -1 ? 1 : trainingWeek}',
                                        style: TextStyleBuilder
                                            .textStyleBuilder(
                                            24,
                                            600,
                                            TextStyleColors.orange,
                                            FontStyle.normal, context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height:
                            MediaQuery.of(context).size.height-125,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                  top: 8, left: 0.0, right: 0, bottom: 16),
                              itemCount: trainingsList != null
                                  ? trainingsList.length
                                  : 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 0.0,
                                      bottom: 20.0),
                                  child: GestureDetector(
                                    onTap: () {
//                                            if ((trainingWeek == 0 || trainingWeek == 1) && firstLaunchTime > trainingsList[index].trainingDate.millisecondsSinceEpoch){
//                                              Fluttertoast.showToast(
//                                                  msg: "This training will be available next week",
//                                                  toastLength: Toast.LENGTH_SHORT,
//                                                  gravity: ToastGravity.BOTTOM,
//                                                  backgroundColor: Color(0xFF666666),
//                                                  textColor: Colors.white,
//                                                  fontSize: 12.0
//                                              );
//                                            } else {
//                                            if (!trainingsList[index].isDone) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ExerciseTimeLineScreen(
                                                  training: trainingsList[index]
                                              ),
                                        ),
                                      );
//                                            } else {
//                                              Fluttertoast.showToast(
//                                                  msg: "You've already done this training",
//                                                  toastLength: Toast
//                                                      .LENGTH_SHORT,
//                                                  gravity: ToastGravity.BOTTOM,
//                                                  backgroundColor: Color(
//                                                      0xFF666666),
//                                                  textColor: Colors.white,
//                                                  fontSize: 12.0
//                                              );
//                                            }
//                                          }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Center(
                                              child: Container(
                                                height: 128*UIScaler.getUiScaleFactor(context),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                      Alignment.center,
                                                      child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit
                                                                  .cover,
                                                              image: AssetImage(
                                                                  trainingsList[index].imagePath)),
                                                          borderRadius: BorderRadius
                                                              .all(Radius
                                                              .circular(
                                                              4.0)),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                      Alignment.center,
                                                      child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .all(Radius
                                                              .circular(
                                                              4.0)),
                                                          gradient: LinearGradient(
                                                              stops: [
                                                                0.1,
                                                                1
                                                              ],
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Color.fromRGBO(
                                                                    8,
                                                                    3,
                                                                    44,
                                                                    0.7),
                                                                Color
                                                                    .fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0)
                                                              ]),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
//                                                ((trainingWeek == 0 || trainingWeek == 1) && firstLaunchTime > trainingsList[index].trainingDate.millisecondsSinceEpoch)?
//                                                    Container(
//                                                  height: 128*UIScaler.getUiScaleFactor(context),
//                                                  width: MediaQuery.of(
//                                                      context)
//                                                      .size
//                                                      .width,
//                                                  decoration:
//                                                  BoxDecoration(
//                                                    borderRadius:
//                                                    BorderRadius.all(
//                                                        Radius
//                                                            .circular(
//                                                            4.0)),
//                                                    color: Color.fromRGBO(
//                                                        128,
//                                                        128,
//                                                        128,
//                                                        0.8),
//                                                  ),
//                                                ) :
                                            trainingsList[index].isDone
                                                ? Container(
                                              height: 128*UIScaler.getUiScaleFactor(context),
                                              width: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .width,
                                              decoration:
                                              BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        4.0)),
                                                color: Color.fromRGBO(
                                                    92,
                                                    74,
                                                    237,
                                                    0.53),
                                              ),
                                            )
                                                : Container(),

                                            Container(
                                              height: 128*UIScaler.getUiScaleFactor(context),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 12.0,
                                                    bottom: 12.0),
                                                child: trainingsList[index]
                                                    .isDone
                                                    ? Align(
                                                  alignment: Alignment
                                                      .bottomRight,
                                                  child: Stack(
                                                    alignment: Alignment
                                                        .center,
                                                    children: <Widget>[
                                                      Image.asset('assets/img/orange_circle.png', height: 32, width: 32,),
                                                      Image.asset('assets/img/done.png', height: 11, width: 15,),
                                                    ],
                                                  ),
                                                )
                                                    : Container(),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  top: 12.0,
                                                  left: 10.0),
                                              child: Align(
                                                child: Text(
                                                  '${trainingsList[index].name}',
                                                  style: TextStyleBuilder
                                                      .textStyleBuilder(
                                                      24,
                                                      500,
                                                      TextStyleColors
                                                          .white,
                                                      FontStyle.normal, context),
                                                ),
                                                alignment:
                                                Alignment.topLeft,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 42, 0, 0),
                                              child: Align(
                                                alignment:
                                                Alignment.topLeft,
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      '${DateFormat("EEEEE, MMM dd").format(trainingsList[index].trainingDate)}',
                                                      style: TextStyleBuilder
                                                          .textStyleBuilder(
                                                          16,
                                                          300,
                                                          TextStyleColors
                                                              .white,
                                                          FontStyle
                                                              .normal, context),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }

//  _saveFirstLaunchTime() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
//    await prefs.setInt('firstLaunchTime', dateToday.millisecondsSinceEpoch);
//  }
//
//  Future<int> _loadFirstLaunchTime() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.getInt('firstLaunchTime') ?? 0;
//  }

  Future _saveCurrentWeekTrainingsCounter(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('currentWeekTrainingsCounter', i);
  }

  Future<int> _loadCurrentWeekTrainingsCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentWeekTrainingsCounter') ?? 0;
  }



}

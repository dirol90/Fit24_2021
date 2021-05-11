
import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/data/moor_trainings_database.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/exercise_base.dart';
import 'package:Fit24/model/static_exercises_list.dart';
import 'package:Fit24/model/static_trainings_list.dart';
import 'package:Fit24/model/training_base.dart';
import 'package:Fit24/screens/app_screens/excersise_screen.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/circle_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'exercise_detailed_screen.dart';

class ExerciseTimeLineScreen extends StatefulWidget {
  static const String routName = '/ExerciseTimeLine';
  Training training;

  ExerciseTimeLineScreen({Training training}) {this.training = training;}

  @override
  _ExerciseTimeLineScreenState createState() => _ExerciseTimeLineScreenState();
}

class _ExerciseTimeLineScreenState extends State<ExerciseTimeLineScreen> {
  TrainingBase trainingBase;

  var isShowVideo = false;
  var selectedVideoPath = '';
  @override
  Widget build(BuildContext context) {

    trainingBase = StaticTrainingList.getTrainingById(widget.training.exercisesGroupId);

    var exFullTime = 0;

    trainingBase.trainingStartExerciseTimeList.forEach((element) {
      if(element < 1000) {
        exFullTime += element * 3000;
      } else {
        exFullTime += element;
      }
    });

    trainingBase.trainingMainExerciseTimeList.forEach((element) {
      if(element < 1000) {
        exFullTime += element * 3000;
      } else {
        exFullTime += element;
      }
    });

    trainingBase.trainingEndExerciseTimeList.forEach((element) {
      if(element < 1000) {
        exFullTime += element * 3000;
      } else {
        exFullTime += element;
      }
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(onTap: (){Navigator.pop(context);}, child: Padding(
                  padding: EdgeInsets.only(top: 52.0*UIScaler.getUiScaleFactor(context), left: 16*UIScaler.getUiScaleFactor(context), bottom: 16*UIScaler.getUiScaleFactor(context)),
                  child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                )),
                Padding(
                  padding: EdgeInsets.only( left: 8.0*UIScaler.getUiScaleFactor(context), right: 8*UIScaler.getUiScaleFactor(context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top : 0.0, left: 0.0, bottom: 0, right: 0),
                            child: Align(
                              child: Container(
                                height: 108*UIScaler.getUiScaleFactor(context),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 0.0, left: 0.0),
                                                  child: Container(
                                                    width: 290*UIScaler.getUiScaleFactor(context),
                                                    height: 76*UIScaler.getUiScaleFactor(context),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container( width : 200*UIScaler.getUiScaleFactor(context), child: Text('${trainingBase.trainingName}',  style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.black, FontStyle.normal, context), maxLines: 2, overflow: TextOverflow.ellipsis,)),
                                                        Padding(
                                                          padding: const EdgeInsets.only (left: 8.0, top: 16.0, bottom: 0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Image.asset('assets/img/time_in_card.png', height: 20, width: 20,),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 8.0),
                                                                        child: Text(
                                                                          '${exFullTime/1000~/60} min',
                                                                          style: TextStyleBuilder
                                                                              .textStyleBuilder(
                                                                              12,
                                                                              400,
                                                                              TextStyleColors.darkText,
                                                                              FontStyle
                                                                                  .normal, context),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Image.asset('assets/img/kcal_in_card.png', height: 20, width: 20,),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 8.0),
                                                                        child: Text(
                                                                          '${(exFullTime/1000~/60)*8} Kcal',
                                                                          style: TextStyleBuilder
                                                                              .textStyleBuilder(
                                                                              12,
                                                                              400,
                                                                              TextStyleColors.darkText,
                                                                              FontStyle
                                                                                  .normal, context),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 60*UIScaler.getUiScaleFactor(context),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: <Widget>[
//                                                    Text('Level', style: TextStyleBuilder.textStyleBuilder(10, 400, TextStyleColors.violet, FontStyle.normal, context),),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 8, bottom: 6),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, trainingBase.trainingHardness >= 1 ? Color(0xFF1D1D1D): Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 6, left: 8),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, trainingBase.trainingHardness >= 2 ? Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 6, left: 8),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, trainingBase.trainingHardness >= 3 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 6, left: 8),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, trainingBase.trainingHardness >= 4 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 6, left: 8),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, trainingBase.trainingHardness >= 5 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
//                                Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      '${trainingBase.trainingName}',
//                                      style: TextStyleBuilder.textStyleBuilder(24, 500, TextStyleColors.darkBlack, FontStyle.normal, context),
//                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.only(top: 8.0),
//                                      child: Row(
//                                        children: <Widget>[
//                                          Text(
//                                              '${DateFormat("EEEEE, MMM dd").format(widget.training.trainingDate)}',
//                                              style: TextStyleBuilder.textStyleBuilder(16, 400, TextStyleColors.white, FontStyle.normal, context)
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                    Container(
//                                      width: MediaQuery.of(context).size.width,
//                                      child: Row(
//                                        children: <Widget>[
//                                          Flexible(
//                                            child: Text(
//                                                '',
////                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean etiam sed in imperdiet quisque id aenean. Purus in aenean est tristique et mattis amet, pellentesque euismod. Hendrerit rhoncus, fermentum leo, quisque pellentesque risus. Aliquet tortor neque, suspendisse eget vel.,',
//                                                maxLines: 4,
//                                                style: TextStyleBuilder.textStyleBuilder(10, 300, TextStyleColors.white, FontStyle.normal, context)
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//
//                                  ],
//                                ),
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0 , right: 8, left: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.height-(269*UIScaler.getUiScaleFactor(context)),
                    child: Scrollbar(
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                            top: 0, left: 0.0, right: 0, bottom: 0),
                        itemCount:
                        trainingBase.trainingStartExerciseIdsList.length +
                        trainingBase.trainingMainExerciseIdsList.length
                        + trainingBase.trainingEndExerciseIdsList.length
                        ,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {

                          ExerciseBase currentExercise;
                          var tc = -1;

                          var isStartPart= false;
                          var isMainPart = false;
                          var isEndPart = false;

                      if (index < trainingBase.trainingStartExerciseIdsList.length)
                      {isStartPart = true;
                      currentExercise = StaticExercisesList.getExerciseById(trainingBase.trainingStartExerciseIdsList[index]);
                      tc = trainingBase.trainingStartExerciseTimeList[index];
                      }

                      else if (index- trainingBase.trainingStartExerciseIdsList.length < trainingBase.trainingMainExerciseIdsList.length)
                        {
                          isMainPart = true;
                          currentExercise = StaticExercisesList.getExerciseById(trainingBase.trainingMainExerciseIdsList[index
                            - trainingBase.trainingStartExerciseIdsList.length
                          ]);

//                        if (trainingBase.trainingMainExerciseFullTime > 0) {tc = trainingBase.trainingMainExerciseFullTime;} else {
                          tc = trainingBase.trainingMainExerciseTimeList[index
                            - trainingBase.trainingStartExerciseIdsList.length
                          ];
//                        }

                        }

                      else if (index- trainingBase.trainingStartExerciseIdsList.length - trainingBase.trainingMainExerciseIdsList.length < trainingBase.trainingEndExerciseIdsList.length)
                        {isEndPart = true;
                        currentExercise = StaticExercisesList.getExerciseById(trainingBase.trainingEndExerciseIdsList[index- trainingBase.trainingStartExerciseIdsList.length - trainingBase.trainingMainExerciseIdsList.length]);
                        tc = trainingBase.trainingEndExerciseTimeList[index- trainingBase.trainingStartExerciseIdsList.length - trainingBase.trainingMainExerciseIdsList.length];
                        }
                      else Container();

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowVideo = true;
                                selectedVideoPath = currentExercise.id.toString();
                              });

//                              Navigator.of(context)
//                                ..push(MaterialPageRoute(
//                                    builder: (BuildContext context) =>
//                                        ExerciseDetailed('video_1')));
                            },
                            child: Column (children: <Widget>[
                              index == 0 || index - trainingBase.trainingStartExerciseIdsList.length == 0 || index - (trainingBase.trainingStartExerciseIdsList.length + trainingBase.trainingMainExerciseIdsList.length) == 0 ?
                                Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
//                                      Padding(
//                                        padding: const EdgeInsets.only(left: 16.0, top: 4, bottom: 4),
//                                        child: Container(
//                                          child: CustomPaint(painter: DrawCircle(4.0, Theme.of(context).accentColor)),
//                                        ),
//                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                                        child: Text(
                                          index == 0 ? 'Warm-up' : index - trainingBase.trainingStartExerciseIdsList.length == 0 ? 'Training ${trainingBase.trainingMainExerciseFullTime > 0 ? ' ${
                                              'x${trainingBase.trainingMainExerciseFullTime/1000.toInt() > 60 ? '${trainingBase.trainingMainExerciseFullTime/1000.toInt()~/60} min ${trainingBase.trainingMainExerciseFullTime~/1000%60} sec' : '${trainingBase.trainingMainExerciseFullTime~/1000} sec'}'
                                          }' : ''}' : 'Cooldown',
                                          style: TextStyleBuilder.textStyleBuilder(20, 500, TextStyleColors.black, FontStyle.normal, context),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 24, top: 4, bottom: 4),
                                        child: Text(
                                          index == 0 ? '${trainingBase.trainingStartExerciseIdsList.length} Exercises' : index - trainingBase.trainingStartExerciseIdsList.length == 0 ? '${trainingBase.trainingMainExerciseIdsList.length} Exercises' : '${trainingBase.trainingEndExerciseIdsList.length} Exercises',
                                          style: TextStyleBuilder.textStyleBuilder(14, 400, TextStyleColors.black, FontStyle.normal, context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ) : Container(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
//                                      Column(children: <Widget>[
//                                        Container(
//                                          height: 93*UIScaler.getUiScaleFactor(context),
//                                          child: VerticalDivider(
//                                            width: 32*UIScaler.getUiScaleFactor(context),
//                                            thickness: 2,
//                                          ),
//                                        ),
//                                      ]),
                                        Container(
                                          height: 63*UIScaler.getUiScaleFactor(context),
                                          width: 60*UIScaler.getUiScaleFactor(context),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage('assets/img/${currentExercise.id}.jpg')),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(4.0)),
                                          ),
                                        ),
                                        Container(
                                          height: 63*UIScaler.getUiScaleFactor(context),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 16.0),
                                                child:
                                                Container( width : 250*UIScaler.getUiScaleFactor(context), child: Text('${isStartPart ? '' /*'Разминка: '*/ : ''}${isMainPart ? '' /*'Основное упражнение: '*/ : ''}${isEndPart ? ''/*'Заминка: '*/ : ''}${currentExercise.exerciseName}',  style: TextStyleBuilder.textStyleBuilder(16, 400, TextStyleColors.darkBlack, FontStyle.normal, context),  maxLines: 2, overflow: TextOverflow.ellipsis,)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 16.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width-108,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text('${StaticExercisesList.getBodyPartsById(currentExercise.id)}', style: TextStyleBuilder.textStyleBuilder(10, 400, TextStyleColors.darkGrey, FontStyle.normal, context)),
                                                      Row(children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Image.asset('assets/img/time_in_card.png', height: 20, width: 20,),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: Text('${tc > 1000 ? 'x ${tc/1000.toInt() > 60 ? '${tc/1000.toInt()~/60} min ${tc~/1000%60} sec' : '${tc~/1000} sec'}' : 'x $tc times'}' /**${currentExercise.exerciseExtraWords!= '' ? ' (${tc/2 > 1000 ? '${tc/2/1000.toInt() > 60 ? '${tc/2/1000.toInt()~/60} min ${tc/2~/1000%60} sec' : '${tc/2~/1000} sec'}' : '${(tc/2).toInt()} times'} ${currentExercise.exerciseExtraWords})' : ''},**/,  style: TextStyleBuilder.textStyleBuilder(10, 400, TextStyleColors.orange, FontStyle.normal, context)),
                                                            ),
                                                          ],
                                                        ),

                                                      ],),
                                                      ],),
                                                ),
                                              ),
                                            ],),
                                        ),
                                      ],
                                    )),
                              ),
//                              (index + 1 - trainingBase.trainingStartExerciseIdsList.length == 0 || index + 1 - (trainingBase.trainingStartExerciseIdsList.length + trainingBase.trainingMainExerciseIdsList.length) == 0 ) ? Container() : Container(
//                                child: Row(
//                                  children: <Widget>[
//                                    Padding(
//                                      padding: const EdgeInsets.only(left: 16.0, top: 4, bottom: 4),
//                                      child: Container(
//                                        child: CustomPaint(painter: DrawCircle(4.0, Theme.of(context).accentColor)),
//                                      ),
//                                    ),
//                                    Padding(
//                                      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
//                                      child: Text(
//                                        '${trainingBase.restTime > 0 && isMainPart ? 'Rest ${(trainingBase.restTime / 1000).toInt()} sec' : 'No rest'}',
//                                        style: TextStyleBuilder.textStyleBuilder(10, 400, TextStyleColors.black, FontStyle.normal, context),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
                            ],),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                !widget.training.isDone ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.only(bottom: 24.0),
                       child: Container(
                        height: 40*UIScaler.getUiScaleFactor(context),
                        width: MediaQuery.of(context).size.width-32,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0*UIScaler.getUiScaleFactor(context)),
                              side: BorderSide(color: Theme.of(context).buttonColor)),
                          child: Text(
                            widget.training.isDone ? 'You\'ve already completed this workout'.toUpperCase() : 'start workout'.toUpperCase(),
                            style: TextStyleBuilder.textStyleBuilder(15, 500, TextStyleColors.white, FontStyle.normal, context),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            if (!widget.training.isDone) {
                            trainingBase.trainingCalories = 0;
                            Navigator.of(context)
                              ..pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TrainingStartScreen(
                                          training : trainingBase, trainingDB: widget.training)));
                          } else {
                              Fluttertoast.showToast(
                                  msg: "You've already done this training",
                                  toastLength: Toast
                                      .LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Color(
                                      0xFF666666),
                                  textColor: Colors.white,
                                  fontSize: 12.0
                              );
                            }
                          },
                          color: Theme.of(context).buttonColor,
                        ),
                    ),
                     )
                  ],
                ) : Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
                  child: Container(
                    color: Color(0xFFFF6B4A),
                    height: 57,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                        child: Text(
                          'This workout has been completed',
                          style: TextStyleBuilder.textStyleBuilder(
                              14,
                              400,
                              TextStyleColors.white,
                              FontStyle.normal, context
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isShowVideo ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(22, 22, 22, 0.90),
            child: ExerciseDetailed(vFileName: selectedVideoPath, f: disableVideoScreen),
          ) : Container()
        ],
      ),
    );
  }

  Function disableVideoScreen(){
    setState(() {
      isShowVideo = false;
    });
  }
}

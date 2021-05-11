import 'dart:math';

import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/exercise_base.dart';
import 'package:Fit24/model/static_exercises_list.dart';
import 'package:Fit24/model/static_trainings_list.dart';
import 'package:Fit24/screens/app_screens/exercise_time_line.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/circle_item.dart';
import 'package:flutter/material.dart';
import 'package:Fit24/widget/my_cupertino_text_field.dart';

import 'exercise_detailed_screen.dart';

class WorkoutListScreen extends StatefulWidget {
  static const String routName = '/WorkoutListScreen';

  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  ScrollController _controller;
  List<String> imagePathList = List();

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (imagePathList.isEmpty){
      for(int index = 0; index < StaticTrainingList.sTrainingsList.length; index++){
        imagePathList.add('assets/img/${StaticTrainingList.sTrainingsList[index].trainingName.toLowerCase().contains('cardio') ? 'cardio_${Random().nextInt(11)+1}' :
        StaticTrainingList.sTrainingsList[index].trainingName.toLowerCase().contains('core') ? 'core_${Random().nextInt(11)+1}' :
        StaticTrainingList.sTrainingsList[index].trainingName.toLowerCase().contains('upper') ? 'upper_body_${Random().nextInt(11)+1}' :
        StaticTrainingList.sTrainingsList[index].trainingName.toLowerCase().contains('lower') ? 'lower_body_${Random().nextInt(11)+1}' :
        'full_body_${Random().nextInt(11)+1}'
        }.png');
      }
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(top: 52.0*UIScaler.getUiScaleFactor(context)),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Workouts',
                textAlign: TextAlign.center,
                style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.black, FontStyle.normal, context),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 82.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width - 112,
                    child:
                    MyCupertinoTextField(
                      onChanged: (val) {
//                        widget.msg = val;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.sentences,
                      placeholder: "Please enter Workout name",
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      padding: EdgeInsets.all(4.0),
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                      onTap: (){
                        setState(() {

                        });
                      },
                      child: Container(height : 56*UIScaler.getUiScaleFactor(context), width: 56*UIScaler.getUiScaleFactor(context), child: Padding(
                        padding: const EdgeInsets.only( right: 14, left : 14, top : 14 , bottom : 14),
                        child: Image.asset('assets/img/sort.png',),
                      ))),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 142.0, bottom: 56.0),
            child: ListView.builder(
                controller: _controller,
                padding: EdgeInsets.only(
                    top: 0, left: 0, right: 0, bottom: 0),
                itemCount: StaticTrainingList.sTrainingsList.length,
                itemBuilder: (context, index) {

                  var exFullTime = 0;

                  StaticTrainingList.sTrainingsList[index].trainingStartExerciseTimeList.forEach((element) {
                    if(element < 1000) {
                      exFullTime += element * 3000;
                    } else {
                      exFullTime += element;
                    }
                  });

                  StaticTrainingList.sTrainingsList[index].trainingMainExerciseTimeList.forEach((element) {
                    if(element < 1000) {
                      exFullTime += element * 3000;
                    } else {
                      exFullTime += element;
                    }
                  });

                  StaticTrainingList.sTrainingsList[index].trainingEndExerciseTimeList.forEach((element) {
                    if(element < 1000) {
                      exFullTime += element * 3000;
                    } else {
                      exFullTime += element;
                    }
                  });

                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExerciseTimeLineScreen(
                                  training: Training(
                                      id: Random().nextInt(4294967295),
                                      name: StaticTrainingList.sTrainingsList[index].trainingName,
                                      trainingDate: DateTime.now(),
                                      exercisesGroupId: StaticTrainingList.sTrainingsList[index].id,
                                      isDone: false,
                                      extraExerciseExitIndex: 3,
                                      isAlertEnable: true,
                                      alertStartTime : DateTime.now(),
                                      imagePath: imagePathList[index]
                                  ),
                              ),
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 2, bottom: 2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F8),
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                            width: double.infinity,
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
                                            Container(
                                              height: 60*UIScaler.getUiScaleFactor(context),
                                              width: 60*UIScaler.getUiScaleFactor(context),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(imagePathList[index])),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0.0, left: 16.0),
                                              child: Container(
                                                width: 290*UIScaler.getUiScaleFactor(context),
                                                height: 60*UIScaler.getUiScaleFactor(context),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container( width : 200*UIScaler.getUiScaleFactor(context), child: Text('${StaticTrainingList.sTrainingsList[index].trainingName}',  style: TextStyleBuilder.textStyleBuilder(16, 400, TextStyleColors.black, FontStyle.normal, context), maxLines: 2, overflow: TextOverflow.ellipsis,)),
                                                    Container(
                                                      width: double.infinity,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Row(
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
                                                          Row(
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
                                                        ],
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
                                                          3.0, StaticTrainingList.sTrainingsList[index].trainingHardness >= 1 ? Color(0xFF1D1D1D): Color.fromRGBO(29, 29, 29, 0.4))),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 6, left: 8),
                                                  child: CustomPaint(
                                                      painter: DrawCircle(
                                                          3.0, StaticTrainingList.sTrainingsList[index].trainingHardness >= 2 ? Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 6, left: 8),
                                                  child: CustomPaint(
                                                      painter: DrawCircle(
                                                          3.0, StaticTrainingList.sTrainingsList[index].trainingHardness >= 3 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 6, left: 8),
                                                  child: CustomPaint(
                                                      painter: DrawCircle(
                                                          3.0, StaticTrainingList.sTrainingsList[index].trainingHardness >= 4 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 6, left: 8),
                                                  child: CustomPaint(
                                                      painter: DrawCircle(
                                                          3.0, StaticTrainingList.sTrainingsList[index].trainingHardness >= 5 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
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
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
  }
}


import 'dart:math';

import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/data/moor_user_database.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/info_arguments.dart';
import 'package:Fit24/model/static_exercises_list.dart';
import 'package:Fit24/screens/introduction_screens/extra_info_screen.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserQuestionnaireScreen4 extends StatefulWidget {
  static const String routName = '/UserQuestionnaireScreen4';
  final Function f;

  UserQuestionnaireScreen4({this.f});

  @override
  _UserQuestionnaireScreen4State createState() =>
      _UserQuestionnaireScreen4State();
}

class _UserQuestionnaireScreen4State extends State<UserQuestionnaireScreen4> {

  Random rnd = new Random();
  var r = -1;
  var recomendedExercisesList = List<Widget>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if (r == -1){
    r = 30 + rnd.nextInt(40 - 30);
    }

    //SystemChrome.setEnabledSystemUIOverlays([]);

//
//    var imageWidth = MediaQuery.of(context).size.width/10*8;
//    if (recomendedExercisesList.isEmpty) {



    var usedExerciseIds = List();

    recomendedExercisesList = List<Widget>();
      for (int i = 0; i < r; i ++) {

        var isNewId = false;
        var exercise;

        do {
          exercise = StaticExercisesList.sExercisesList[Random().nextInt(
              StaticExercisesList.sExercisesList.length - 1)];

          if (!usedExerciseIds.contains(exercise.id)) {usedExerciseIds.add(exercise.id); isNewId = true;}
        }
        while (!isNewId);



        var player = VideoPlayerScreen('assets/video/${exercise.id}.mp4', true, MediaQuery
            .of(context)
            .size
            .width / 5 * 4,
            MediaQuery
                .of(context)
                .size
                .width / 5 * 4);

        recomendedExercisesList.add(
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 12),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 5 * 4,
                height: MediaQuery
                    .of(context)
                    .size
                    .width / 5 * 4,
                child: Stack(
                  children: <Widget>[
                    Align(alignment: Alignment.center,
                      child: player,
                    ),
                    Align(alignment: Alignment.topLeft, child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
                      child: Text(exercise.exerciseName,
                        style: TextStyleBuilder.textStyleBuilder(
                            20, 600, TextStyleColors.black, FontStyle.normal, context),),
                    ),
                    ),
//                    Align(alignment: Alignment.center,
//                      child: GestureDetector(
//                          onTap: (){
//                            setState(() {
//                              if (isPlaing)  {player.pause(); isPlaing = false;} else {player.play(); isPlaing = true;}
//                            });
//
//                          },
//                          child: Icon(Icons.play_arrow, size: 48, color: Colors.black38,)),
//                    ),
                  ],
                ),
              ),
            )
        );
      }
//    }

    calculateUserParams();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height+100,
            width: MediaQuery.of(context).size.width,
            child:  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Container(
                          height: 180*UIScaler.getUiScaleFactor(context),
                          color: Color(0xFFF6F6F8),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50*UIScaler.getUiScaleFactor(context),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[

                                    Container(
                                    width: 135*UIScaler.getUiScaleFactor(context),
                                    child:Row(
                                        children: <Widget>[
                                           GestureDetector(
                                             onTap: () {
                                               Navigator.of(context).pushNamed(
                                                 ExtraInfoScreen.routName,
                                                 arguments:
                                                 ScreenArguments(0),
                                               );
                                             },
                                             child: Text(
                                                'Body Mass Index',
                                                style: TextStyleBuilder.textStyleBuilder(12, 600, TextStyleColors.black, FontStyle.normal, context),
                                              ),
                                           ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                ExtraInfoScreen.routName,
                                                arguments:
                                                ScreenArguments(0),
                                              );
                                            },
                                            child: Padding(
                                              padding:  const EdgeInsets.only(bottom: 16, right: 0),
                                              child: Icon(
                                                Icons.info_outline,
                                                color: Colors.grey,
                                                size: 16*UIScaler.getUiScaleFactor(context),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                      Container(
                                        width: 68*UIScaler.getUiScaleFactor(context),
                                        child: Text(
                                          double.parse(UserRegistrationController.user.bodyMassIndex)
                                              .toStringAsFixed(2)
                                              .toString(),
                                          style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.orange, FontStyle.normal, context),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width-(80+115+80)*UIScaler.getUiScaleFactor(context),
                                        child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center ,children:[
                                          SizedBox(
                                            width: 89.0*UIScaler.getUiScaleFactor(context),
                                            height: 30.0*UIScaler.getUiScaleFactor(context),
                                            child: RaisedButton(
                                              color:
                                              double.parse(UserRegistrationController.user.bodyMassIndex) < 16.01 ? Color(0xFF87C5BA) :
                                              double.parse(UserRegistrationController.user.bodyMassIndex) < 18.51 ? Color(0xFF4C6C93) :
                                              double.parse(UserRegistrationController.user.bodyMassIndex) < 25.01 ? Color(0xFF73DD77) :
                                              double.parse(UserRegistrationController.user.bodyMassIndex) < 30.01 ? Color(0xFFCEDA5C) :
                                              double.parse(UserRegistrationController.user.bodyMassIndex) < 35.01 ? Color(0xFFFFB443) :
                                              Color(0xFFEA444E),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16.0),
                                                side: BorderSide(
                                                  color:
                                                  double.parse(UserRegistrationController.user.bodyMassIndex) < 16.01 ? Color(0xFF87C5BA) :
                                                  double.parse(UserRegistrationController.user.bodyMassIndex) < 18.51 ? Color(0xFF4C6C93) :
                                                  double.parse(UserRegistrationController.user.bodyMassIndex) < 25.01 ? Color(0xFF73DD77) :
                                                  double.parse(UserRegistrationController.user.bodyMassIndex) < 30.01 ? Color(0xFFCEDA5C) :
                                                  double.parse(UserRegistrationController.user.bodyMassIndex) < 35.01 ? Color(0xFFFFB443) :
                                                  Color(0xFFEA444E),),
                                              ),
                                              onPressed: () {
                                              },
                                              child: Text(
                                                double.parse(UserRegistrationController.user.bodyMassIndex) < 16.01 ? 'Severely underweight' :
                                                double.parse(UserRegistrationController.user.bodyMassIndex) < 18.51 ? 'Underweight' :
                                                double.parse(UserRegistrationController.user.bodyMassIndex) < 25.01 ? 'Healthy weight' :
                                                double.parse(UserRegistrationController.user.bodyMassIndex) < 30.01 ? 'Overweight' :
                                                double.parse(UserRegistrationController.user.bodyMassIndex) < 35.01 ? 'Moderately obese' :
                                                'Severely obese',
                                                style: TextStyle(color: Colors.white, fontSize: 10),
                                                textAlign: TextAlign.center,),
                                            ),
                                          ),
                                        ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50*UIScaler.getUiScaleFactor(context),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                    Container(
                                    width: 135*UIScaler.getUiScaleFactor(context),
                                    child: Row(children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              ExtraInfoScreen.routName,
                                              arguments:
                                              ScreenArguments(1),
                                            );
                                          },
                                          child: Text(
                                              'Basal Metabolic Rate ',
                                              style: TextStyleBuilder.textStyleBuilder(12, 600, TextStyleColors.black, FontStyle.normal, context),
                                            ),
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              ExtraInfoScreen.routName,
                                              arguments:
                                              ScreenArguments(1),
                                            );
                                          },
                                          child: Padding(
                                            padding:  const EdgeInsets.only(bottom: 16, right: 0),
                                            child: Icon(
                                              Icons.info_outline,
                                              color: Colors.grey,
                                              size: 16*UIScaler.getUiScaleFactor(context),
                                            ),
                                          ),
                                        ),
                                      ],),),
                                      Container(
                                        width: 68*UIScaler.getUiScaleFactor(context),
                                        child: Text(
                                          double.parse(UserRegistrationController.user.metabolicRate).toInt()
                                              .toStringAsFixed(0)
                                              .toString(),
                                          style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.orange, FontStyle.normal, context),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50*UIScaler.getUiScaleFactor(context),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 135*UIScaler.getUiScaleFactor(context),
                                        child: Text(
                                          'Daily Calorie Needs ',
                                          style: TextStyleBuilder.textStyleBuilder(12, 600, TextStyleColors.black, FontStyle.normal, context),
                                        ),
                                      ),
                                      Container(
                                        width: 68*UIScaler.getUiScaleFactor(context),
                                        child: Text(
                                          double.parse(UserRegistrationController.user.caloriesNeed).toInt()
                                              .toStringAsFixed(0)
                                              .toString(),
                                          style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.orange, FontStyle.normal, context),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20*UIScaler.getUiScaleFactor(context), left: 16*UIScaler.getUiScaleFactor(context), right: 16*UIScaler.getUiScaleFactor(context)),
                        child:
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyleBuilder.textStyleBuilder(16, 500, TextStyleColors.black, FontStyle.normal, context),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Based on your goal ',),
                                TextSpan(
                                  text: UserRegistrationController.user.fitnessStyleIndex == 0 ? ' - Lose weight ' : UserRegistrationController.user.fitnessStyleIndex == 1 ? '- Be more active ' : '- Build muscle ', style: TextStyleBuilder.textStyleBuilder(16, 500, TextStyleColors.orange, FontStyle.normal, context),),
                                TextSpan(
                                  text: 'and the calculated BMI, here\'s your personal workout plan',),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20*UIScaler.getUiScaleFactor(context), left: 16*UIScaler.getUiScaleFactor(context), right: 16*UIScaler.getUiScaleFactor(context)),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyleBuilder.textStyleBuilder(20, 500, TextStyleColors.black, FontStyle.normal, context),
                            children: <TextSpan>[
                              TextSpan(
                                text: '$r ', style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.orange, FontStyle.normal, context),),
                              TextSpan(
                                text: ' workout recommendations', style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.darkText, FontStyle.normal, context),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width/5*4,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: recomendedExercisesList,
                        ),
                      )
                    ],
                  )
            ),
          ),
      ),
    );
  }


  List _weightList;
  List _heightList;

  void calculateUserParams(){
    _weightList = List();
    _heightList = List();

    for (int x = 30; x < 300; x++) {
      _weightList.add(x);
    }

    for (int x = 120; x < 260; x++) {
      _heightList.add(x);
    }

//    print('s1${_calculateMetabolicRate(UserRegistrationController.user).toString()}');
    UserRegistrationController.user = UserRegistrationController.user.copyWith(metabolicRate: _calculateMetabolicRate(UserRegistrationController.user).toString());
//    print('s2${_calculatecaloriesNeed(UserRegistrationController.user).toString()}');
    UserRegistrationController.user = UserRegistrationController.user.copyWith(caloriesNeed: _calculatecaloriesNeed(UserRegistrationController.user).toString());
//    print('s3${_calculateBodyMassIndex(UserRegistrationController.user).toString()}');
    UserRegistrationController.user = UserRegistrationController.user.copyWith(bodyMassIndex: _calculateBodyMassIndex(UserRegistrationController.user).toString());

  }

  double _calculateMetabolicRate(User user){
    if (user.sexIndex == 0){
      return ( 10 * _weightList[double.parse(user.weightIndex).toInt()] ) + (6.25 * _heightList[double.parse(user.heightIndex).toInt()]) - (5 * _calculateAge(user.bd)) - 161;
    } else {
      return ( 10 * _weightList[double.parse(user.weightIndex).toInt()] ) + (6.25 * _heightList[double.parse(user.heightIndex).toInt()]) - (5 * _calculateAge(user.bd)) + 5;
    }

  }

  double _calculatecaloriesNeed(User user){

    var hardnessIndicator = (user.fitnessStyleIndex+1) * (user.workOutCount+1);

    if (hardnessIndicator > 0 && hardnessIndicator < 3) {
      return double.parse(user.metabolicRate) * 1.2;
    }
    else if (hardnessIndicator > 2 && hardnessIndicator < 9){
      return double.parse(user.metabolicRate) * 1.375;
    }
    else if (hardnessIndicator > 8 && hardnessIndicator < 12){
      return double.parse(user.metabolicRate) * 1.55;
    }
    else if (hardnessIndicator > 11 && hardnessIndicator < 14){
      return double.parse(user.metabolicRate) * 1.725;
    }
    else if (hardnessIndicator > 13 ){
      return double.parse(user.metabolicRate) * 1.9;
    }
    return 0.0;
  }

  double _calculateBodyMassIndex(User user){
    return _weightList[double.parse(user.weightIndex).toInt()]/((_heightList[double.parse(user.heightIndex).toInt()]/100)*(_heightList[double.parse(user.heightIndex).toInt()]/100));
  }

  int _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

}

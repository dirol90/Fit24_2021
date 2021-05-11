import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/my_cupertino_slider.dart';
import 'package:Fit24/widget/rounded_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserQuestionnaireScreen2 extends StatefulWidget {
  static const String routName = '/UserQuestionnaireScreen2';
  final Function f;

  UserQuestionnaireScreen2({this.f});

  @override
  _UserQuestionnaireScreen2State createState() =>
      _UserQuestionnaireScreen2State();
}

class _UserQuestionnaireScreen2State extends State<UserQuestionnaireScreen2> {

var p0 = 0.0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //SystemChrome.setEnabledSystemUIOverlays([]);

    p0 = double.parse(UserRegistrationController.user.trainingTimesPerWeek);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: (MediaQuery
            .of(context)
            .size
            .height - 160),
        child: Padding(
          padding: EdgeInsets.only(top: 24.0*UIScaler.getUiScaleFactor(context)),
          child: ListView(
              padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(8*UIScaler.getUiScaleFactor(context), 0, 0, 8*UIScaler.getUiScaleFactor(context)),
                            child: GestureDetector(
                                onTap: () {
//                                  print('WIDGET2');
                                  widget.f();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                                )),
                          ),
                          Container(

                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0.0, left: 16.0),
                                  child: Text(
                                    'What would you like to accomplish?',
                                    style: TextStyleBuilder.textStyleBuilder(
                                        20,
                                        600,
                                        TextStyleColors.black,
                                        FontStyle.normal, context),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            UserRegistrationController.user =   UserRegistrationController.user.copyWith(fitnessStyleIndex: 0);
//                                        dao.updateUser(users[0].copyWith(fitnessStyleIndex: 0));
                                          });
                                        },
                                        child: Transform.scale(
                                          scale: UserRegistrationController.user.fitnessStyleIndex == 0 ? 1.05 : 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width-50,
                                              height: (MediaQuery.of(context).size.height / 7.75),
                                              decoration: myBoxDecoration(
                                                  UserRegistrationController.user.fitnessStyleIndex == 0 ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Transform.scale(
                                                        scale: UserRegistrationController.user.fitnessStyleIndex == 0
                                                            ? 1.3
                                                            : 1,
                                                        child: Image.asset(
                                                          UserRegistrationController.user.fitnessStyleIndex == 0
                                                              ? 'assets/img/weight_selected_icon.png'
                                                              : 'assets/img/weight_unselected_icon.png',
                                                          height: 22,
                                                          width: 22,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Lose weight',
                                                        style: UserRegistrationController.user.fitnessStyleIndex == 0
                                                            ? TextStyleBuilder
                                                                .textStyleBuilder(
                                                                    24,
                                                                    500,
                                                                    TextStyleColors
                                                                        .orange,
                                                                    FontStyle
                                                                        .normal, context)
                                                            : TextStyleBuilder
                                                                .textStyleBuilder(
                                                                    24,
                                                                    500,
                                                                    TextStyleColors
                                                                        .darkGrey,
                                                                    FontStyle
                                                                        .normal, context),
                                                      ),
                                                      Opacity(
                                                        opacity:
                                                        UserRegistrationController.user.fitnessStyleIndex == 0
                                                            ? 1
                                                                : 0,
                                                        child: Transform.scale(
                                                          scale:
                                                          UserRegistrationController.user.fitnessStyleIndex == 0
                                                              ? 1.5
                                                                  : 1,
                                                          child: CircleCheckbox(
                                                            value:
                                                            UserRegistrationController.user.fitnessStyleIndex == 0 ,
                                                            onChanged: (bool b) {},
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            UserRegistrationController.user =   UserRegistrationController.user.copyWith(fitnessStyleIndex: 1);
//                                        dao.updateUser(users[0].copyWith(fitnessStyleIndex: 1));
                                          });
                                        },
                                        child: Transform.scale(
                                          scale: UserRegistrationController.user.fitnessStyleIndex == 1  ? 1.05 : 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width-50,
                                              height:(MediaQuery.of(context).size.height / 7.75),
                                              decoration: myBoxDecoration(
                                                  UserRegistrationController.user.fitnessStyleIndex == 1),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Transform.scale(
                                                        scale: UserRegistrationController.user.fitnessStyleIndex == 1
                                                            ? 1.3
                                                            : 1,
                                                        child: Image.asset(
                                                          UserRegistrationController.user.fitnessStyleIndex == 1
                                                              ? 'assets/img/jumper_selected_icon.png'
                                                              : 'assets/img/jumper_unselected_icon.png',
                                                          height: 22,
                                                          width: 22,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Be more active',
                                                        style: UserRegistrationController.user.fitnessStyleIndex == 1
                                                            ? TextStyleBuilder
                                                                .textStyleBuilder(
                                                                    24,
                                                                    500,
                                                                    TextStyleColors
                                                                        .orange,
                                                                    FontStyle
                                                                        .normal, context)
                                                            : TextStyleBuilder
                                                                .textStyleBuilder(
                                                                    24,
                                                                    500,
                                                                    TextStyleColors
                                                                        .darkGrey,
                                                                    FontStyle
                                                                        .normal, context),
                                                      ),
                                                      Opacity(
                                                        opacity:
                                                        UserRegistrationController.user.fitnessStyleIndex == 1
                                                                ? 1
                                                                : 0,
                                                        child: Transform.scale(
                                                          scale:
                                                          UserRegistrationController.user.fitnessStyleIndex == 1
                                                                  ? 1.5
                                                                  : 1,
                                                          child: CircleCheckbox(
                                                            value:
                                                            UserRegistrationController.user.fitnessStyleIndex == 1,
                                                            onChanged: (bool b) {},
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            UserRegistrationController.user =   UserRegistrationController.user.copyWith(fitnessStyleIndex: 2);
//                                        dao.updateUser(users[0].copyWith(fitnessStyleIndex: 2));

                                          });
                                        },
                                        child: Transform.scale(
                                          scale: UserRegistrationController.user.fitnessStyleIndex == 2 ? 1.05 : 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width-50,
                                              height: (MediaQuery.of(context).size.height / 7.75),
                                              decoration: myBoxDecoration(
                                                  UserRegistrationController.user.fitnessStyleIndex == 2),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Transform.scale(
                                                        scale: UserRegistrationController.user.fitnessStyleIndex == 2
                                                            ? 1.3
                                                            : 1,
                                                        child: Image.asset(
                                                          UserRegistrationController.user.fitnessStyleIndex == 2
                                                              ? 'assets/img/muscle_selected_icon.png'
                                                              : 'assets/img/muscle_unselected_icon.png',
                                                          height: 22,
                                                          width: 22,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Build muscle',
                                                        style: UserRegistrationController.user.fitnessStyleIndex == 2
                                                            ? TextStyleBuilder
                                                                .textStyleBuilder(
                                                                    24,
                                                                    500,
                                                                    TextStyleColors
                                                                        .orange,
                                                                    FontStyle
                                                                        .normal, context)
                                                            : TextStyleBuilder
                                                                .textStyleBuilder(
                                                                    24,
                                                                    500,
                                                                    TextStyleColors
                                                                        .darkGrey,
                                                                    FontStyle
                                                                        .normal, context),
                                                      ),
                                                      Opacity(
                                                        opacity:
                                                        UserRegistrationController.user.fitnessStyleIndex == 2
                                                                ? 1
                                                                : 0,
                                                        child: Transform.scale(
                                                          scale:
                                                          UserRegistrationController.user.fitnessStyleIndex == 2
                                                                  ? 1.5
                                                                  : 1,
                                                          child: CircleCheckbox(
                                                            value:
                                                            UserRegistrationController.user.fitnessStyleIndex == 2,
                                                            onChanged: (bool b) {},
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyleBuilder.textStyleBuilder(
                                          20,
                                          500,
                                          TextStyleColors.black,
                                          FontStyle.normal, context),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'I would like to exercise ',
                                          style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.black, FontStyle.normal, context),
                                        ),
                                        TextSpan(
                                          text: '${double.parse(UserRegistrationController.user.trainingTimesPerWeek).toInt()} time${double.parse(UserRegistrationController.user.trainingTimesPerWeek).toInt() <= 1 ? '' : 's'}',
                                          style: TextStyleBuilder.textStyleBuilder(
                                              20,
                                              600,
                                              TextStyleColors.orange,
                                              FontStyle.normal, context),
                                        ),
                                        TextSpan(
                                          text: ' a week',
                                          style: TextStyleBuilder.textStyleBuilder(20, 600, TextStyleColors.black, FontStyle.normal, context)
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0, right: 4),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 38,
                                          width: MediaQuery.of(context).size.width-32,
                                          child: MyCupertinoSlider(
                                            value: double.parse(UserRegistrationController.user.trainingTimesPerWeek) == 2 ? 2.3 : double.parse(UserRegistrationController.user.trainingTimesPerWeek),
                                            onChanged: (val) {
                                              if (val >= 0 && val < 2.99 ) { val = 2.25;}
                                              if (val > 3 && val < 3.99 ) { val = 3.25;}
                                              if (val > 4 && val < 4.99 ) { val = 4.25;}
                                              if (val > 5 && val < 5.99 ) { val = 5.25;}
                                              if (val > 6 && val < 6.99 ) { val = 6.25;}
                                              if (val > 7 && val < 7.99 ) { val = 7.25;}
                                              setState(() {
                                                p0 = val;
                                                UserRegistrationController.user =   UserRegistrationController.user.copyWith(trainingTimesPerWeek: val.toString());
//                                    dao.updateUser(users[0].copyWith(userQuestion1: val.toInt()));
                                              });
                                            },
                                            activeColor:  Color(0xFF1D1D1D),
                                            min: 2.0,
                                            max: 7.49,
                                          ),
                                        ),
                                      ),
                                      Positioned(left: (p0 == 2 ? 0.35 : p0 -1.95)/(7.49-2)*((MediaQuery.of(context).size.width-74)) , child: IgnorePointer(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset('assets/img/circle.png', height : 34, width: 34,),
                                        ),
                                      ),
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
          ]),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration(bool isSelected) {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: isSelected ? Color(0xFFFF6B4A) : Color(0xFFC4C4C4),
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    );
  }
}

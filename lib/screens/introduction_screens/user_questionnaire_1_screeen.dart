import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/my_cupertino_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserQuestionnaireScreen1 extends StatefulWidget {
  static const String routName = '/UserQuestionnaireScreen1';
  final Function f;

  UserQuestionnaireScreen1({this.f});

  @override
  _UserQuestionnaireScreen1State createState() =>
      _UserQuestionnaireScreen1State();
}

class _UserQuestionnaireScreen1State extends State<UserQuestionnaireScreen1> {
  Function refresh() {
    setState(() {});
    return null;
  }

  var p1  = double.parse(UserRegistrationController.user.userQuestion1);
  var p2  = double.parse(UserRegistrationController.user.userQuestion2);
  var p3  = double.parse(UserRegistrationController.user.userQuestion3);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:  Container(
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
                  child: GestureDetector(onTap: () {
//                    print('WIDGET1');
                    widget.f();
                  }, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                  )),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 0, 16*UIScaler.getUiScaleFactor(context), 8),
                        child: Text(
                          'How many times a week do you do sports?',
                          style: TextStyleBuilder.textStyleBuilder(
                              20, 600, TextStyleColors.black,
                              FontStyle.normal, context),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width-32,
                            child: MyCupertinoSlider(
                              value: double.parse(UserRegistrationController.user.userQuestion1) == 0 ? 0.25 : double.parse(UserRegistrationController.user.userQuestion1),
                              onChanged: (val) {
                                if (val >= 0 && val < 0.99 ) { val = 0.25;}
                                if (val > 0.99 && val < 1.99 ) { val = 1.25;}
                                if (val > 1.99 && val < 2.99 ) { val = 2.25;}
                                if (val > 2.99 && val < 3.99 ) { val = 3.25;}
                                if (val > 3.99 && val < 4.99 ) { val = 4.25;}
                                  setState(() {
                                    p1 = val;
                                    UserRegistrationController.user =
                                        UserRegistrationController.user
                                            .copyWith(
                                            userQuestion1: val.toString());
//                                    dao.updateUser(users[0].copyWith(userQuestion1: val.toInt()));
                                  });
                              },
                              activeColor: Color(0xFF1D1D1D),
                              min: 0.0,
                              max: 4.49,
                            ),
                          ),
                          Positioned(left: (p1== 0 ? 0.25 : p1 -0)/(4.49-0)*((MediaQuery.of(context).size.width-78)) , child: IgnorePointer(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/img/circle.png', height : 34, width: 34,),
                            ),
                            ),
                          ),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                            double.parse(UserRegistrationController.user.userQuestion1) <  1 ? 'Barely ever'
                                : double.parse(UserRegistrationController.user.userQuestion1) < 2 ? 'Once'
                                : double.parse(UserRegistrationController.user.userQuestion1) < 3 ? '2-3 times'
                                : double.parse(UserRegistrationController.user.userQuestion1) < 4 ? '4 times'
                                : double.parse(UserRegistrationController.user.userQuestion1) < 5 ? '5 times or more' : '5 times or more',
                          style: TextStyleBuilder.textStyleBuilder(
                              16, 500, TextStyleColors.orange,
                              FontStyle.normal, context),
                          textScaleFactor: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            'How many push-ups can you do in one go?',
                            style: TextStyleBuilder.textStyleBuilder(
                                20, 600, TextStyleColors.black,
                                FontStyle.normal, context),
                            textAlign: TextAlign.start,
                          ),
                        ),

                        Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width-32,
                              child: MyCupertinoSlider(
                                value: double.parse(UserRegistrationController.user.userQuestion2) == 0 ? 0.25 : double.parse(UserRegistrationController.user.userQuestion2),
                                onChanged: (val) {
                                  if (val >= 0 && val < 0.99 ) { val = 0.25;}
                                  if (val > 0.99 && val < 1.99 ) { val = 1.25;}
                                  if (val > 1.99 && val < 2.99 ) { val = 2.25;}
                                  if (val > 2.99 && val < 3.99 ) { val = 3.25;}
                                  if (val > 3.99 && val < 4.99 ) { val = 4.25;}
                                  setState(() {
                                    p2 = val;
                                    UserRegistrationController.user =   UserRegistrationController.user.copyWith(userQuestion2: val.toString());
//                                    dao.updateUser(users[0].copyWith(userQuestion1: val.toInt()));
                                  });
                                },
                                activeColor: Color(0xFF1D1D1D),
                                min: 0.0,
                                max: 4.49,
                              ),
                            ),
                            Positioned(left: (p2== 0 ? 0.25 : p2 -0)/(4.49-0)*((MediaQuery.of(context).size.width-78)) , child: IgnorePointer(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/img/circle.png', height : 34, width: 34,),
                              ),
                            ),
                            ),

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            double.parse(UserRegistrationController.user.userQuestion2) < 1 ? 'Less than 5'
                                : double.parse(UserRegistrationController.user.userQuestion2)  < 2 ? '5-10'
                                : double.parse(UserRegistrationController.user.userQuestion2)  < 3 ? '10-15'
                                : double.parse(UserRegistrationController.user.userQuestion2)  < 4 ? '15-20'
                                : double.parse(UserRegistrationController.user.userQuestion2)  < 5 ? 'More than 20' : 'More than 20',
                            style: TextStyleBuilder.textStyleBuilder(
                                16, 500, TextStyleColors.orange,
                                FontStyle.normal, context),
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Text(
                            'How long can you run for without a break?',
                            style: TextStyleBuilder.textStyleBuilder(
                                20, 600, TextStyleColors.black,
                                FontStyle.normal, context),
                            textAlign: TextAlign.start,
                          ),
                        ),

                        Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width-32,
                              child: MyCupertinoSlider(
                                value: double.parse(UserRegistrationController.user.userQuestion3) == 0 ? 0.25 : double.parse(UserRegistrationController.user.userQuestion3),
                                onChanged: (val) {
                                  if (val >= 0 && val < 0.99 ) { val = 0.25;}
                                  if (val > 0.99 && val < 1.99 ) { val = 1.25;}
                                  if (val > 1.99 && val < 2.99 ) { val = 2.25;}
                                  if (val > 2.99 && val < 3.99 ) { val = 3.25;}
                                  if (val > 3.99 && val < 4.99 ) { val = 4.25;}
                                  setState(() {
                                    p3 = val;
                                    UserRegistrationController.user = UserRegistrationController.user.copyWith(userQuestion3: val.toString());
//                                    dao.updateUser(users[0].copyWith(userQuestion1: val.toInt()));
                                  });
                                },
                                activeColor: Color(0xFF1D1D1D),
                                min: 0.0,
                                max: 4.49,
                              ),
                            ),
                            Positioned(left: (p3== 0 ? 0.25 : p3 -0)/(4.49-0)*((MediaQuery.of(context).size.width-78)) , child: IgnorePointer(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/img/circle.png', height : 34, width: 34,),
                              ),
                            ),
                            ),

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            double.parse(UserRegistrationController.user.userQuestion3) <  1 ? 'Less than 5 min'
                                : double.parse(UserRegistrationController.user.userQuestion3) < 2 ? '5-10 min'
                                : double.parse(UserRegistrationController.user.userQuestion3) <  3 ? '10-15 min'
                                : double.parse(UserRegistrationController.user.userQuestion3) <  4 ? '15-25 min'
                                : double.parse(UserRegistrationController.user.userQuestion3) <  5 ? 'More than 25 min' : 'More than 25 min',
                            style: TextStyleBuilder.textStyleBuilder(
                                16, 500, TextStyleColors.orange,
                                FontStyle.normal, context),
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    )
    );
  }
}

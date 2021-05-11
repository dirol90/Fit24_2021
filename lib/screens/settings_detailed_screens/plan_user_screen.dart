import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/my_cupertino_slider.dart';
import 'package:Fit24/widget/rounded_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class PlanUserSettingDetailedScreen extends StatefulWidget {
  static const String routName = '/PlanUserSettingDetailedScreen';

  Function f;
  PlanUserSettingDetailedScreen({this.f});

  @override
  _PlanUserSettingDetailedScreenState createState() => _PlanUserSettingDetailedScreenState();
}

class _PlanUserSettingDetailedScreenState extends State<PlanUserSettingDetailedScreen> {
  Function refresh() {
    setState(() {});
    return null;
  }

  User user;

  var p0 = 2.0;

  double trainingTimesPerWeekWas = 0.0;
  int fitnessStyleIndexWas = -1;

  UserDao _u_dao;

  @override
  Widget build(BuildContext context) {

    if (_u_dao == null  ) {
      _u_dao = Provider.of<UserDao>(context);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
            stream: _u_dao.watchAllUsers(),
            builder: (context, AsyncSnapshot<List<User>> snapshot) {

              final users = snapshot.data ?? List();
              if (user == null) user = users.length > 0 ? users[0] : null;
              if (user != null) {p0 = double.parse(user.trainingTimesPerWeek); trainingTimesPerWeekWas == 0.0 ? trainingTimesPerWeekWas = p0 : trainingTimesPerWeekWas; fitnessStyleIndexWas == -1 ? fitnessStyleIndexWas = user.fitnessStyleIndex : fitnessStyleIndexWas;}

              return Padding(
                padding:  EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 52*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context)),
                child: user != null ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 0, right: 8, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(onTap: (){widget.f(0);}, child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                            )),
                          ),
                          GestureDetector(onTap: (){

                            if (trainingTimesPerWeekWas != double.parse(user.trainingTimesPerWeek) || fitnessStyleIndexWas != user.fitnessStyleIndex){
                              Fluttertoast.showToast(
                                  msg: "Changes made to your workout plan will reflect on your next week plan",
                                  toastLength: Toast
                                      .LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Color(
                                      0xFF666666),
                                  textColor: Colors.white,
                                  fontSize: 12.0
                              );

                            }
                            _u_dao.updateUser(user).then((_){widget.f(0);});
                            },
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('Save', style: TextStyleBuilder.textStyleBuilder(16, 400, TextStyleColors.orange, FontStyle.normal, context),),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 175,
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          Padding(
                            padding:
                            EdgeInsets.only(top: 0.0*UIScaler.getUiScaleFactor(context), left: 16.0*UIScaler.getUiScaleFactor(context)),
                            child: Text(
                              'What result do you expect?',
                              style: TextStyleBuilder.textStyleBuilder(
                                  24,
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
                                      user =   user.copyWith(fitnessStyleIndex: 0);
                                    });
                                  },
                                  child: Transform.scale(
                                    scale: user.fitnessStyleIndex == 0 ? 1.05 : 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width-50,
                                        height: (MediaQuery.of(context).size.width-50) / 3.25,
                                        decoration: myBoxDecoration(
                                            user.fitnessStyleIndex == 0 ),
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
                                                  scale: user.fitnessStyleIndex == 0
                                                      ? 1.3
                                                      : 1,
                                                  child: Image.asset(
                                                    user.fitnessStyleIndex == 0
                                                        ? 'assets/img/weight_selected_icon.png'
                                                        : 'assets/img/weight_unselected_icon.png',
                                                    height: 22,
                                                    width: 22,
                                                  ),
                                                ),
                                                Text(
                                                  'Lose weight',
                                                  style: user.fitnessStyleIndex == 0
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
                                                  user.fitnessStyleIndex == 0
                                                      ? 1
                                                      : 0,
                                                  child: Transform.scale(
                                                    scale:
                                                    user.fitnessStyleIndex == 0
                                                        ? 1.2
                                                        : 1,
                                                    child: CircleCheckbox(
                                                      value:
                                                      user.fitnessStyleIndex == 0 ,
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
                                      user =   user.copyWith(fitnessStyleIndex: 1);
//                                        dao.updateUser(users[0].copyWith(fitnessStyleIndex: 1));
                                    });
                                  },
                                  child: Transform.scale(
                                    scale: user.fitnessStyleIndex == 1  ? 1.05 : 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width-50,
                                        height: (MediaQuery.of(context).size.width-50) / 3.25,
                                        decoration: myBoxDecoration(
                                            user.fitnessStyleIndex == 1),
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
                                                  scale: user.fitnessStyleIndex == 1
                                                      ? 1.3
                                                      : 1,
                                                  child: Image.asset(
                                                    user.fitnessStyleIndex == 1
                                                        ? 'assets/img/jumper_selected_icon.png'
                                                        : 'assets/img/jumper_unselected_icon.png',
                                                    height: 22,
                                                    width: 22,
                                                  ),
                                                ),
                                                Text(
                                                  'Be more active',
                                                  style: user.fitnessStyleIndex == 1
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
                                                  user.fitnessStyleIndex == 1
                                                      ? 1
                                                      : 0,
                                                  child: Transform.scale(
                                                    scale:
                                                    user.fitnessStyleIndex == 1
                                                        ? 1.2
                                                        : 1,
                                                    child: CircleCheckbox(
                                                      value:
                                                      user.fitnessStyleIndex == 1,
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
                                      user =   user.copyWith(fitnessStyleIndex: 2);
//                                        dao.updateUser(users[0].copyWith(fitnessStyleIndex: 2));

                                    });
                                  },
                                  child: Transform.scale(
                                    scale: user.fitnessStyleIndex == 2 ? 1.05 : 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width-50,
                                        height: (MediaQuery.of(context).size.width-50) / 3.25,
                                        decoration: myBoxDecoration(
                                            user.fitnessStyleIndex == 2),
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
                                                  scale: user.fitnessStyleIndex == 2
                                                      ? 1.3
                                                      : 1,
                                                  child: Image.asset(
                                                    user.fitnessStyleIndex == 2
                                                        ? 'assets/img/muscle_selected_icon.png'
                                                        : 'assets/img/muscle_unselected_icon.png',
                                                    height: 22,
                                                    width: 22,
                                                  ),
                                                ),
                                                Text(
                                                  'Build Muscle',
                                                  style: user.fitnessStyleIndex == 2
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
                                                  user.fitnessStyleIndex == 2
                                                      ? 1
                                                      : 0,
                                                  child: Transform.scale(
                                                    scale:
                                                    user.fitnessStyleIndex == 2
                                                        ? 1.2
                                                        : 1,
                                                    child: CircleCheckbox(
                                                      value:
                                                      user.fitnessStyleIndex == 2,
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
                                    24,
                                    600,
                                    TextStyleColors.black,
                                    FontStyle.normal, context),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'I would like to train ',
                                  ),
                                  TextSpan(
                                    text: '${double.parse(user.trainingTimesPerWeek).toInt()} ',
                                    style: TextStyleBuilder.textStyleBuilder(
                                        24,
                                        600,
                                        TextStyleColors.orange,
                                        FontStyle.normal, context),
                                  ),
                                  TextSpan(
                                    text: 'time${double.parse(user.trainingTimesPerWeek).toInt() <= 1 ? '' : 's'} a week',
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Container(
                                height: 38,
                                width: MediaQuery.of(context).size.width-32,
                                child: MyCupertinoSlider(
                                  value: double.parse(user.trainingTimesPerWeek),
                                  onChanged: (val) {
                                    if (val >= 0 && val < 2.99 ) { val = 2.25;}
                                    if (val > 3 && val < 3.99 ) { val = 3.25;}
                                    if (val > 4 && val < 4.99 ) { val = 4.25;}
                                    if (val > 5 && val < 5.99 ) { val = 5.25;}
                                    if (val > 6 && val < 6.99 ) { val = 6.25;}
                                    if (val > 7 && val < 7.99 ) { val = 7.25;}
                                    setState(() {
                                      p0 = val;
                                      user =   user.copyWith(trainingTimesPerWeek: val.toString());
//                                    dao.updateUser(users[0].copyWith(userQuestion1: val.toInt()));
                                    });
                                  },
                                  activeColor: Color(0xFF1D1D1D),
                                  min: 2.0,
                                  max: 7.49,
                                ),
                              ),
                              Positioned(left: (p0-2)/(7.49-2)*((MediaQuery.of(context).size.width-78)) , child: IgnorePointer(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/img/circle.png', height : 34, width: 34,),
                                ),
                              ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ) : Container(),
              );
            }),
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

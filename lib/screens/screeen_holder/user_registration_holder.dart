import 'dart:math';

import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/data/moor_user_database.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/screens/introduction_screens/user_questionnaire_0_screeen.dart';
import 'package:Fit24/screens/introduction_screens/user_questionnaire_1_screeen.dart';
import 'package:Fit24/screens/introduction_screens/user_questionnaire_2_screeen.dart';
import 'package:Fit24/screens/introduction_screens/user_subscription_screen_5.dart';
import 'package:Fit24/screens/introduction_screens/user_total_info_4_screen.dart';
import 'package:Fit24/screens/introduction_screens/user_video_questionnaire_3.dart';
import 'package:Fit24/screens/screeen_holder/screen_main_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class UserRegistrationController extends StatefulWidget {
  static const String routName = '/UserRegistrationController';
  static User user;

  @override
  _UserRegistrationControllerState createState() =>
      _UserRegistrationControllerState();
}

class _UserRegistrationControllerState
    extends State<UserRegistrationController> {
  var widgets;

  final key = GlobalKey<PageContainerState>();

  var pageController = PageController();
  var whichPage = 0;
  var isHideBottomClock = false;
  var isHideBottomText = false;
  var btnText = 'NEXT';

  UserDao _u_dao;

//  UserDao dao;

  Function backPressed() {
    setState(() {
      _u_dao.updateUser(UserRegistrationController.user);
      whichPage = whichPage - 1;
      pageController.animateToPage(whichPage,
          duration: Duration(milliseconds: 500), curve: Curves.easeInCubic);
    });
  }

  @override
  Widget build(BuildContext context) {

//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);


    if (_u_dao == null ) {
      _u_dao = Provider.of<UserDao>(context);
    }

    var selectors = [
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: whichPage >= 0 ? Image.asset('assets/img/selected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),) : Image.asset('assets/img/unselected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),),
      ),
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: whichPage >= 1 ? Image.asset('assets/img/selected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),) : Image.asset('assets/img/unselected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),),
      ),
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: whichPage >= 2 ? Image.asset('assets/img/selected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),) : Image.asset('assets/img/unselected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),),
      ),
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: whichPage >= 3 ? Image.asset('assets/img/selected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),) : Image.asset('assets/img/unselected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),),
      ),
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: whichPage >= 4 ? Image.asset('assets/img/selected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),) : Image.asset('assets/img/unselected_rect.png', height: 5*UIScaler.getUiScaleFactor(context), width: MediaQuery.of(context).size.width/7*1.15*UIScaler.getUiScaleFactor(context),),
      ),
    ];
    
    widgets = [
      UserQuestionnaireScreen0(f: backPressed),
      UserQuestionnaireScreen1(f: backPressed),
      UserQuestionnaireScreen2(f: backPressed),
      UserQuestionnaireScreen3(f: backPressed),
      UserQuestionnaireScreen4(f: backPressed),
    ];

    return StreamBuilder<List<User>>(
        stream: _u_dao.watchAllUsers(),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {

          final users = snapshot.data ;
          if (users != null && users.length == 0) {
            UserRegistrationController.user = User(
              id: 0,
              bd: DateTime(1990, 01, 01),
              bodyMassIndex: '0.0',
              caloriesNeed: '0.0',
              fitnessStyleIndex: 0,
              healsStatus: 0,
              heightIndex: '30.0',
              weightIndex: '15.0',
              metabolicRate: '0.0',
              name: '',
              sexIndex: 0,
              trainingsDone: 0,
              trainingSpendCalories: 0,
              trainingSpendTime: '0.0',
              workOutCount: 0,
              userWeightChanges: '',
              userQuestion1: '0.0',
              userQuestion2: '0.0',
              userQuestion3: '0.0',
              trainingTimesPerWeek: '2.0',
              isSettingsFinished: false,
              isSubscriptionBought: false,
              heightMeasure: 0,
              weightMeasure: 0,
            );

            _u_dao.insertUser(UserRegistrationController.user);
          } else if (users != null && users.length > 0 && UserRegistrationController.user == null) {
            UserRegistrationController.user = users[0];
          }

//            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

          return Scaffold(

            body: Column(children: <Widget>[
              whichPage == 3 ? Container() : Container(
                height: 64*UIScaler.getUiScaleFactor(context),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top : 52.0*UIScaler.getUiScaleFactor(context)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: whichPage > 4 ? Container() : selectors,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PageIndicatorContainer(
                  child: PageView(
                      children: <Widget>[
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0, 0, 0, 16*UIScaler.getUiScaleFactor(context)),
                          child: UserQuestionnaireScreen0(f: backPressed),
                        ),
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0, 0, 0, 16*UIScaler.getUiScaleFactor(context)),
                          child: UserQuestionnaireScreen1(f: backPressed),
                        ),
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0, 0, 0, 16*UIScaler.getUiScaleFactor(context)),
                          child: UserQuestionnaireScreen2(f: backPressed),
                        ),
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0, 0, 0, 76*UIScaler.getUiScaleFactor(context)),
                          child: UserQuestionnaireScreen3(f: backPressed),
                        ),
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0, 0, 0, 16*UIScaler.getUiScaleFactor(context)),
                          child: UserQuestionnaireScreen4(f: backPressed),
                        ),
                      ],
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics()),
                  align: IndicatorAlign.top,
                  length: widgets.length,
                  indicatorSpace: 0.1,
                  padding: const EdgeInsets.all(0),
                  indicatorColor: Colors.white,

                  indicatorSelectorColor: Colors.white,
                  shape: IndicatorShape.roundRectangleShape(
                      cornerSize: Size(0, 0.0),
                      size: Size(
                          (MediaQuery.of(context).size.width /
                              (widgets.length + 1))*UIScaler.getUiScaleFactor(context),
                          4.0)), //MediaQuery.of(context).size.width / (vidgets.length+1)
                ),
              ),
            ],),
            bottomSheet: isHideBottomClock
                ? Container(
                    height: 0,
                  )
                : Container(
                    height: 106*UIScaler.getUiScaleFactor(context),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: !isHideBottomText
                              ? Text(
                            whichPage == 1 ?  'If you don’t have an answer, just keep the recommended selection' : 'You can change this information in your profile later',
                                  style: TextStyleBuilder.textStyleBuilder(
                                      11,
                                      400,
                                      TextStyleColors.darkGrey,
                                      FontStyle.normal, context),
                                  textAlign: TextAlign.center,
                                )
                              : Container(
                                  height: 16*UIScaler.getUiScaleFactor(context),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40.0*UIScaler.getUiScaleFactor(context),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0*UIScaler.getUiScaleFactor(context)),
                                  side: BorderSide(
                                      color: Theme.of(context).buttonColor)),
                              onPressed: () {
                                btnPressFunction(widgets);
                              },
                              child: Text(btnText.toUpperCase(),
                                  style: TextStyleBuilder.textStyleBuilder(
                                      15,
                                      500,
                                      TextStyleColors.white,
                                      FontStyle.normal, context)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }

  void btnPressFunction(List<StatefulWidget> widgets) {
    FocusScope.of(context).unfocus();
    if(UserRegistrationController.user.name != '') {
      if (!isHideBottomText) {
        whichPage = whichPage + 1;
        if (pageController != null &&
            whichPage != widgets.length - 2 &&
            whichPage != widgets.length - 1) {
          setState(() {
            pageController.animateToPage(whichPage,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInCubic);
          });
        } else if (whichPage != widgets.length - 1) {
          setState(() {
            isHideBottomClock = true;
            pageController.animateToPage(whichPage,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInCubic);
            Future.delayed(const Duration(milliseconds: 10500), () {
              setState(() {
                btnText = 'START';
                whichPage = whichPage + 1;
                isHideBottomClock = false;
                isHideBottomText = true;
                pageController.animateToPage(whichPage,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInCubic);
              });
            });
          });
        }

        if (whichPage == widgets.length - 2 &&
            !UserRegistrationController.user.isSettingsFinished) {
          UserRegistrationController.user =
              UserRegistrationController.user.copyWith(
                  isSettingsFinished: true);
        }
      } else {
        Navigator.of(context).pushNamed(UserSubscriptionScreen5.routName);
      }

      _u_dao.updateUser(UserRegistrationController.user);
    } else {
      Fluttertoast.showToast(
          msg: "Please fill in name field",
          toastLength: Toast
              .LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(
              0xFF666666),
          textColor: Colors.white,
          fontSize: 12.0
      );
    }
  }
}

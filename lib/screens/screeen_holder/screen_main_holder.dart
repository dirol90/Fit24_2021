import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/helper/statefull_wrapper.dart';
import 'package:Fit24/screens/introduction_screens/splash_screen.dart';
import 'package:Fit24/screens/introduction_screens/user_subscription_screen_5.dart';
import 'package:Fit24/screens/introduction_screens/video_splash_screen.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/screens/app_screens/settings_screen.dart';
import 'package:Fit24/screens/navigation/destination_view.dart';
import 'package:Fit24/screens/navigation/destinations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import '../../subscription_helper.dart';

class MainScreenHolder extends StatefulWidget with ChangeNotifier {
  static const String routName = '/MainScreenHolder';

  @override
  _MainScreenHolderState createState() => _MainScreenHolderState();
  int _currentIndex = 0;

  get currentIndex {
    return _currentIndex;
  }

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class _MainScreenHolderState extends State<MainScreenHolder>
    with ChangeNotifier, TickerProviderStateMixin {
  var tabIndex = 0;
  UserDao _u_dao;
  bool isInfoDialogClose = false;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);


    if (_u_dao == null) {
      _u_dao = Provider.of<UserDao>(context);
    }
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    //SystemChrome.setEnabledSystemUIOverlays([]);


    WidgetsBinding.instance
        .addPostFrameCallback((_) async {
      _getThingsOnStartup().then((value) async {
        var list = await _u_dao.allUserEntries;
        //TODO uncomment for Ios app subscription checking

//            if (Platform.isIOS) {
//              //VALIDATE SUBSCRIPTION
//              await SplashScreen.subscriptionHelper.init().then((bool) async {
//                await SplashScreen.subscriptionHelper.validateReceipt(SplashScreen.subscriptionHelper.purchases.last).then((bool) async {
//                  if (!bool) {
//            list[0] =
//                list[0].copyWith(
//                    isSubscriptionBought: false);
//            await _u_dao.updateUser(list[0]);
//
//            Navigator.of(context)
//              ..pushAndRemoveUntil(MaterialPageRoute(
//                  builder: (BuildContext context) =>  UserSubscriptionScreen5(null)),
//                  ModalRoute.withName(UserSubscriptionScreen5.routName));
//            SplashScreen.subscriptionHelper.dismissAll();
//                  }
//                });
//              });
//            }

      });
    });

    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        isInfoDialogClose = true;
      });
    });

    var mapIndex = -1;
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text('Tap back again to leave application'),
        ),
        child: Stack(children: <Widget>[
          IndexedStack(
            index: tabIndex,
            children: allDestinations.map<Widget>((Destination destination) {
              return DestinationView(destination: destination);
            }).toList(),
          ),
          !isInfoDialogClose ? Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 54.0),
              child: Container(
                color: Color(0xFFFF6B4A),
                height: 125,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isInfoDialogClose = true;
                        });
                      },
                      child: Container(
                        height: 28,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.close, color:  Colors.white, size: 24,),
                          ),
                        ],),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                        child: Text(
                          'Disclaimer:  Fit and Ripped 24 will not be liable on any injuries or health issues the user might incur while using the app due to improper execution of workouts and exercises.',
                          style: TextStyleBuilder.textStyleBuilder(
                              12,
                              400,
                              TextStyleColors.white,
                              FontStyle.normal, context
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) : Container(),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              fixedColor: Color(0xFFFFFFFF),
              currentIndex: tabIndex,
              onTap: (int index) {
                setState(() {
                  tabIndex = index;
                  SettingScreen.settingScreenIndex = 0;
                });
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              iconSize: 20*UIScaler.getUiScaleFactor(context),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFFFFFFFF),
              selectedLabelStyle: TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.orange, FontStyle.normal, context),
              unselectedLabelStyle: TextStyleBuilder.textStyleBuilder(14, 500, TextStyleColors.black, FontStyle.normal, context),
              items: allDestinations.map((Destination destination) {
                mapIndex++;
                return BottomNavigationBarItem(
                    icon: mapIndex == tabIndex ? destination.imageSelected : destination.imageUnSelected,
                    backgroundColor: destination.color,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: Text(
                        destination.title,
                        style:
                        mapIndex == tabIndex ? TextStyleBuilder.textStyleBuilder(14, 400, TextStyleColors.orange, FontStyle.normal, context) : TextStyleBuilder.textStyleBuilder(14, 400, TextStyleColors.spaceGrey, FontStyle.normal, context)
                      ),
                    ));
              }).toList(),
            ),
          )
        ]),
      ),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }



}




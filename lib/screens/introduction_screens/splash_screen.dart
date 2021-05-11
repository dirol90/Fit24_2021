import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/helper/statefull_wrapper.dart';
import 'package:Fit24/screens/introduction_screens/video_splash_screen.dart';
import 'package:Fit24/screens/screeen_holder/screen_main_holder.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:Fit24/screens/introduction_screens/user_subscription_screen_5.dart';
import '../../subscription_helper.dart';

class SplashScreen extends StatelessWidget {
  static const String routName = '/';
  static SubscriptionHelper subscriptionHelper = SubscriptionHelper();

  List<Training> trainingsList;
  TrainingDao _t_dao;
  UserDao _u_dao;
  User user;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if (_u_dao == null || _t_dao == null) {
      _u_dao = Provider.of<UserDao>(context);
      _t_dao = Provider.of<TrainingDao>(context);
    }

    //SystemChrome.setEnabledSystemUIOverlays([]);

    Future onSelectNotification(String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      await Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new MainScreenHolder()),
      );
    }

    Future onDidReceiveLocalNotification(int id, String title, String body,
        String payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: new Text(title),
              content: new Text(body),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: new Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new MainScreenHolder(),
                      ),
                    );
                  },
                )
              ],
            ),
      );
    }

    WidgetsFlutterBinding.ensureInitialized();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.cancelAll();

    var initializationSettingsAndroid = AndroidInitializationSettings('icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _t_dao.watchAllTrainings().listen((data) async {
      final trainings = data ?? List();

      var thisMonday =
      DateTime.now().subtract(Duration(days: DateTime
          .now()
          .weekday - 1));
      var thisSunday = thisMonday.add(Duration(days: 6));

      trainingsList = List();

      for (int i = 0; i < trainings.length; i++) {
        if (trainings[i]
            .trainingDate
            .isAfter(thisMonday.subtract(Duration(days: 1))) &&
            trainings[i].trainingDate.isBefore(thisSunday)) {
          trainingsList.add(trainings[i]);
        }
      }
      trainings.sort((a, b) => a.trainingDate.compareTo(b.trainingDate));
      await flutterLocalNotificationsPlugin.cancelAll();

      for (int i = 0; i < trainings.length; i++) {
        if (trainings[i].isAlertEnable) {
          var time = new Time(
              trainings[i].trainingDate.hour,
              trainings[i].trainingDate.minute,
              trainings[i].trainingDate.second);
          var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
              'Fit and Ripped 24 notification channel',
              'Fit and Ripped 24',
              'Your training notifications channel');
          var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
          var platformChannelSpecifics = new NotificationDetails(
              androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

          flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
              i,
              'Fit and Ripped 24',
              'It\'s time to train!',
              trainings[i].trainingDate.weekday == 1
                  ? Day.Monday
                  : trainings[i].trainingDate.weekday == 2
                  ? Day.Tuesday
                  : trainings[i].trainingDate.weekday == 3
                  ? Day.Wednesday
                  : trainings[i].trainingDate.weekday == 4
                  ? Day.Thursday
                  : trainings[i].trainingDate.weekday == 5
                  ? Day.Friday
                  : trainings[i].trainingDate.weekday == 6
                  ? Day.Saturday
                  : Day.Sunday,
              time,
              platformChannelSpecifics);
        }
      }
    });

    return StreamBuilder<List<User>>(
        stream: _u_dao.watchAllUsers(),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          final users = snapshot.data;

          if (users != null && users.length > 0) {
            user = users[0];
          }

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            //TODO uncomment for Ios app subscription checking
//            if (Platform.isIOS) {
//              await subscriptionHelper.init();
//            }

            if (snapshot.data != null && user != null) {
              if (user.isSettingsFinished && user.isSubscriptionBought) {
                Navigator.of(context)
                    .pushReplacementNamed(MainScreenHolder.routName);
              } else
              if (user.isSettingsFinished && !user.isSubscriptionBought) {
                Navigator.of(context)
                    .pushReplacementNamed(UserSubscriptionScreen5.routName);
                      } else {
                      Navigator.of(context)
                          .pushReplacementNamed(VideoSplashScreen.routName);
                      }
                  } else
                      if (snapshot.data != null)
                {
                  Navigator.of(context)
                      .pushReplacementNamed(VideoSplashScreen.routName);
                }
              });

          return Scaffold(
            backgroundColor: Theme
                .of(context)
                .accentColor,
            body: Center(
              child: Container(
                  color: Theme
                      .of(context)
                      .accentColor,
                  child: Image.asset(
                    'assets/img/logo.png',
                    height: 190 * UIScaler.getUiScaleFactor(context),
                    width: 230 * UIScaler.getUiScaleFactor(context),
                  )),
            ),
          );
        });
  }
}

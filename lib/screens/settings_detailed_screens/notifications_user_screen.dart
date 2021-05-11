import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/data/moor_trainings_database.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationsUserSettingDetailedScreen extends StatefulWidget {
  static const String routName = '/NotificationsUserSettingDetailedScreen';
  final Function f;

  NotificationsUserSettingDetailedScreen({this.f});

  @override
  _NotificationsUserSettingDetailedScreenState createState() =>
      _NotificationsUserSettingDetailedScreenState();
}

class _NotificationsUserSettingDetailedScreenState
    extends State<NotificationsUserSettingDetailedScreen> {
  var isSelected = false;
  var selectedIndex = 0;

  List<Training> trainingsList;
  TrainingDao _t_dao;
  bool isColdBoot = true;


  @override
  Widget build(BuildContext context) {

    if (_t_dao == null  ) {
      _t_dao = Provider.of<TrainingDao>(context);
    }

    _t_dao.watchAllTrainings().listen((data) async {

//      await flutterLocalNotificationsPlugin.cancelAll();
//
//      for(int i = 0 ; i < trainings.length; i++){
//        var time = new Time(trainings[i].trainingDate.hour, trainings[i].trainingDate.minute, trainings[i].trainingDate.second);
//        var androidPlatformChannelSpecifics =
//        new AndroidNotificationDetails('FIT 24 notification channel',
//            'FIT 24', 'Your training notifications channel');
//        var iOSPlatformChannelSpecifics =
//        new IOSNotificationDetails();
//        var platformChannelSpecifics = new NotificationDetails(
//            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//
//        flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//            i,
//            'FIT 24',
//            'It\'s time to train!',
//            trainings[i].trainingDate.weekday == 1 ?  Day.Monday :
//            trainings[i].trainingDate.weekday == 2 ? Day.Tuesday :
//            trainings[i].trainingDate.weekday == 3 ? Day.Wednesday :
//            trainings[i].trainingDate.weekday == 4 ? Day.Thursday :
//            trainings[i].trainingDate.weekday == 5 ? Day.Friday :
//            trainings[i].trainingDate.weekday == 6 ? Day.Saturday :
//            Day.Sunday,
//            time,
//            platformChannelSpecifics);
//      }
//
      if (isColdBoot){
        isColdBoot = false;
        final trainings = data ?? List();

        var thisMonday =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
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


        setState(() {});
      }

    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 52*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, top: 0, right: 8, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          isSelected = !isSelected;
                          selectedIndex = 0;
                          setState(() {});
                        } else {

                          widget.f(0);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 5 * 3.3,
                      child: Center(
                        child: GestureDetector(
                            onTap: () {
                              if (isSelected) {
                                isSelected = !isSelected;
                                selectedIndex = 0;
                                setState(() {});
                              } else {
                                widget.f(0);
                              }
                            },
                            child: Text(
                              'Push Notifications',
                              style: TextStyleBuilder.textStyleBuilder(
                                16,
                                600,
                                TextStyleColors.black,
                                FontStyle.normal, context
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            !isSelected
                ? Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: generateTumblers(trainingsList).length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return generateTumblers(trainingsList)[index];
                        }))
                : Container(
                    height: 200,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: timeSelector()),
                  ),
          ],
        ),
      ),
    );
  }

  Widget timeSelector() {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      initialDateTime: trainingsList[selectedIndex].alertStartTime,
      onDateTimeChanged: (DateTime value) {
        trainingsList[selectedIndex] =
            trainingsList[selectedIndex].copyWith(alertStartTime: value);
        _t_dao.updateTraining(trainingsList[selectedIndex]).then((_) {});
      },
    );
  }

  List<Widget> generateTumblers(List<Training> trainingsList) {
    List<Widget> listWidgets = List();
    if (trainingsList != null) {
      for (int i = 0; i < trainingsList.length; i++) {
        listWidgets.add(
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  i == 0 ? Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 24.0, left: 0.0, right: 0.0),
                    child: Row(
                      crossAxisAlignment:  CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Enable reminders ',
                            style: TextStyleBuilder.textStyleBuilder(
                                20, 500, TextStyleColors.darkText, FontStyle.normal, context),
                          ),
                        ),
                        SizedBox(
                          width: 60*UIScaler.getUiScaleFactor(context),
                          height: 25*UIScaler.getUiScaleFactor(context),
                          child: CupertinoSwitch(
                            onChanged: (bool b) async {
                                for (int x = 0 ; x < trainingsList.length; x++){
                                  var tr = trainingsList[x].copyWith(
                                      isAlertEnable: b);
                                  trainingsList[x] = tr;
                                await _t_dao.updateTraining(trainingsList[x]);
                              }
                                setState(() {});
                            },
                            value: trainingsList[trainingsList.length-1].isAlertEnable,
                          ),
                        )
                      ],
                    ),
                  ) : Container(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          DateFormat("EEEE").format(trainingsList[i].trainingDate),
                          style: TextStyleBuilder.textStyleBuilder(
                              16, 500, TextStyleColors.darkText, FontStyle.normal, context),
                        ),
                        GestureDetector(
                            onTap: () {
                              selectedIndex = i;
                              isSelected = !isSelected;
                            },
                            child: Text(
                              DateFormat("hh a")
                                  .format(trainingsList[i].alertStartTime),
                              style: TextStyleBuilder.textStyleBuilder(16, 500,
                                  TextStyleColors.black, FontStyle.normal, context),
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10*UIScaler.getUiScaleFactor(context),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return listWidgets;
  }
}

import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/data/moor_trainings_database.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';

class CalendarUserSettingDetailedScreen extends StatefulWidget {
  static const String routName = '/CalendarUserSettingDetailedScreen';
  final Function f;

  CalendarUserSettingDetailedScreen(this.f);

  @override
  _CalendarUserSettingDetailedScreenState createState() =>
      _CalendarUserSettingDetailedScreenState();
}

class _CalendarUserSettingDetailedScreenState
    extends State<CalendarUserSettingDetailedScreen> {

  var monthCounter = 0;
  var date = DateTime.now();
  TrainingDao _t_dao;

  List<Training> trainingsList = List();
  @override
  Widget build(BuildContext context) {


    if (_t_dao == null ) {
      _t_dao = Provider.of<TrainingDao>(context);
    }

    if (trainingsList.length == 0) {
      _t_dao.allUserTrainings.then((val) {
        trainingsList = val;
        setState(() {});
      });
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 52*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 0, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        widget.f(0);
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
                              widget.f(0); /** SAVE IT!!! **/
                            },
                            child: Text(
                              'My trainings',
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
            Container(
              height: MediaQuery.of(context).size.height - (225*UIScaler.getUiScaleFactor(context)),
              width: 500*UIScaler.getUiScaleFactor(context),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      IgnorePointer(child: Container(child:calendar(DateTime(date.year, date.month + monthCounter, date.day)),)),
                      IgnorePointer(child: Container(child:calendar(DateTime(date.year, date.month + --monthCounter, date.day)),)),
                      IgnorePointer(child: Container(child:calendar(DateTime(date.year, date.month + --monthCounter, date.day)),)),
                      IgnorePointer(child: Container(child:calendar(DateTime(date.year, date.month + --monthCounter, date.day)),)),
                      IgnorePointer(child: Container(child:calendar(DateTime(date.year, date.month + --monthCounter, date.day)),)),
                      IgnorePointer(child: Container(child:calendar(DateTime(date.year, date.month + --monthCounter, date.day)),)),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 35,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset('assets/img/calendar_circle.png', height: 24, width: 24,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('Today', style: TextStyleBuilder.textStyleBuilder(
                              10,
                              400,
                              TextStyleColors.black,
                              FontStyle.normal, context
                          ),),
                        )
                      ],),
                    ),
                    Container(
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset('assets/img/calendar_circle_whited.png', height: 24, width: 24,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('Workout Planned', style: TextStyleBuilder.textStyleBuilder(
                              10,
                              400,
                              TextStyleColors.black,
                              FontStyle.normal, context
                          ),),
                        )
                      ],),
                    ),
                    Container(
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset('assets/img/calendar_circle_filled.png', height: 24, width: 24,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('Workout Completed', style: TextStyleBuilder.textStyleBuilder(
                              10,
                              400,
                              TextStyleColors.black,
                              FontStyle.normal, context
                          ),),
                        )
                      ],),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // guide https://pub.dev/packages/flutter_calendar_carousel

  Widget calendar(DateTime dt) {
    var _currentDate = dt;
    return Container(
      height: 360*UIScaler.getUiScaleFactor(context),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 42, left: 16, right: 16),
            child: Align(alignment: Alignment.topCenter, child: Divider(height: 4, color: Color(0xFFDADADA) , thickness: 2,),),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {
                this.setState(() => _currentDate = date);
              },
              isScrollable: false,
              showHeaderButton: false,
//              onHeaderRightButtonPressed : null,
//              onHeaderLeftButtonPressed : null,
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
              selectedDayBorderColor: _currentDate.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-1))  ? Theme.of(context).accentColor : Colors.white,
              todayBorderColor: Theme.of(context).accentColor,
              todayButtonColor: _currentDate.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-1))  ? Theme.of(context).accentColor : Colors.white,
              todayTextStyle:  TextStyleBuilder.textStyleBuilder(
                15,
                400,
                TextStyleColors.black,
                FontStyle.normal, context
              ),
              selectedDayButtonColor: _currentDate.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-1))  ? Theme.of(context).accentColor : Colors.white,
              selectedDayTextStyle: TextStyleBuilder.textStyleBuilder(
                15,
                400,
                _currentDate.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-1))  ? TextStyleColors.white : TextStyleColors.black,
                FontStyle.normal, context
              ),
              thisMonthDayBorderColor: Colors.transparent,
              showWeekDays: true,
              weekdayTextStyle: TextStyleBuilder.textStyleBuilder(
                13,
                500,
                TextStyleColors.grey,
                FontStyle.normal, context
              ),
              headerTextStyle: TextStyleBuilder.textStyleBuilder(
                16,
                600,
                TextStyleColors.violet,
                FontStyle.normal, context
              ),
              daysTextStyle: TextStyleBuilder.textStyleBuilder(
                15,
                400,
                TextStyleColors.black,
                FontStyle.normal, context
              ),
              nextDaysTextStyle: TextStyleBuilder.textStyleBuilder(
                15,
                300,
                TextStyleColors.grey,
                FontStyle.normal, context
              ),
              prevDaysTextStyle: TextStyleBuilder.textStyleBuilder(
                15,
                300,
                TextStyleColors.grey,
                FontStyle.normal, context
              ),
              leftButtonIcon: null,
              rightButtonIcon: null,
              iconColor: Colors.white,
              showIconBehindDayText: true,

              customDayBuilder: (
                  bool isSelectable,
                  int index,
                  bool isSelectedDay,
                  bool isToday,
                  bool isPrevMonthDay,
                  TextStyle textStyle,
                  bool isNextMonthDay,
                  bool isThisMonthDay,
                  DateTime day,
                  ) {

                for (int i = 0 ; i < trainingsList.length; i++){
                  if (isThisMonthDay && trainingsList[i].trainingDate.day == day.day && trainingsList[i].trainingDate.month == day.month && trainingsList[i].trainingDate.year == day.year){
                    if (trainingsList[i].isDone){
                      return Center(
                          child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Image.asset('assets/img/calendar_circle_filled.png', height: 36, width: 36,),
                                Text('${day.day}', style: TextStyleBuilder.textStyleBuilder(
                                  15,
                                  400,
                                  TextStyleColors.white,
                                  FontStyle.normal, context
                                ),),
                              ])
                      );
                    } else {
                      return Center(
                          child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Image.asset('assets/img/calendar_circle_whited.png', height: 36, width: 36,),
                                Text('${day.day}', style: TextStyleBuilder.textStyleBuilder(
                                  15,
                                  400,
                                  TextStyleColors.black,
                                  FontStyle.normal, context
                                ),),
                              ])
                      );
                    }
                  }
                }

                if (day.day == 15) {
                  return null;
//                  );
                } else {
                  return null;
                }
              },
              weekFormat: false,
              height: 420.0*UIScaler.getUiScaleFactor(context),
              selectedDateTime: _currentDate,
              daysHaveCircularBorder: true,
            ),
          )
        ],
      ),
    );
  }
}

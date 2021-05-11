import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/screens/screeen_holder/screen_main_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/chart_widget/my_animated_line_chart.dart';
import 'package:Fit24/widget/chart_widget/my_line_chart.dart';
import 'package:Fit24/widget/my_cupertino_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ExerciseDoneScreen extends StatefulWidget {
  static const String routName = '/ExerciseDoneScreen';

  Training training;
  int setsDone = 0;
  int totalSetsForDone = 0;
  int kkalSpent = 0;
  int timeSpent = 0;


  ExerciseDoneScreen({this.training, this.setsDone, this.totalSetsForDone, this.kkalSpent, this.timeSpent});

  @override
  _ExerciseDoneScreenState createState() => _ExerciseDoneScreenState();
}

class _ExerciseDoneScreenState extends State<ExerciseDoneScreen> {
  final myController = TextEditingController();


  @override
  void initState() {
    myController.addListener(_printLatestValue);

    super.initState();
  }

  _printLatestValue() {

  }

  List<Map<DateTime, double>> series = List();
  Map<DateTime, double> line = Map();
  List<Training> trainingsList = List();
  MyLineChart lineChart;

  User user;

  var weightListItems = new List();
  var currentIserWeight = 0.0;

  TrainingDao _t_dao;
  UserDao _u_dao;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //SystemChrome.setEnabledSystemUIOverlays([]);

    if (_u_dao == null || _t_dao == null  ) {
      _u_dao = Provider.of<UserDao>(context);
      _t_dao = Provider.of<TrainingDao>(context);

    }

    for (double x = 30.0; x < 300.0; x++) {
      weightListItems.add(x);
    }

    return StreamBuilder(
    stream: _u_dao.watchAllUsers(),
      builder: (context, AsyncSnapshot<List<User>> snapshot) {

    final users = snapshot.data ?? List();
    user = users.length > 0 ? users[0] : null;
    if (user != null ) {

      currentIserWeight = weightListItems[double.parse(user.weightIndex).toInt()];

    _t_dao.allUserTrainings.then((val) {
      if (val.length > 0 ) {
        trainingsList = val;

        trainingsList.sort((a, b) => a.trainingDate.compareTo(b.trainingDate));

        var lastWeightVal = 0.0;
        for (int i = 0; i < trainingsList.length; i++) {
          if (double.parse(trainingsList[i].userWeightAfterTraining) != 0.0){
            lastWeightVal = double.parse(trainingsList[i].userWeightAfterTraining);
          }
        }

        for (int i = 0; i < trainingsList.length; i++) {
          if (double.parse(trainingsList[i].userWeightAfterTraining) == 0.0){
            line[trainingsList[i].trainingDate] = lastWeightVal == 0.0 ?
            currentIserWeight : lastWeightVal;
          } else {
            line[trainingsList[i].trainingDate] =
                double.parse(trainingsList[i].userWeightAfterTraining);
          }
          if (trainingsList.length > i + 1) {
            if (trainingsList[i+1].trainingDate.millisecondsSinceEpoch - trainingsList[i].trainingDate.millisecondsSinceEpoch  != 86400000) {
              if (double.parse(trainingsList[i].userWeightAfterTraining) == 0.0) {
                line[DateTime.fromMillisecondsSinceEpoch(trainingsList[i].trainingDate.millisecondsSinceEpoch+(86400000))] = lastWeightVal == 0.0 ?
                currentIserWeight : lastWeightVal;
              } else {
                line[DateTime.fromMillisecondsSinceEpoch(trainingsList[i].trainingDate.millisecondsSinceEpoch+(86400000))] =
                    double.parse(trainingsList[i].userWeightAfterTraining);
              }
            }
          }
        }

        var addeDaysCounter = 0;

        if (7-trainingsList.length > 0) {
          for (int i = 0; i < 7 - trainingsList.length; i++) {
            if (double.parse(trainingsList[trainingsList.length-1].userWeightAfterTraining) == 0.0){
              line[DateTime.fromMillisecondsSinceEpoch(trainingsList[trainingsList.length-1].trainingDate.millisecondsSinceEpoch+(86400000*(addeDaysCounter+1)))] = currentIserWeight;
            }
            else {
              line[DateTime.fromMillisecondsSinceEpoch(trainingsList[trainingsList.length-1].trainingDate.millisecondsSinceEpoch+(86400000*(addeDaysCounter+1)))] = double.parse(trainingsList[trainingsList.length-1].userWeightAfterTraining);
            }
            addeDaysCounter++;
          }
        }

        line.forEach((e, v){
          var dateTime = DateTime(e.year, e.month, e.day);
          var today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
          if (dateTime.millisecondsSinceEpoch == today.millisecondsSinceEpoch){
            line[e] = user!= null ? weightListItems[double.parse(user.weightIndex).toInt()] : 0.0;
          }
        });

        series.add(line);
        lineChart = MyLineChart.fromDateTimeMaps(
            series.reversed.toList(), [Colors.orange], ['']);

        setState(() {});
      }
    }
    );
    }

    return user != null ? Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 52*UIScaler.getUiScaleFactor(context)),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text('Workout done', style: TextStyleBuilder.textStyleBuilder(36, 600, TextStyleColors.darkBlack, FontStyle.normal, context),)],),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F8),
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.0)),
                            ),
                            height: 122*UIScaler.getUiScaleFactor(context),
                            width: (MediaQuery.of(context).size.width / 3 - 8)*UIScaler.getUiScaleFactor(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0, left: 12),
                                  child: Text(
                                    'Exercises Completed',
                                    style: TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.orange, FontStyle.normal, context),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text('${widget.setsDone} / ${widget.totalSetsForDone}', style: TextStyleBuilder.textStyleBuilder(16, 600, TextStyleColors.black, FontStyle.normal, context),),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 11.0, right: 11.0),
                                      child: Container(
                                          height: 20*UIScaler.getUiScaleFactor(context),
                                          child: Image.asset(
                                            'assets/img/exercise_img.png',
                                            height: 24*UIScaler.getUiScaleFactor(context),
                                            width: 24*UIScaler.getUiScaleFactor(context),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F8),
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.0)),
                            ),
                            height: 122*UIScaler.getUiScaleFactor(context),
                            width: (MediaQuery.of(context).size.width / 3 - 8)*UIScaler.getUiScaleFactor(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0, left: 12),
                                  child: Text(
                                    'Calories',
                                    style: TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.orange, FontStyle.normal, context),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text('${widget.kkalSpent}', style: TextStyleBuilder.textStyleBuilder(16, 600, TextStyleColors.black, FontStyle.normal, context),),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 11.0, right: 11.0),
                                      child: Container(
                                          height: 20*UIScaler.getUiScaleFactor(context),
                                          child: Image.asset(
                                            'assets/img/callories_img.png',
                                            height: 22*UIScaler.getUiScaleFactor(context),
                                            width: 19*UIScaler.getUiScaleFactor(context),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F6F8),
                              borderRadius:
                              BorderRadius.all(Radius.circular(4.0)),
                            ),
                            height: 122*UIScaler.getUiScaleFactor(context),
                            width: (MediaQuery.of(context).size.width / 3 - 8)*UIScaler.getUiScaleFactor(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18.0, left: 12),
                                  child: Text(
                                    'Minutes',
                                    style: TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.orange, FontStyle.normal, context),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text('${widget.timeSpent/1000~/60}', style: TextStyleBuilder.textStyleBuilder(16, 600, TextStyleColors.black, FontStyle.normal, context),),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 11.0, right: 11.0),
                                      child: Container(
                                          height: 20*UIScaler.getUiScaleFactor(context),
                                          child: Image.asset(
                                            'assets/img/clock_img.png',
                                            height: 25*UIScaler.getUiScaleFactor(context),
                                            width: 24*UIScaler.getUiScaleFactor(context),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16.0),

                    child: Container(
                      height: 100*UIScaler.getUiScaleFactor(context),
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 0, bottom: 10),
                                child: Text(
                                  'Input your current weight (optional):',
                                  style: TextStyleBuilder.textStyleBuilder(18, 600, TextStyleColors.black, FontStyle.normal, context),
                                ),
                              ),


                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 32,
                                child: MyCupertinoTextField(
                                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                  placeholder: "Your current weight",
                                  expands: true,
                                  maxLines: null,
                                  minLines: null,
                                  padding: const EdgeInsets.all(16.0),
                                  style: TextStyle(color: Colors.orange),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6F6F8),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0*UIScaler.getUiScaleFactor(context))),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  controller: myController,
                                ),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      height: 300*UIScaler.getUiScaleFactor(context),
                      width: 300*UIScaler.getUiScaleFactor(context),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            lineChart != null ? Expanded(child: MyAnimatedLineChart(lineChart)) : Container(),
                          ]),
                    ),
                  ),
                  Container(
                    height: 40*UIScaler.getUiScaleFactor(context),
                    width: 250*UIScaler.getUiScaleFactor(context),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0*UIScaler.getUiScaleFactor(context)),
                          side: BorderSide(color: Theme.of(context).buttonColor)),
                      child: Text(
                        'DONE'.toUpperCase(),
                        style: TextStyleBuilder.textStyleBuilder(15, 500, TextStyleColors.white, FontStyle.normal, context),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {

                        var weight = myController.text;
                        weight = weight.replaceAll(',', '.');
                        if (_isNumeric(weight)){widget.training = widget.training.copyWith(userWeightAfterTraining: weight);}
                        widget.training = widget.training.copyWith(isDone: true);



                        if (_isNumeric(weight)){
                          var currentIndex = 0;
                          for (int x = 30; x < 300; x++) {
                            if (double.parse(weight).toInt() > x - 1 && double.parse(weight).toInt() < x + 1){currentIndex = x - 30;}
                          }
                          user = user.copyWith(weightIndex: currentIndex.toString());
                        }

                        user = user.copyWith(trainingsDone: user.trainingsDone +1);
                        user = user.copyWith(trainingSpendCalories : user.trainingSpendCalories + widget.kkalSpent );
                        user = user.copyWith(trainingSpendTime: (double.parse(user.trainingSpendTime) + widget.timeSpent).toString());

                        _u_dao.updateUser(user).then((d){_u_dao.calculateUserParams(user).then((v){
                          _t_dao.updateTraining(widget.training).then((c){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainScreenHolder()), ModalRoute.withName(MainScreenHolder.routName));
                          });
                          });
                        });
                      },
                      color: Theme.of(context).buttonColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ): Container();},
    );
  }

  bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}

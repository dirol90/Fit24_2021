import 'package:Fit24/screens/app_screens/exercises_list.dart';
import 'package:Fit24/screens/app_screens/plan_exercise_screen.dart';
import 'package:Fit24/screens/app_screens/plan_exercises_screen_test.dart';
import 'package:Fit24/screens/app_screens/settings_screen.dart';
import 'package:Fit24/screens/app_screens/workout_list.dart';
import 'package:flutter/material.dart';
import 'destinations.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.destination.path == PlanScreen.routName) {
      return PlanScreen();
    } else if (widget.destination.path == ExercisesListScreen.routName) {
      return ExercisesListScreen();
    } else if (widget.destination.path == SettingScreen.routName) {
      return SettingScreen();
    } else if (widget.destination.path == WorkoutListScreen.routName){
      return WorkoutListScreen();
    } else {
      return PlanScreen();
    }
  }
}

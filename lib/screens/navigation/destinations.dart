import 'package:Fit24/screens/app_screens/exercises_list.dart';
import 'package:Fit24/screens/app_screens/plan_exercise_screen.dart';
import 'package:Fit24/screens/app_screens/plan_exercises_screen_test.dart';
import 'package:Fit24/screens/app_screens/settings_screen.dart';
import 'package:Fit24/screens/app_screens/workout_list.dart';
import 'package:Fit24/screens/settings_detailed_screens/about_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Destination {
  const Destination(this.title, this.imageSelected, this.imageUnSelected, this.color, this.path);

  final String title;
  final Image imageSelected;
  final Image imageUnSelected;
  final Color color;
  final String path;
}

List<Destination> allDestinations = <Destination>[
  Destination('Plan', Image.asset('assets/img/plan_pressed_icon.png', height: 20, width: 20,), Image.asset('assets/img/plan_unpressed_icon.png', height: 20, width: 20,), Color(0xFFC1C1CB), PlanScreen.routName),
  Destination('Workouts', Image.asset('assets/img/workouts_pressed_icon.png', height: 20, width: 20,), Image.asset('assets/img/workouts_unpressed_icon.png', height: 20, width: 20,), Color(0xFFC1C1CB), WorkoutListScreen.routName),
  Destination('Exercises', Image.asset('assets/img/exercises_pressed_icon.png', height: 20, width: 20,),Image.asset('assets/img/exercises_unpressed_icon.png', height: 20, width: 20,), Color(0xFFC1C1CB), ExercisesListScreen.routName),
  Destination('Profile', Image.asset('assets/img/profile_pressed_icon.png', height: 20, width: 20,),Image.asset('assets/img/profile_unpressed_icon.png', height: 20, width: 20,), Color(0xFFC1C1CB), SettingScreen.routName),

];
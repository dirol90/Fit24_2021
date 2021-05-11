import 'package:Fit24/screens/settings_detailed_screens/about_user_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/about_user_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/calendar_trainings_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/calendar_trainings_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/healthy_tips_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/main_settings_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/notifications_user_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/plan_user_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/subscriprion_text_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingScreen extends StatefulWidget {
  static const String routName = '/SettingScreen';
  static int settingScreenIndex = 0;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  Function changeScreen(int index){
    setState(() {
      SettingScreen.settingScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffFF6B4A), // screens.navigation bar color
      statusBarColor: Color(0xffFF6B4A), // status bar color
    ));


    return SettingScreen.settingScreenIndex == 0 ?  MainSettingsScreen(changeScreen, false)
        : SettingScreen.settingScreenIndex == 1 ? AboutUserSettingDetailedScreen(f: changeScreen)
        : SettingScreen.settingScreenIndex == 2 ? PlanUserSettingDetailedScreen(f: changeScreen)
        : SettingScreen.settingScreenIndex == 3 ? NotificationsUserSettingDetailedScreen(f: changeScreen)
        : SettingScreen.settingScreenIndex == 4 ? MainSettingsScreen(changeScreen, true)
        : SettingScreen.settingScreenIndex == 5 ? SubscriptionTextScreen(changeScreen)
        : SettingScreen.settingScreenIndex == 6 ? CalendarUserSettingDetailedScreen(changeScreen)
        : SettingScreen.settingScreenIndex == 7 ? HealthyTipsUserSettingsDetailedScreen(changeScreen)
        : PlanUserSettingDetailedScreen(f: changeScreen);
  }

}

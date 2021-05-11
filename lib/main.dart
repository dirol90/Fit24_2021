import 'package:Fit24/screens/app_screens/exercise_detailed_screen.dart';
import 'package:Fit24/screens/app_screens/exercise_done.dart';
import 'package:Fit24/screens/app_screens/exercise_time_line.dart';
import 'package:Fit24/screens/app_screens/exercises_list.dart';
import 'package:Fit24/screens/app_screens/plan_exercise_screen.dart';
import 'package:Fit24/screens/app_screens/plan_exercises_screen_test.dart';
import 'package:Fit24/screens/app_screens/settings_screen.dart';
import 'package:Fit24/screens/app_screens/excersise_screen.dart';
import 'package:Fit24/screens/app_screens/workout_list.dart';
import 'package:Fit24/screens/introduction_screens/extra_info_screen.dart';
import 'package:Fit24/screens/introduction_screens/user_questionnaire_0_screeen.dart';
import 'package:Fit24/screens/introduction_screens/user_questionnaire_1_screeen.dart';
import 'package:Fit24/screens/introduction_screens/user_questionnaire_2_screeen.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/screens/introduction_screens/user_subscription_screen_5.dart';
import 'package:Fit24/screens/introduction_screens/user_total_info_4_screen.dart';
import 'package:Fit24/screens/introduction_screens/video_splash_screen.dart';
import 'package:Fit24/screens/introduction_screens/splash_screen.dart';
import 'package:Fit24/screens/introduction_screens/user_video_questionnaire_3.dart';
import 'package:Fit24/screens/screeen_holder/screen_main_holder.dart';
import 'package:Fit24/screens/settings_detailed_screens/about_user_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/notifications_user_screen.dart';
import 'package:Fit24/screens/settings_detailed_screens/plan_user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dao/app_dao.dart';
import 'data/moor_trainings_database.dart';
import 'l10n/messages_all.dart';

// /Users/mac_pc/Documents/flutter/bin/flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/main.dart
// /Users/mac_pc/Documents/flutter/bin/flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/main.dart lib/l10n/intl_*.arb

class DemoLocalizations {
  DemoLocalizations(this.localeName);

  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return DemoLocalizations(localeName);
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  final String localeName;

  String get name {return Intl.message('Name', name: 'name', locale: localeName,);}
  String get setName {return Intl.message('Enter your name', name: 'setName', locale: localeName,);}
  String get woman {return Intl.message('Female', name: 'woman', locale: localeName,);}
  String get man {return Intl.message('Male', name: 'man', locale: localeName,);}
  String get bd {return Intl.message('Date of birth', name: 'bd', locale: localeName,);}
  String get weight {return Intl.message('Weight', name: 'weight', locale: localeName,);}
  String get height {return Intl.message('Height', name: 'height', locale: localeName,);}
  String get kg {return Intl.message('kg', name: 'kg', locale: localeName,);}
  String get lb {return Intl.message('lb', name: 'lb', locale: localeName,);}
  String get cm {return Intl.message('cm', name: 'cm', locale: localeName,);}
  String get inc {return Intl.message('in', name: 'in', locale: localeName,);}
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) => DemoLocalizations.load(locale);

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffFF6B4A), // screens.navigation bar color
    statusBarColor: Color(0xffFF6B4A), // status bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<UserDao>(create: (_) => MyDatabase().userDao,),
        Provider<TrainingDao>(create: (_) => MyDatabase().trainingDao,),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          const DemoLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'EN'),
          const Locale('ru', 'RU'),
        ],

        debugShowCheckedModeBanner: false,
        title: 'Fit and Ripped 24',

        theme: myTheme(),
        routes: {
          SplashScreen.routName : (context) => SplashScreen(),
          VideoSplashScreen.routName : (context) => VideoSplashScreen(),
          UserQuestionnaireScreen0.routName : (context) => UserQuestionnaireScreen0(),
          UserQuestionnaireScreen1.routName : (context) => UserQuestionnaireScreen1(),
          UserQuestionnaireScreen2.routName : (context) => UserQuestionnaireScreen2(),
          UserQuestionnaireScreen3.routName : (context) => UserQuestionnaireScreen3(),
          UserQuestionnaireScreen4.routName : (context) => UserQuestionnaireScreen4(),
          ExtraInfoScreen.routName : (context) => ExtraInfoScreen(),
          UserRegistrationController.routName : (context) => UserRegistrationController(),
          TrainingStartScreen.routName : (context) => TrainingStartScreen(),
          PlanScreen.routName : (context) => PlanScreen(),
          ExerciseDetailed.routName : (context) => ExerciseDetailed(),
          WorkoutListScreen.routName : (context) => WorkoutListScreen(),
          ExerciseTimeLineScreen.routName : (context) => ExerciseTimeLineScreen(),
          ExercisesListScreen.routName : (context) => ExercisesListScreen(),
          SettingScreen.routName : (context) => SettingScreen(),
          AboutUserSettingDetailedScreen.routName : (context) => AboutUserSettingDetailedScreen(),
          PlanUserSettingDetailedScreen.routName : (context) => PlanUserSettingDetailedScreen(),
          NotificationsUserSettingDetailedScreen.routName : (context) => NotificationsUserSettingDetailedScreen(),
          MainScreenHolder.routName : (context) => MainScreenHolder(),
          UserSubscriptionScreen5.routName : (context) => UserSubscriptionScreen5(),
          ExerciseDoneScreen.routName : (context) => ExerciseDoneScreen(),
        },
        initialRoute: SplashScreen.routName,
      ),
    );
  }

  ThemeData myTheme() {
    return ThemeData(
        primaryColor: Color(0xffFFFFFF),
        accentColor: Color(0xffFF6B4A),
        cardColor: Colors.grey[100],
        cursorColor: Colors.grey[800],
        scaffoldBackgroundColor: Color(0xffFFFFFF),
        backgroundColor: Color(0xffFFFFFF),
        buttonColor: Color(0xffFF6B4A),
        dialogBackgroundColor: Colors.grey[300],
        disabledColor: Colors.grey[600],
        errorColor: Colors.red[300],
        hintColor: Colors.white,
        dividerColor: Color(0xffC4C4C4),
        unselectedWidgetColor: Color(0xffFF6B4A),
        highlightColor: Color(0x80FF6B4A),
//            disabled:Color(0xff03A9F4),

        appBarTheme: AppBarTheme(color: Colors.transparent),

        fontFamily: 'Roboto',

        textTheme: TextTheme(
          title: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Rubik-Black',
              color: Color(0xff000000)),
          subhead: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Rubik-Black',
              color: Color(0xffFF6B4A)),
          body1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Rubik-Black',
              color: Color(0xff000000)),
          body2: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Rubik-Black',
              color: Color(0xff999999)),
          button: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.normal, color: Color(0xffFFFFFF)),
          overline: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Rubik-Black',
              color: Color(0xff000000)),
          subtitle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Rubik-Black',
              color: Color(0xFFFFFFFF)),
        ));
  }
}


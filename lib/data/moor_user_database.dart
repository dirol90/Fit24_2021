import 'package:moor_flutter/moor_flutter.dart';

class Users extends Table {

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withDefault(Constant(''))();

  IntColumn get sexIndex => integer().withDefault(Constant(0))();

  DateTimeColumn get bd => dateTime().nullable()();

  TextColumn get weightIndex => text().withDefault(Constant('0.0'))();

  IntColumn get weightMeasure => integer().withDefault(Constant(0))();

  TextColumn get heightIndex => text().withDefault(Constant('0.0'))();

  IntColumn get heightMeasure => integer().withDefault(Constant(0))();

  IntColumn get fitnessStyleIndex => integer().withDefault(Constant(0))();

  IntColumn get workOutCount => integer().withDefault(Constant(0))();

  TextColumn get metabolicRate => text().withDefault(Constant('0.0'))();

  TextColumn get caloriesNeed => text().withDefault(Constant('0.0'))();

  TextColumn get bodyMassIndex => text().withDefault(Constant('0.0'))();

  IntColumn get healsStatus => integer().withDefault(Constant(0))();

  TextColumn get trainingSpendTime => text().withDefault(Constant('0.0'))();

  IntColumn get trainingSpendCalories => integer().withDefault(Constant(0))();

  IntColumn get trainingsDone => integer().withDefault(Constant(0))();

  TextColumn get userWeightChanges => text().nullable()();

  TextColumn get userQuestion1 => text().withDefault(Constant('0.0'))();
  TextColumn get userQuestion2 => text().withDefault(Constant('0.0'))();
  TextColumn get userQuestion3 => text().withDefault(Constant('0.0'))();

  TextColumn get trainingTimesPerWeek => text().withDefault(Constant('2.0'))();

  BoolColumn get isSettingsFinished => boolean().withDefault(Constant(false))();

  BoolColumn get isSubscriptionBought => boolean().withDefault(Constant(false))();

}

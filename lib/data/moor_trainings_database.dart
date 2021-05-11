import 'package:Fit24/dao/app_dao.dart';
import 'package:moor_flutter/moor_flutter.dart';

class Trainings extends Table {

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withDefault(Constant(''))();

  DateTimeColumn get trainingDate => dateTime().nullable()();

  IntColumn get exercisesGroupId => integer().withDefault(Constant(-1))();

  BoolColumn get isDone => boolean().withDefault(Constant(false))();

  BoolColumn get isAlertEnable => boolean().withDefault(Constant(false))();

  DateTimeColumn get alertStartTime => dateTime().nullable()();

  IntColumn get extraExerciseExitIndex => integer().withDefault(Constant(2))();

  TextColumn get userWeightAfterTraining => text().withDefault(Constant('0.0'))();

  TextColumn get imagePath => text().withDefault(Constant(''))();

}

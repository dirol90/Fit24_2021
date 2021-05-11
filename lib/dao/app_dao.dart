import 'dart:io';

import 'package:Fit24/data/moor_trainings_database.dart';
import 'package:Fit24/data/moor_user_database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_dao.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db1.sqlite'));
    return VmDatabase(file);
  });
}


@UseMoor(tables: [Trainings, Users], daos: [TrainingDao, UserDao])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

@UseDao(tables: [Trainings])
class TrainingDao extends DatabaseAccessor<MyDatabase> with _$TrainingDaoMixin {
  TrainingDao(MyDatabase db) : super(db);

  Future<List<Training>> get allUserTrainings => select(trainings).get();

  Stream<List<Training>> watchAllTrainings() => select(trainings).watch();

  Stream<List<Training>> watchAllTrainingsTest() {
    return (select(trainings)
      ..orderBy(
        ([
              (t) =>
              OrderingTerm(expression: t.id, mode: OrderingMode.asc),

        ]),
      ))
        .watch();
  }

//  Stream<List<Training>> watchAllTrainingsWhere() => select(trainings).where(filter).watch();
  
  Future insertTraining(Training training) => into(trainings).insert(training);

  Future insertTrainings(List <Training> training) async {
    for (int i = 0; i < training.length; i++){
      await into(trainings).insert(training[i]);
    }
  }

  Future updateTraining(Training training) => update(trainings).replace(training);

  Future deleteTraining(Training training) => delete(trainings).delete(training);

}

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<MyDatabase> with _$UserDaoMixin {
  UserDao(MyDatabase db) : super(db);

  Future<List<User>> get allUserEntries => select(users).get();

  Stream<List<User>> watchAllUsers() => select(users).watch();

  Future insertUser(User user) => into(users).insert(user);

  Future updateUser(User user) => update(users).replace(user);

  Future deleteUser(User user) => delete(users).delete(user);



  List weightList;
  List _heightList;

  Future calculateUserParams(User user) {
    weightList = List();
    _heightList = List();

    for (int x = 30; x < 300; x++) {
      weightList.add(x);
    }

    for (int x = 120; x < 260; x++) {
      _heightList.add(x);
    }
    if (user != null) {
      user = user.copyWith(
          metabolicRate: _calculateMetabolicRate(user).toString());
      user =
          user.copyWith(caloriesNeed: _calculatecaloriesNeed(user).toString());
      user = user.copyWith(
          bodyMassIndex: _calculateBodyMassIndex(user).toString());
      return updateUser(user);
    }
    return updateUser(user);
  }

  double _calculateMetabolicRate(User user) {
    if (user.sexIndex == 0) {
      return (10 * weightList[double.parse(user.weightIndex).toInt()]) +
          (6.25 * _heightList[double.parse(user.heightIndex).toInt()]) -
          (5 * _calculateAge(user.bd)) - 161;
    } else {
      return (10 * weightList[double.parse(user.weightIndex).toInt()]) +
          (6.25 * _heightList[double.parse(user.heightIndex).toInt()]) -
          (5 * _calculateAge(user.bd)) + 5;
    }
  }

  double _calculatecaloriesNeed(User user) {
    var hardnessIndicator = (user.fitnessStyleIndex + 1) *
        (user.workOutCount + 1);

    if (hardnessIndicator > 0 && hardnessIndicator < 3) {
      return double.parse(user.metabolicRate) * 1.2;
    }
    else if (hardnessIndicator > 2 && hardnessIndicator < 9) {
      return double.parse(user.metabolicRate) * 1.375;
    }
    else if (hardnessIndicator > 8 && hardnessIndicator < 12) {
      return double.parse(user.metabolicRate) * 1.55;
    }
    else if (hardnessIndicator > 11 && hardnessIndicator < 14) {
      return double.parse(user.metabolicRate) * 1.725;
    }
    else if (hardnessIndicator > 13) {
      return double.parse(user.metabolicRate) * 1.9;
    }
    return 0.0;
  }

  double _calculateBodyMassIndex(User user) {
//    print('USER 1 ${weightList[double.parse(user.weightIndex).toInt()]}');
//    print('USER 2 ${_heightList[double.parse(user.heightIndex).toInt()]}');
//    print('USER 3 ${((_heightList[double.parse(user.heightIndex).toInt()] / 100) *
//        (_heightList[double.parse(user.heightIndex).toInt()] / 100))}');

    return weightList[double.parse(user.weightIndex).toInt()] /
        ((_heightList[double.parse(user.heightIndex).toInt()] / 100) *
            (_heightList[double.parse(user.heightIndex).toInt()] / 100));
  }

  int _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }


}


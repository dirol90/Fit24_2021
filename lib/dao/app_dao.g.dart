// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_dao.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Training extends DataClass implements Insertable<Training> {
  final int id;
  final String name;
  final DateTime trainingDate;
  final int exercisesGroupId;
  final bool isDone;
  final bool isAlertEnable;
  final DateTime alertStartTime;
  final int extraExerciseExitIndex;
  final String userWeightAfterTraining;
  final String imagePath;
  Training(
      {@required this.id,
      @required this.name,
      this.trainingDate,
      @required this.exercisesGroupId,
      @required this.isDone,
      @required this.isAlertEnable,
      this.alertStartTime,
      @required this.extraExerciseExitIndex,
      @required this.userWeightAfterTraining,
      @required this.imagePath});
  factory Training.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Training(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      trainingDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}training_date']),
      exercisesGroupId: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}exercises_group_id']),
      isDone:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_done']),
      isAlertEnable: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_alert_enable']),
      alertStartTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}alert_start_time']),
      extraExerciseExitIndex: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}extra_exercise_exit_index']),
      userWeightAfterTraining: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}user_weight_after_training']),
      imagePath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || trainingDate != null) {
      map['training_date'] = Variable<DateTime>(trainingDate);
    }
    if (!nullToAbsent || exercisesGroupId != null) {
      map['exercises_group_id'] = Variable<int>(exercisesGroupId);
    }
    if (!nullToAbsent || isDone != null) {
      map['is_done'] = Variable<bool>(isDone);
    }
    if (!nullToAbsent || isAlertEnable != null) {
      map['is_alert_enable'] = Variable<bool>(isAlertEnable);
    }
    if (!nullToAbsent || alertStartTime != null) {
      map['alert_start_time'] = Variable<DateTime>(alertStartTime);
    }
    if (!nullToAbsent || extraExerciseExitIndex != null) {
      map['extra_exercise_exit_index'] = Variable<int>(extraExerciseExitIndex);
    }
    if (!nullToAbsent || userWeightAfterTraining != null) {
      map['user_weight_after_training'] =
          Variable<String>(userWeightAfterTraining);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    return map;
  }

  TrainingsCompanion toCompanion(bool nullToAbsent) {
    return TrainingsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      trainingDate: trainingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(trainingDate),
      exercisesGroupId: exercisesGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(exercisesGroupId),
      isDone:
          isDone == null && nullToAbsent ? const Value.absent() : Value(isDone),
      isAlertEnable: isAlertEnable == null && nullToAbsent
          ? const Value.absent()
          : Value(isAlertEnable),
      alertStartTime: alertStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(alertStartTime),
      extraExerciseExitIndex: extraExerciseExitIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(extraExerciseExitIndex),
      userWeightAfterTraining: userWeightAfterTraining == null && nullToAbsent
          ? const Value.absent()
          : Value(userWeightAfterTraining),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
    );
  }

  factory Training.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Training(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      trainingDate: serializer.fromJson<DateTime>(json['trainingDate']),
      exercisesGroupId: serializer.fromJson<int>(json['exercisesGroupId']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      isAlertEnable: serializer.fromJson<bool>(json['isAlertEnable']),
      alertStartTime: serializer.fromJson<DateTime>(json['alertStartTime']),
      extraExerciseExitIndex:
          serializer.fromJson<int>(json['extraExerciseExitIndex']),
      userWeightAfterTraining:
          serializer.fromJson<String>(json['userWeightAfterTraining']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'trainingDate': serializer.toJson<DateTime>(trainingDate),
      'exercisesGroupId': serializer.toJson<int>(exercisesGroupId),
      'isDone': serializer.toJson<bool>(isDone),
      'isAlertEnable': serializer.toJson<bool>(isAlertEnable),
      'alertStartTime': serializer.toJson<DateTime>(alertStartTime),
      'extraExerciseExitIndex': serializer.toJson<int>(extraExerciseExitIndex),
      'userWeightAfterTraining':
          serializer.toJson<String>(userWeightAfterTraining),
      'imagePath': serializer.toJson<String>(imagePath),
    };
  }

  Training copyWith(
          {int id,
          String name,
          DateTime trainingDate,
          int exercisesGroupId,
          bool isDone,
          bool isAlertEnable,
          DateTime alertStartTime,
          int extraExerciseExitIndex,
          String userWeightAfterTraining,
          String imagePath}) =>
      Training(
        id: id ?? this.id,
        name: name ?? this.name,
        trainingDate: trainingDate ?? this.trainingDate,
        exercisesGroupId: exercisesGroupId ?? this.exercisesGroupId,
        isDone: isDone ?? this.isDone,
        isAlertEnable: isAlertEnable ?? this.isAlertEnable,
        alertStartTime: alertStartTime ?? this.alertStartTime,
        extraExerciseExitIndex:
            extraExerciseExitIndex ?? this.extraExerciseExitIndex,
        userWeightAfterTraining:
            userWeightAfterTraining ?? this.userWeightAfterTraining,
        imagePath: imagePath ?? this.imagePath,
      );
  @override
  String toString() {
    return (StringBuffer('Training(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('trainingDate: $trainingDate, ')
          ..write('exercisesGroupId: $exercisesGroupId, ')
          ..write('isDone: $isDone, ')
          ..write('isAlertEnable: $isAlertEnable, ')
          ..write('alertStartTime: $alertStartTime, ')
          ..write('extraExerciseExitIndex: $extraExerciseExitIndex, ')
          ..write('userWeightAfterTraining: $userWeightAfterTraining, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              trainingDate.hashCode,
              $mrjc(
                  exercisesGroupId.hashCode,
                  $mrjc(
                      isDone.hashCode,
                      $mrjc(
                          isAlertEnable.hashCode,
                          $mrjc(
                              alertStartTime.hashCode,
                              $mrjc(
                                  extraExerciseExitIndex.hashCode,
                                  $mrjc(userWeightAfterTraining.hashCode,
                                      imagePath.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Training &&
          other.id == this.id &&
          other.name == this.name &&
          other.trainingDate == this.trainingDate &&
          other.exercisesGroupId == this.exercisesGroupId &&
          other.isDone == this.isDone &&
          other.isAlertEnable == this.isAlertEnable &&
          other.alertStartTime == this.alertStartTime &&
          other.extraExerciseExitIndex == this.extraExerciseExitIndex &&
          other.userWeightAfterTraining == this.userWeightAfterTraining &&
          other.imagePath == this.imagePath);
}

class TrainingsCompanion extends UpdateCompanion<Training> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> trainingDate;
  final Value<int> exercisesGroupId;
  final Value<bool> isDone;
  final Value<bool> isAlertEnable;
  final Value<DateTime> alertStartTime;
  final Value<int> extraExerciseExitIndex;
  final Value<String> userWeightAfterTraining;
  final Value<String> imagePath;
  const TrainingsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.trainingDate = const Value.absent(),
    this.exercisesGroupId = const Value.absent(),
    this.isDone = const Value.absent(),
    this.isAlertEnable = const Value.absent(),
    this.alertStartTime = const Value.absent(),
    this.extraExerciseExitIndex = const Value.absent(),
    this.userWeightAfterTraining = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  TrainingsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.trainingDate = const Value.absent(),
    this.exercisesGroupId = const Value.absent(),
    this.isDone = const Value.absent(),
    this.isAlertEnable = const Value.absent(),
    this.alertStartTime = const Value.absent(),
    this.extraExerciseExitIndex = const Value.absent(),
    this.userWeightAfterTraining = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  static Insertable<Training> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<DateTime> trainingDate,
    Expression<int> exercisesGroupId,
    Expression<bool> isDone,
    Expression<bool> isAlertEnable,
    Expression<DateTime> alertStartTime,
    Expression<int> extraExerciseExitIndex,
    Expression<String> userWeightAfterTraining,
    Expression<String> imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (trainingDate != null) 'training_date': trainingDate,
      if (exercisesGroupId != null) 'exercises_group_id': exercisesGroupId,
      if (isDone != null) 'is_done': isDone,
      if (isAlertEnable != null) 'is_alert_enable': isAlertEnable,
      if (alertStartTime != null) 'alert_start_time': alertStartTime,
      if (extraExerciseExitIndex != null)
        'extra_exercise_exit_index': extraExerciseExitIndex,
      if (userWeightAfterTraining != null)
        'user_weight_after_training': userWeightAfterTraining,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  TrainingsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<DateTime> trainingDate,
      Value<int> exercisesGroupId,
      Value<bool> isDone,
      Value<bool> isAlertEnable,
      Value<DateTime> alertStartTime,
      Value<int> extraExerciseExitIndex,
      Value<String> userWeightAfterTraining,
      Value<String> imagePath}) {
    return TrainingsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      trainingDate: trainingDate ?? this.trainingDate,
      exercisesGroupId: exercisesGroupId ?? this.exercisesGroupId,
      isDone: isDone ?? this.isDone,
      isAlertEnable: isAlertEnable ?? this.isAlertEnable,
      alertStartTime: alertStartTime ?? this.alertStartTime,
      extraExerciseExitIndex:
          extraExerciseExitIndex ?? this.extraExerciseExitIndex,
      userWeightAfterTraining:
          userWeightAfterTraining ?? this.userWeightAfterTraining,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trainingDate.present) {
      map['training_date'] = Variable<DateTime>(trainingDate.value);
    }
    if (exercisesGroupId.present) {
      map['exercises_group_id'] = Variable<int>(exercisesGroupId.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (isAlertEnable.present) {
      map['is_alert_enable'] = Variable<bool>(isAlertEnable.value);
    }
    if (alertStartTime.present) {
      map['alert_start_time'] = Variable<DateTime>(alertStartTime.value);
    }
    if (extraExerciseExitIndex.present) {
      map['extra_exercise_exit_index'] =
          Variable<int>(extraExerciseExitIndex.value);
    }
    if (userWeightAfterTraining.present) {
      map['user_weight_after_training'] =
          Variable<String>(userWeightAfterTraining.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    return map;
  }
}

class $TrainingsTable extends Trainings
    with TableInfo<$TrainingsTable, Training> {
  final GeneratedDatabase _db;
  final String _alias;
  $TrainingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        defaultValue: Constant(''));
  }

  final VerificationMeta _trainingDateMeta =
      const VerificationMeta('trainingDate');
  GeneratedDateTimeColumn _trainingDate;
  @override
  GeneratedDateTimeColumn get trainingDate =>
      _trainingDate ??= _constructTrainingDate();
  GeneratedDateTimeColumn _constructTrainingDate() {
    return GeneratedDateTimeColumn(
      'training_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _exercisesGroupIdMeta =
      const VerificationMeta('exercisesGroupId');
  GeneratedIntColumn _exercisesGroupId;
  @override
  GeneratedIntColumn get exercisesGroupId =>
      _exercisesGroupId ??= _constructExercisesGroupId();
  GeneratedIntColumn _constructExercisesGroupId() {
    return GeneratedIntColumn('exercises_group_id', $tableName, false,
        defaultValue: Constant(-1));
  }

  final VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  GeneratedBoolColumn _isDone;
  @override
  GeneratedBoolColumn get isDone => _isDone ??= _constructIsDone();
  GeneratedBoolColumn _constructIsDone() {
    return GeneratedBoolColumn('is_done', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _isAlertEnableMeta =
      const VerificationMeta('isAlertEnable');
  GeneratedBoolColumn _isAlertEnable;
  @override
  GeneratedBoolColumn get isAlertEnable =>
      _isAlertEnable ??= _constructIsAlertEnable();
  GeneratedBoolColumn _constructIsAlertEnable() {
    return GeneratedBoolColumn('is_alert_enable', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _alertStartTimeMeta =
      const VerificationMeta('alertStartTime');
  GeneratedDateTimeColumn _alertStartTime;
  @override
  GeneratedDateTimeColumn get alertStartTime =>
      _alertStartTime ??= _constructAlertStartTime();
  GeneratedDateTimeColumn _constructAlertStartTime() {
    return GeneratedDateTimeColumn(
      'alert_start_time',
      $tableName,
      true,
    );
  }

  final VerificationMeta _extraExerciseExitIndexMeta =
      const VerificationMeta('extraExerciseExitIndex');
  GeneratedIntColumn _extraExerciseExitIndex;
  @override
  GeneratedIntColumn get extraExerciseExitIndex =>
      _extraExerciseExitIndex ??= _constructExtraExerciseExitIndex();
  GeneratedIntColumn _constructExtraExerciseExitIndex() {
    return GeneratedIntColumn('extra_exercise_exit_index', $tableName, false,
        defaultValue: Constant(2));
  }

  final VerificationMeta _userWeightAfterTrainingMeta =
      const VerificationMeta('userWeightAfterTraining');
  GeneratedTextColumn _userWeightAfterTraining;
  @override
  GeneratedTextColumn get userWeightAfterTraining =>
      _userWeightAfterTraining ??= _constructUserWeightAfterTraining();
  GeneratedTextColumn _constructUserWeightAfterTraining() {
    return GeneratedTextColumn('user_weight_after_training', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  GeneratedTextColumn _imagePath;
  @override
  GeneratedTextColumn get imagePath => _imagePath ??= _constructImagePath();
  GeneratedTextColumn _constructImagePath() {
    return GeneratedTextColumn('image_path', $tableName, false,
        defaultValue: Constant(''));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        trainingDate,
        exercisesGroupId,
        isDone,
        isAlertEnable,
        alertStartTime,
        extraExerciseExitIndex,
        userWeightAfterTraining,
        imagePath
      ];
  @override
  $TrainingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'trainings';
  @override
  final String actualTableName = 'trainings';
  @override
  VerificationContext validateIntegrity(Insertable<Training> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('training_date')) {
      context.handle(
          _trainingDateMeta,
          trainingDate.isAcceptableOrUnknown(
              data['training_date'], _trainingDateMeta));
    }
    if (data.containsKey('exercises_group_id')) {
      context.handle(
          _exercisesGroupIdMeta,
          exercisesGroupId.isAcceptableOrUnknown(
              data['exercises_group_id'], _exercisesGroupIdMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done'], _isDoneMeta));
    }
    if (data.containsKey('is_alert_enable')) {
      context.handle(
          _isAlertEnableMeta,
          isAlertEnable.isAcceptableOrUnknown(
              data['is_alert_enable'], _isAlertEnableMeta));
    }
    if (data.containsKey('alert_start_time')) {
      context.handle(
          _alertStartTimeMeta,
          alertStartTime.isAcceptableOrUnknown(
              data['alert_start_time'], _alertStartTimeMeta));
    }
    if (data.containsKey('extra_exercise_exit_index')) {
      context.handle(
          _extraExerciseExitIndexMeta,
          extraExerciseExitIndex.isAcceptableOrUnknown(
              data['extra_exercise_exit_index'], _extraExerciseExitIndexMeta));
    }
    if (data.containsKey('user_weight_after_training')) {
      context.handle(
          _userWeightAfterTrainingMeta,
          userWeightAfterTraining.isAcceptableOrUnknown(
              data['user_weight_after_training'],
              _userWeightAfterTrainingMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path'], _imagePathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Training map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Training.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TrainingsTable createAlias(String alias) {
    return $TrainingsTable(_db, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final int sexIndex;
  final DateTime bd;
  final String weightIndex;
  final int weightMeasure;
  final String heightIndex;
  final int heightMeasure;
  final int fitnessStyleIndex;
  final int workOutCount;
  final String metabolicRate;
  final String caloriesNeed;
  final String bodyMassIndex;
  final int healsStatus;
  final String trainingSpendTime;
  final int trainingSpendCalories;
  final int trainingsDone;
  final String userWeightChanges;
  final String userQuestion1;
  final String userQuestion2;
  final String userQuestion3;
  final String trainingTimesPerWeek;
  final bool isSettingsFinished;
  final bool isSubscriptionBought;
  User(
      {@required this.id,
      @required this.name,
      @required this.sexIndex,
      this.bd,
      @required this.weightIndex,
      @required this.weightMeasure,
      @required this.heightIndex,
      @required this.heightMeasure,
      @required this.fitnessStyleIndex,
      @required this.workOutCount,
      @required this.metabolicRate,
      @required this.caloriesNeed,
      @required this.bodyMassIndex,
      @required this.healsStatus,
      @required this.trainingSpendTime,
      @required this.trainingSpendCalories,
      @required this.trainingsDone,
      this.userWeightChanges,
      @required this.userQuestion1,
      @required this.userQuestion2,
      @required this.userQuestion3,
      @required this.trainingTimesPerWeek,
      @required this.isSettingsFinished,
      @required this.isSubscriptionBought});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return User(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      sexIndex:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sex_index']),
      bd: dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}bd']),
      weightIndex: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}weight_index']),
      weightMeasure: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}weight_measure']),
      heightIndex: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}height_index']),
      heightMeasure: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}height_measure']),
      fitnessStyleIndex: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}fitness_style_index']),
      workOutCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}work_out_count']),
      metabolicRate: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}metabolic_rate']),
      caloriesNeed: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}calories_need']),
      bodyMassIndex: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}body_mass_index']),
      healsStatus: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}heals_status']),
      trainingSpendTime: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}training_spend_time']),
      trainingSpendCalories: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}training_spend_calories']),
      trainingsDone: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}trainings_done']),
      userWeightChanges: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}user_weight_changes']),
      userQuestion1: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_question1']),
      userQuestion2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_question2']),
      userQuestion3: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_question3']),
      trainingTimesPerWeek: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}training_times_per_week']),
      isSettingsFinished: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}is_settings_finished']),
      isSubscriptionBought: boolType.mapFromDatabaseResponse(
          data['${effectivePrefix}is_subscription_bought']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || sexIndex != null) {
      map['sex_index'] = Variable<int>(sexIndex);
    }
    if (!nullToAbsent || bd != null) {
      map['bd'] = Variable<DateTime>(bd);
    }
    if (!nullToAbsent || weightIndex != null) {
      map['weight_index'] = Variable<String>(weightIndex);
    }
    if (!nullToAbsent || weightMeasure != null) {
      map['weight_measure'] = Variable<int>(weightMeasure);
    }
    if (!nullToAbsent || heightIndex != null) {
      map['height_index'] = Variable<String>(heightIndex);
    }
    if (!nullToAbsent || heightMeasure != null) {
      map['height_measure'] = Variable<int>(heightMeasure);
    }
    if (!nullToAbsent || fitnessStyleIndex != null) {
      map['fitness_style_index'] = Variable<int>(fitnessStyleIndex);
    }
    if (!nullToAbsent || workOutCount != null) {
      map['work_out_count'] = Variable<int>(workOutCount);
    }
    if (!nullToAbsent || metabolicRate != null) {
      map['metabolic_rate'] = Variable<String>(metabolicRate);
    }
    if (!nullToAbsent || caloriesNeed != null) {
      map['calories_need'] = Variable<String>(caloriesNeed);
    }
    if (!nullToAbsent || bodyMassIndex != null) {
      map['body_mass_index'] = Variable<String>(bodyMassIndex);
    }
    if (!nullToAbsent || healsStatus != null) {
      map['heals_status'] = Variable<int>(healsStatus);
    }
    if (!nullToAbsent || trainingSpendTime != null) {
      map['training_spend_time'] = Variable<String>(trainingSpendTime);
    }
    if (!nullToAbsent || trainingSpendCalories != null) {
      map['training_spend_calories'] = Variable<int>(trainingSpendCalories);
    }
    if (!nullToAbsent || trainingsDone != null) {
      map['trainings_done'] = Variable<int>(trainingsDone);
    }
    if (!nullToAbsent || userWeightChanges != null) {
      map['user_weight_changes'] = Variable<String>(userWeightChanges);
    }
    if (!nullToAbsent || userQuestion1 != null) {
      map['user_question1'] = Variable<String>(userQuestion1);
    }
    if (!nullToAbsent || userQuestion2 != null) {
      map['user_question2'] = Variable<String>(userQuestion2);
    }
    if (!nullToAbsent || userQuestion3 != null) {
      map['user_question3'] = Variable<String>(userQuestion3);
    }
    if (!nullToAbsent || trainingTimesPerWeek != null) {
      map['training_times_per_week'] = Variable<String>(trainingTimesPerWeek);
    }
    if (!nullToAbsent || isSettingsFinished != null) {
      map['is_settings_finished'] = Variable<bool>(isSettingsFinished);
    }
    if (!nullToAbsent || isSubscriptionBought != null) {
      map['is_subscription_bought'] = Variable<bool>(isSubscriptionBought);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      sexIndex: sexIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(sexIndex),
      bd: bd == null && nullToAbsent ? const Value.absent() : Value(bd),
      weightIndex: weightIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(weightIndex),
      weightMeasure: weightMeasure == null && nullToAbsent
          ? const Value.absent()
          : Value(weightMeasure),
      heightIndex: heightIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(heightIndex),
      heightMeasure: heightMeasure == null && nullToAbsent
          ? const Value.absent()
          : Value(heightMeasure),
      fitnessStyleIndex: fitnessStyleIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(fitnessStyleIndex),
      workOutCount: workOutCount == null && nullToAbsent
          ? const Value.absent()
          : Value(workOutCount),
      metabolicRate: metabolicRate == null && nullToAbsent
          ? const Value.absent()
          : Value(metabolicRate),
      caloriesNeed: caloriesNeed == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesNeed),
      bodyMassIndex: bodyMassIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyMassIndex),
      healsStatus: healsStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(healsStatus),
      trainingSpendTime: trainingSpendTime == null && nullToAbsent
          ? const Value.absent()
          : Value(trainingSpendTime),
      trainingSpendCalories: trainingSpendCalories == null && nullToAbsent
          ? const Value.absent()
          : Value(trainingSpendCalories),
      trainingsDone: trainingsDone == null && nullToAbsent
          ? const Value.absent()
          : Value(trainingsDone),
      userWeightChanges: userWeightChanges == null && nullToAbsent
          ? const Value.absent()
          : Value(userWeightChanges),
      userQuestion1: userQuestion1 == null && nullToAbsent
          ? const Value.absent()
          : Value(userQuestion1),
      userQuestion2: userQuestion2 == null && nullToAbsent
          ? const Value.absent()
          : Value(userQuestion2),
      userQuestion3: userQuestion3 == null && nullToAbsent
          ? const Value.absent()
          : Value(userQuestion3),
      trainingTimesPerWeek: trainingTimesPerWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(trainingTimesPerWeek),
      isSettingsFinished: isSettingsFinished == null && nullToAbsent
          ? const Value.absent()
          : Value(isSettingsFinished),
      isSubscriptionBought: isSubscriptionBought == null && nullToAbsent
          ? const Value.absent()
          : Value(isSubscriptionBought),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sexIndex: serializer.fromJson<int>(json['sexIndex']),
      bd: serializer.fromJson<DateTime>(json['bd']),
      weightIndex: serializer.fromJson<String>(json['weightIndex']),
      weightMeasure: serializer.fromJson<int>(json['weightMeasure']),
      heightIndex: serializer.fromJson<String>(json['heightIndex']),
      heightMeasure: serializer.fromJson<int>(json['heightMeasure']),
      fitnessStyleIndex: serializer.fromJson<int>(json['fitnessStyleIndex']),
      workOutCount: serializer.fromJson<int>(json['workOutCount']),
      metabolicRate: serializer.fromJson<String>(json['metabolicRate']),
      caloriesNeed: serializer.fromJson<String>(json['caloriesNeed']),
      bodyMassIndex: serializer.fromJson<String>(json['bodyMassIndex']),
      healsStatus: serializer.fromJson<int>(json['healsStatus']),
      trainingSpendTime: serializer.fromJson<String>(json['trainingSpendTime']),
      trainingSpendCalories:
          serializer.fromJson<int>(json['trainingSpendCalories']),
      trainingsDone: serializer.fromJson<int>(json['trainingsDone']),
      userWeightChanges: serializer.fromJson<String>(json['userWeightChanges']),
      userQuestion1: serializer.fromJson<String>(json['userQuestion1']),
      userQuestion2: serializer.fromJson<String>(json['userQuestion2']),
      userQuestion3: serializer.fromJson<String>(json['userQuestion3']),
      trainingTimesPerWeek:
          serializer.fromJson<String>(json['trainingTimesPerWeek']),
      isSettingsFinished: serializer.fromJson<bool>(json['isSettingsFinished']),
      isSubscriptionBought:
          serializer.fromJson<bool>(json['isSubscriptionBought']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sexIndex': serializer.toJson<int>(sexIndex),
      'bd': serializer.toJson<DateTime>(bd),
      'weightIndex': serializer.toJson<String>(weightIndex),
      'weightMeasure': serializer.toJson<int>(weightMeasure),
      'heightIndex': serializer.toJson<String>(heightIndex),
      'heightMeasure': serializer.toJson<int>(heightMeasure),
      'fitnessStyleIndex': serializer.toJson<int>(fitnessStyleIndex),
      'workOutCount': serializer.toJson<int>(workOutCount),
      'metabolicRate': serializer.toJson<String>(metabolicRate),
      'caloriesNeed': serializer.toJson<String>(caloriesNeed),
      'bodyMassIndex': serializer.toJson<String>(bodyMassIndex),
      'healsStatus': serializer.toJson<int>(healsStatus),
      'trainingSpendTime': serializer.toJson<String>(trainingSpendTime),
      'trainingSpendCalories': serializer.toJson<int>(trainingSpendCalories),
      'trainingsDone': serializer.toJson<int>(trainingsDone),
      'userWeightChanges': serializer.toJson<String>(userWeightChanges),
      'userQuestion1': serializer.toJson<String>(userQuestion1),
      'userQuestion2': serializer.toJson<String>(userQuestion2),
      'userQuestion3': serializer.toJson<String>(userQuestion3),
      'trainingTimesPerWeek': serializer.toJson<String>(trainingTimesPerWeek),
      'isSettingsFinished': serializer.toJson<bool>(isSettingsFinished),
      'isSubscriptionBought': serializer.toJson<bool>(isSubscriptionBought),
    };
  }

  User copyWith(
          {int id,
          String name,
          int sexIndex,
          DateTime bd,
          String weightIndex,
          int weightMeasure,
          String heightIndex,
          int heightMeasure,
          int fitnessStyleIndex,
          int workOutCount,
          String metabolicRate,
          String caloriesNeed,
          String bodyMassIndex,
          int healsStatus,
          String trainingSpendTime,
          int trainingSpendCalories,
          int trainingsDone,
          String userWeightChanges,
          String userQuestion1,
          String userQuestion2,
          String userQuestion3,
          String trainingTimesPerWeek,
          bool isSettingsFinished,
          bool isSubscriptionBought}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        sexIndex: sexIndex ?? this.sexIndex,
        bd: bd ?? this.bd,
        weightIndex: weightIndex ?? this.weightIndex,
        weightMeasure: weightMeasure ?? this.weightMeasure,
        heightIndex: heightIndex ?? this.heightIndex,
        heightMeasure: heightMeasure ?? this.heightMeasure,
        fitnessStyleIndex: fitnessStyleIndex ?? this.fitnessStyleIndex,
        workOutCount: workOutCount ?? this.workOutCount,
        metabolicRate: metabolicRate ?? this.metabolicRate,
        caloriesNeed: caloriesNeed ?? this.caloriesNeed,
        bodyMassIndex: bodyMassIndex ?? this.bodyMassIndex,
        healsStatus: healsStatus ?? this.healsStatus,
        trainingSpendTime: trainingSpendTime ?? this.trainingSpendTime,
        trainingSpendCalories:
            trainingSpendCalories ?? this.trainingSpendCalories,
        trainingsDone: trainingsDone ?? this.trainingsDone,
        userWeightChanges: userWeightChanges ?? this.userWeightChanges,
        userQuestion1: userQuestion1 ?? this.userQuestion1,
        userQuestion2: userQuestion2 ?? this.userQuestion2,
        userQuestion3: userQuestion3 ?? this.userQuestion3,
        trainingTimesPerWeek: trainingTimesPerWeek ?? this.trainingTimesPerWeek,
        isSettingsFinished: isSettingsFinished ?? this.isSettingsFinished,
        isSubscriptionBought: isSubscriptionBought ?? this.isSubscriptionBought,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sexIndex: $sexIndex, ')
          ..write('bd: $bd, ')
          ..write('weightIndex: $weightIndex, ')
          ..write('weightMeasure: $weightMeasure, ')
          ..write('heightIndex: $heightIndex, ')
          ..write('heightMeasure: $heightMeasure, ')
          ..write('fitnessStyleIndex: $fitnessStyleIndex, ')
          ..write('workOutCount: $workOutCount, ')
          ..write('metabolicRate: $metabolicRate, ')
          ..write('caloriesNeed: $caloriesNeed, ')
          ..write('bodyMassIndex: $bodyMassIndex, ')
          ..write('healsStatus: $healsStatus, ')
          ..write('trainingSpendTime: $trainingSpendTime, ')
          ..write('trainingSpendCalories: $trainingSpendCalories, ')
          ..write('trainingsDone: $trainingsDone, ')
          ..write('userWeightChanges: $userWeightChanges, ')
          ..write('userQuestion1: $userQuestion1, ')
          ..write('userQuestion2: $userQuestion2, ')
          ..write('userQuestion3: $userQuestion3, ')
          ..write('trainingTimesPerWeek: $trainingTimesPerWeek, ')
          ..write('isSettingsFinished: $isSettingsFinished, ')
          ..write('isSubscriptionBought: $isSubscriptionBought')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              sexIndex.hashCode,
              $mrjc(
                  bd.hashCode,
                  $mrjc(
                      weightIndex.hashCode,
                      $mrjc(
                          weightMeasure.hashCode,
                          $mrjc(
                              heightIndex.hashCode,
                              $mrjc(
                                  heightMeasure.hashCode,
                                  $mrjc(
                                      fitnessStyleIndex.hashCode,
                                      $mrjc(
                                          workOutCount.hashCode,
                                          $mrjc(
                                              metabolicRate.hashCode,
                                              $mrjc(
                                                  caloriesNeed.hashCode,
                                                  $mrjc(
                                                      bodyMassIndex.hashCode,
                                                      $mrjc(
                                                          healsStatus.hashCode,
                                                          $mrjc(
                                                              trainingSpendTime
                                                                  .hashCode,
                                                              $mrjc(
                                                                  trainingSpendCalories
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      trainingsDone
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          userWeightChanges
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              userQuestion1.hashCode,
                                                                              $mrjc(userQuestion2.hashCode, $mrjc(userQuestion3.hashCode, $mrjc(trainingTimesPerWeek.hashCode, $mrjc(isSettingsFinished.hashCode, isSubscriptionBought.hashCode))))))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.sexIndex == this.sexIndex &&
          other.bd == this.bd &&
          other.weightIndex == this.weightIndex &&
          other.weightMeasure == this.weightMeasure &&
          other.heightIndex == this.heightIndex &&
          other.heightMeasure == this.heightMeasure &&
          other.fitnessStyleIndex == this.fitnessStyleIndex &&
          other.workOutCount == this.workOutCount &&
          other.metabolicRate == this.metabolicRate &&
          other.caloriesNeed == this.caloriesNeed &&
          other.bodyMassIndex == this.bodyMassIndex &&
          other.healsStatus == this.healsStatus &&
          other.trainingSpendTime == this.trainingSpendTime &&
          other.trainingSpendCalories == this.trainingSpendCalories &&
          other.trainingsDone == this.trainingsDone &&
          other.userWeightChanges == this.userWeightChanges &&
          other.userQuestion1 == this.userQuestion1 &&
          other.userQuestion2 == this.userQuestion2 &&
          other.userQuestion3 == this.userQuestion3 &&
          other.trainingTimesPerWeek == this.trainingTimesPerWeek &&
          other.isSettingsFinished == this.isSettingsFinished &&
          other.isSubscriptionBought == this.isSubscriptionBought);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sexIndex;
  final Value<DateTime> bd;
  final Value<String> weightIndex;
  final Value<int> weightMeasure;
  final Value<String> heightIndex;
  final Value<int> heightMeasure;
  final Value<int> fitnessStyleIndex;
  final Value<int> workOutCount;
  final Value<String> metabolicRate;
  final Value<String> caloriesNeed;
  final Value<String> bodyMassIndex;
  final Value<int> healsStatus;
  final Value<String> trainingSpendTime;
  final Value<int> trainingSpendCalories;
  final Value<int> trainingsDone;
  final Value<String> userWeightChanges;
  final Value<String> userQuestion1;
  final Value<String> userQuestion2;
  final Value<String> userQuestion3;
  final Value<String> trainingTimesPerWeek;
  final Value<bool> isSettingsFinished;
  final Value<bool> isSubscriptionBought;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sexIndex = const Value.absent(),
    this.bd = const Value.absent(),
    this.weightIndex = const Value.absent(),
    this.weightMeasure = const Value.absent(),
    this.heightIndex = const Value.absent(),
    this.heightMeasure = const Value.absent(),
    this.fitnessStyleIndex = const Value.absent(),
    this.workOutCount = const Value.absent(),
    this.metabolicRate = const Value.absent(),
    this.caloriesNeed = const Value.absent(),
    this.bodyMassIndex = const Value.absent(),
    this.healsStatus = const Value.absent(),
    this.trainingSpendTime = const Value.absent(),
    this.trainingSpendCalories = const Value.absent(),
    this.trainingsDone = const Value.absent(),
    this.userWeightChanges = const Value.absent(),
    this.userQuestion1 = const Value.absent(),
    this.userQuestion2 = const Value.absent(),
    this.userQuestion3 = const Value.absent(),
    this.trainingTimesPerWeek = const Value.absent(),
    this.isSettingsFinished = const Value.absent(),
    this.isSubscriptionBought = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sexIndex = const Value.absent(),
    this.bd = const Value.absent(),
    this.weightIndex = const Value.absent(),
    this.weightMeasure = const Value.absent(),
    this.heightIndex = const Value.absent(),
    this.heightMeasure = const Value.absent(),
    this.fitnessStyleIndex = const Value.absent(),
    this.workOutCount = const Value.absent(),
    this.metabolicRate = const Value.absent(),
    this.caloriesNeed = const Value.absent(),
    this.bodyMassIndex = const Value.absent(),
    this.healsStatus = const Value.absent(),
    this.trainingSpendTime = const Value.absent(),
    this.trainingSpendCalories = const Value.absent(),
    this.trainingsDone = const Value.absent(),
    this.userWeightChanges = const Value.absent(),
    this.userQuestion1 = const Value.absent(),
    this.userQuestion2 = const Value.absent(),
    this.userQuestion3 = const Value.absent(),
    this.trainingTimesPerWeek = const Value.absent(),
    this.isSettingsFinished = const Value.absent(),
    this.isSubscriptionBought = const Value.absent(),
  });
  static Insertable<User> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<int> sexIndex,
    Expression<DateTime> bd,
    Expression<String> weightIndex,
    Expression<int> weightMeasure,
    Expression<String> heightIndex,
    Expression<int> heightMeasure,
    Expression<int> fitnessStyleIndex,
    Expression<int> workOutCount,
    Expression<String> metabolicRate,
    Expression<String> caloriesNeed,
    Expression<String> bodyMassIndex,
    Expression<int> healsStatus,
    Expression<String> trainingSpendTime,
    Expression<int> trainingSpendCalories,
    Expression<int> trainingsDone,
    Expression<String> userWeightChanges,
    Expression<String> userQuestion1,
    Expression<String> userQuestion2,
    Expression<String> userQuestion3,
    Expression<String> trainingTimesPerWeek,
    Expression<bool> isSettingsFinished,
    Expression<bool> isSubscriptionBought,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sexIndex != null) 'sex_index': sexIndex,
      if (bd != null) 'bd': bd,
      if (weightIndex != null) 'weight_index': weightIndex,
      if (weightMeasure != null) 'weight_measure': weightMeasure,
      if (heightIndex != null) 'height_index': heightIndex,
      if (heightMeasure != null) 'height_measure': heightMeasure,
      if (fitnessStyleIndex != null) 'fitness_style_index': fitnessStyleIndex,
      if (workOutCount != null) 'work_out_count': workOutCount,
      if (metabolicRate != null) 'metabolic_rate': metabolicRate,
      if (caloriesNeed != null) 'calories_need': caloriesNeed,
      if (bodyMassIndex != null) 'body_mass_index': bodyMassIndex,
      if (healsStatus != null) 'heals_status': healsStatus,
      if (trainingSpendTime != null) 'training_spend_time': trainingSpendTime,
      if (trainingSpendCalories != null)
        'training_spend_calories': trainingSpendCalories,
      if (trainingsDone != null) 'trainings_done': trainingsDone,
      if (userWeightChanges != null) 'user_weight_changes': userWeightChanges,
      if (userQuestion1 != null) 'user_question1': userQuestion1,
      if (userQuestion2 != null) 'user_question2': userQuestion2,
      if (userQuestion3 != null) 'user_question3': userQuestion3,
      if (trainingTimesPerWeek != null)
        'training_times_per_week': trainingTimesPerWeek,
      if (isSettingsFinished != null)
        'is_settings_finished': isSettingsFinished,
      if (isSubscriptionBought != null)
        'is_subscription_bought': isSubscriptionBought,
    });
  }

  UsersCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<int> sexIndex,
      Value<DateTime> bd,
      Value<String> weightIndex,
      Value<int> weightMeasure,
      Value<String> heightIndex,
      Value<int> heightMeasure,
      Value<int> fitnessStyleIndex,
      Value<int> workOutCount,
      Value<String> metabolicRate,
      Value<String> caloriesNeed,
      Value<String> bodyMassIndex,
      Value<int> healsStatus,
      Value<String> trainingSpendTime,
      Value<int> trainingSpendCalories,
      Value<int> trainingsDone,
      Value<String> userWeightChanges,
      Value<String> userQuestion1,
      Value<String> userQuestion2,
      Value<String> userQuestion3,
      Value<String> trainingTimesPerWeek,
      Value<bool> isSettingsFinished,
      Value<bool> isSubscriptionBought}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sexIndex: sexIndex ?? this.sexIndex,
      bd: bd ?? this.bd,
      weightIndex: weightIndex ?? this.weightIndex,
      weightMeasure: weightMeasure ?? this.weightMeasure,
      heightIndex: heightIndex ?? this.heightIndex,
      heightMeasure: heightMeasure ?? this.heightMeasure,
      fitnessStyleIndex: fitnessStyleIndex ?? this.fitnessStyleIndex,
      workOutCount: workOutCount ?? this.workOutCount,
      metabolicRate: metabolicRate ?? this.metabolicRate,
      caloriesNeed: caloriesNeed ?? this.caloriesNeed,
      bodyMassIndex: bodyMassIndex ?? this.bodyMassIndex,
      healsStatus: healsStatus ?? this.healsStatus,
      trainingSpendTime: trainingSpendTime ?? this.trainingSpendTime,
      trainingSpendCalories:
          trainingSpendCalories ?? this.trainingSpendCalories,
      trainingsDone: trainingsDone ?? this.trainingsDone,
      userWeightChanges: userWeightChanges ?? this.userWeightChanges,
      userQuestion1: userQuestion1 ?? this.userQuestion1,
      userQuestion2: userQuestion2 ?? this.userQuestion2,
      userQuestion3: userQuestion3 ?? this.userQuestion3,
      trainingTimesPerWeek: trainingTimesPerWeek ?? this.trainingTimesPerWeek,
      isSettingsFinished: isSettingsFinished ?? this.isSettingsFinished,
      isSubscriptionBought: isSubscriptionBought ?? this.isSubscriptionBought,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sexIndex.present) {
      map['sex_index'] = Variable<int>(sexIndex.value);
    }
    if (bd.present) {
      map['bd'] = Variable<DateTime>(bd.value);
    }
    if (weightIndex.present) {
      map['weight_index'] = Variable<String>(weightIndex.value);
    }
    if (weightMeasure.present) {
      map['weight_measure'] = Variable<int>(weightMeasure.value);
    }
    if (heightIndex.present) {
      map['height_index'] = Variable<String>(heightIndex.value);
    }
    if (heightMeasure.present) {
      map['height_measure'] = Variable<int>(heightMeasure.value);
    }
    if (fitnessStyleIndex.present) {
      map['fitness_style_index'] = Variable<int>(fitnessStyleIndex.value);
    }
    if (workOutCount.present) {
      map['work_out_count'] = Variable<int>(workOutCount.value);
    }
    if (metabolicRate.present) {
      map['metabolic_rate'] = Variable<String>(metabolicRate.value);
    }
    if (caloriesNeed.present) {
      map['calories_need'] = Variable<String>(caloriesNeed.value);
    }
    if (bodyMassIndex.present) {
      map['body_mass_index'] = Variable<String>(bodyMassIndex.value);
    }
    if (healsStatus.present) {
      map['heals_status'] = Variable<int>(healsStatus.value);
    }
    if (trainingSpendTime.present) {
      map['training_spend_time'] = Variable<String>(trainingSpendTime.value);
    }
    if (trainingSpendCalories.present) {
      map['training_spend_calories'] =
          Variable<int>(trainingSpendCalories.value);
    }
    if (trainingsDone.present) {
      map['trainings_done'] = Variable<int>(trainingsDone.value);
    }
    if (userWeightChanges.present) {
      map['user_weight_changes'] = Variable<String>(userWeightChanges.value);
    }
    if (userQuestion1.present) {
      map['user_question1'] = Variable<String>(userQuestion1.value);
    }
    if (userQuestion2.present) {
      map['user_question2'] = Variable<String>(userQuestion2.value);
    }
    if (userQuestion3.present) {
      map['user_question3'] = Variable<String>(userQuestion3.value);
    }
    if (trainingTimesPerWeek.present) {
      map['training_times_per_week'] =
          Variable<String>(trainingTimesPerWeek.value);
    }
    if (isSettingsFinished.present) {
      map['is_settings_finished'] = Variable<bool>(isSettingsFinished.value);
    }
    if (isSubscriptionBought.present) {
      map['is_subscription_bought'] =
          Variable<bool>(isSubscriptionBought.value);
    }
    return map;
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        defaultValue: Constant(''));
  }

  final VerificationMeta _sexIndexMeta = const VerificationMeta('sexIndex');
  GeneratedIntColumn _sexIndex;
  @override
  GeneratedIntColumn get sexIndex => _sexIndex ??= _constructSexIndex();
  GeneratedIntColumn _constructSexIndex() {
    return GeneratedIntColumn('sex_index', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _bdMeta = const VerificationMeta('bd');
  GeneratedDateTimeColumn _bd;
  @override
  GeneratedDateTimeColumn get bd => _bd ??= _constructBd();
  GeneratedDateTimeColumn _constructBd() {
    return GeneratedDateTimeColumn(
      'bd',
      $tableName,
      true,
    );
  }

  final VerificationMeta _weightIndexMeta =
      const VerificationMeta('weightIndex');
  GeneratedTextColumn _weightIndex;
  @override
  GeneratedTextColumn get weightIndex =>
      _weightIndex ??= _constructWeightIndex();
  GeneratedTextColumn _constructWeightIndex() {
    return GeneratedTextColumn('weight_index', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _weightMeasureMeta =
      const VerificationMeta('weightMeasure');
  GeneratedIntColumn _weightMeasure;
  @override
  GeneratedIntColumn get weightMeasure =>
      _weightMeasure ??= _constructWeightMeasure();
  GeneratedIntColumn _constructWeightMeasure() {
    return GeneratedIntColumn('weight_measure', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _heightIndexMeta =
      const VerificationMeta('heightIndex');
  GeneratedTextColumn _heightIndex;
  @override
  GeneratedTextColumn get heightIndex =>
      _heightIndex ??= _constructHeightIndex();
  GeneratedTextColumn _constructHeightIndex() {
    return GeneratedTextColumn('height_index', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _heightMeasureMeta =
      const VerificationMeta('heightMeasure');
  GeneratedIntColumn _heightMeasure;
  @override
  GeneratedIntColumn get heightMeasure =>
      _heightMeasure ??= _constructHeightMeasure();
  GeneratedIntColumn _constructHeightMeasure() {
    return GeneratedIntColumn('height_measure', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _fitnessStyleIndexMeta =
      const VerificationMeta('fitnessStyleIndex');
  GeneratedIntColumn _fitnessStyleIndex;
  @override
  GeneratedIntColumn get fitnessStyleIndex =>
      _fitnessStyleIndex ??= _constructFitnessStyleIndex();
  GeneratedIntColumn _constructFitnessStyleIndex() {
    return GeneratedIntColumn('fitness_style_index', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _workOutCountMeta =
      const VerificationMeta('workOutCount');
  GeneratedIntColumn _workOutCount;
  @override
  GeneratedIntColumn get workOutCount =>
      _workOutCount ??= _constructWorkOutCount();
  GeneratedIntColumn _constructWorkOutCount() {
    return GeneratedIntColumn('work_out_count', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _metabolicRateMeta =
      const VerificationMeta('metabolicRate');
  GeneratedTextColumn _metabolicRate;
  @override
  GeneratedTextColumn get metabolicRate =>
      _metabolicRate ??= _constructMetabolicRate();
  GeneratedTextColumn _constructMetabolicRate() {
    return GeneratedTextColumn('metabolic_rate', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _caloriesNeedMeta =
      const VerificationMeta('caloriesNeed');
  GeneratedTextColumn _caloriesNeed;
  @override
  GeneratedTextColumn get caloriesNeed =>
      _caloriesNeed ??= _constructCaloriesNeed();
  GeneratedTextColumn _constructCaloriesNeed() {
    return GeneratedTextColumn('calories_need', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _bodyMassIndexMeta =
      const VerificationMeta('bodyMassIndex');
  GeneratedTextColumn _bodyMassIndex;
  @override
  GeneratedTextColumn get bodyMassIndex =>
      _bodyMassIndex ??= _constructBodyMassIndex();
  GeneratedTextColumn _constructBodyMassIndex() {
    return GeneratedTextColumn('body_mass_index', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _healsStatusMeta =
      const VerificationMeta('healsStatus');
  GeneratedIntColumn _healsStatus;
  @override
  GeneratedIntColumn get healsStatus =>
      _healsStatus ??= _constructHealsStatus();
  GeneratedIntColumn _constructHealsStatus() {
    return GeneratedIntColumn('heals_status', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _trainingSpendTimeMeta =
      const VerificationMeta('trainingSpendTime');
  GeneratedTextColumn _trainingSpendTime;
  @override
  GeneratedTextColumn get trainingSpendTime =>
      _trainingSpendTime ??= _constructTrainingSpendTime();
  GeneratedTextColumn _constructTrainingSpendTime() {
    return GeneratedTextColumn('training_spend_time', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _trainingSpendCaloriesMeta =
      const VerificationMeta('trainingSpendCalories');
  GeneratedIntColumn _trainingSpendCalories;
  @override
  GeneratedIntColumn get trainingSpendCalories =>
      _trainingSpendCalories ??= _constructTrainingSpendCalories();
  GeneratedIntColumn _constructTrainingSpendCalories() {
    return GeneratedIntColumn('training_spend_calories', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _trainingsDoneMeta =
      const VerificationMeta('trainingsDone');
  GeneratedIntColumn _trainingsDone;
  @override
  GeneratedIntColumn get trainingsDone =>
      _trainingsDone ??= _constructTrainingsDone();
  GeneratedIntColumn _constructTrainingsDone() {
    return GeneratedIntColumn('trainings_done', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _userWeightChangesMeta =
      const VerificationMeta('userWeightChanges');
  GeneratedTextColumn _userWeightChanges;
  @override
  GeneratedTextColumn get userWeightChanges =>
      _userWeightChanges ??= _constructUserWeightChanges();
  GeneratedTextColumn _constructUserWeightChanges() {
    return GeneratedTextColumn(
      'user_weight_changes',
      $tableName,
      true,
    );
  }

  final VerificationMeta _userQuestion1Meta =
      const VerificationMeta('userQuestion1');
  GeneratedTextColumn _userQuestion1;
  @override
  GeneratedTextColumn get userQuestion1 =>
      _userQuestion1 ??= _constructUserQuestion1();
  GeneratedTextColumn _constructUserQuestion1() {
    return GeneratedTextColumn('user_question1', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _userQuestion2Meta =
      const VerificationMeta('userQuestion2');
  GeneratedTextColumn _userQuestion2;
  @override
  GeneratedTextColumn get userQuestion2 =>
      _userQuestion2 ??= _constructUserQuestion2();
  GeneratedTextColumn _constructUserQuestion2() {
    return GeneratedTextColumn('user_question2', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _userQuestion3Meta =
      const VerificationMeta('userQuestion3');
  GeneratedTextColumn _userQuestion3;
  @override
  GeneratedTextColumn get userQuestion3 =>
      _userQuestion3 ??= _constructUserQuestion3();
  GeneratedTextColumn _constructUserQuestion3() {
    return GeneratedTextColumn('user_question3', $tableName, false,
        defaultValue: Constant('0.0'));
  }

  final VerificationMeta _trainingTimesPerWeekMeta =
      const VerificationMeta('trainingTimesPerWeek');
  GeneratedTextColumn _trainingTimesPerWeek;
  @override
  GeneratedTextColumn get trainingTimesPerWeek =>
      _trainingTimesPerWeek ??= _constructTrainingTimesPerWeek();
  GeneratedTextColumn _constructTrainingTimesPerWeek() {
    return GeneratedTextColumn('training_times_per_week', $tableName, false,
        defaultValue: Constant('2.0'));
  }

  final VerificationMeta _isSettingsFinishedMeta =
      const VerificationMeta('isSettingsFinished');
  GeneratedBoolColumn _isSettingsFinished;
  @override
  GeneratedBoolColumn get isSettingsFinished =>
      _isSettingsFinished ??= _constructIsSettingsFinished();
  GeneratedBoolColumn _constructIsSettingsFinished() {
    return GeneratedBoolColumn('is_settings_finished', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _isSubscriptionBoughtMeta =
      const VerificationMeta('isSubscriptionBought');
  GeneratedBoolColumn _isSubscriptionBought;
  @override
  GeneratedBoolColumn get isSubscriptionBought =>
      _isSubscriptionBought ??= _constructIsSubscriptionBought();
  GeneratedBoolColumn _constructIsSubscriptionBought() {
    return GeneratedBoolColumn('is_subscription_bought', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        sexIndex,
        bd,
        weightIndex,
        weightMeasure,
        heightIndex,
        heightMeasure,
        fitnessStyleIndex,
        workOutCount,
        metabolicRate,
        caloriesNeed,
        bodyMassIndex,
        healsStatus,
        trainingSpendTime,
        trainingSpendCalories,
        trainingsDone,
        userWeightChanges,
        userQuestion1,
        userQuestion2,
        userQuestion3,
        trainingTimesPerWeek,
        isSettingsFinished,
        isSubscriptionBought
      ];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('sex_index')) {
      context.handle(_sexIndexMeta,
          sexIndex.isAcceptableOrUnknown(data['sex_index'], _sexIndexMeta));
    }
    if (data.containsKey('bd')) {
      context.handle(_bdMeta, bd.isAcceptableOrUnknown(data['bd'], _bdMeta));
    }
    if (data.containsKey('weight_index')) {
      context.handle(
          _weightIndexMeta,
          weightIndex.isAcceptableOrUnknown(
              data['weight_index'], _weightIndexMeta));
    }
    if (data.containsKey('weight_measure')) {
      context.handle(
          _weightMeasureMeta,
          weightMeasure.isAcceptableOrUnknown(
              data['weight_measure'], _weightMeasureMeta));
    }
    if (data.containsKey('height_index')) {
      context.handle(
          _heightIndexMeta,
          heightIndex.isAcceptableOrUnknown(
              data['height_index'], _heightIndexMeta));
    }
    if (data.containsKey('height_measure')) {
      context.handle(
          _heightMeasureMeta,
          heightMeasure.isAcceptableOrUnknown(
              data['height_measure'], _heightMeasureMeta));
    }
    if (data.containsKey('fitness_style_index')) {
      context.handle(
          _fitnessStyleIndexMeta,
          fitnessStyleIndex.isAcceptableOrUnknown(
              data['fitness_style_index'], _fitnessStyleIndexMeta));
    }
    if (data.containsKey('work_out_count')) {
      context.handle(
          _workOutCountMeta,
          workOutCount.isAcceptableOrUnknown(
              data['work_out_count'], _workOutCountMeta));
    }
    if (data.containsKey('metabolic_rate')) {
      context.handle(
          _metabolicRateMeta,
          metabolicRate.isAcceptableOrUnknown(
              data['metabolic_rate'], _metabolicRateMeta));
    }
    if (data.containsKey('calories_need')) {
      context.handle(
          _caloriesNeedMeta,
          caloriesNeed.isAcceptableOrUnknown(
              data['calories_need'], _caloriesNeedMeta));
    }
    if (data.containsKey('body_mass_index')) {
      context.handle(
          _bodyMassIndexMeta,
          bodyMassIndex.isAcceptableOrUnknown(
              data['body_mass_index'], _bodyMassIndexMeta));
    }
    if (data.containsKey('heals_status')) {
      context.handle(
          _healsStatusMeta,
          healsStatus.isAcceptableOrUnknown(
              data['heals_status'], _healsStatusMeta));
    }
    if (data.containsKey('training_spend_time')) {
      context.handle(
          _trainingSpendTimeMeta,
          trainingSpendTime.isAcceptableOrUnknown(
              data['training_spend_time'], _trainingSpendTimeMeta));
    }
    if (data.containsKey('training_spend_calories')) {
      context.handle(
          _trainingSpendCaloriesMeta,
          trainingSpendCalories.isAcceptableOrUnknown(
              data['training_spend_calories'], _trainingSpendCaloriesMeta));
    }
    if (data.containsKey('trainings_done')) {
      context.handle(
          _trainingsDoneMeta,
          trainingsDone.isAcceptableOrUnknown(
              data['trainings_done'], _trainingsDoneMeta));
    }
    if (data.containsKey('user_weight_changes')) {
      context.handle(
          _userWeightChangesMeta,
          userWeightChanges.isAcceptableOrUnknown(
              data['user_weight_changes'], _userWeightChangesMeta));
    }
    if (data.containsKey('user_question1')) {
      context.handle(
          _userQuestion1Meta,
          userQuestion1.isAcceptableOrUnknown(
              data['user_question1'], _userQuestion1Meta));
    }
    if (data.containsKey('user_question2')) {
      context.handle(
          _userQuestion2Meta,
          userQuestion2.isAcceptableOrUnknown(
              data['user_question2'], _userQuestion2Meta));
    }
    if (data.containsKey('user_question3')) {
      context.handle(
          _userQuestion3Meta,
          userQuestion3.isAcceptableOrUnknown(
              data['user_question3'], _userQuestion3Meta));
    }
    if (data.containsKey('training_times_per_week')) {
      context.handle(
          _trainingTimesPerWeekMeta,
          trainingTimesPerWeek.isAcceptableOrUnknown(
              data['training_times_per_week'], _trainingTimesPerWeekMeta));
    }
    if (data.containsKey('is_settings_finished')) {
      context.handle(
          _isSettingsFinishedMeta,
          isSettingsFinished.isAcceptableOrUnknown(
              data['is_settings_finished'], _isSettingsFinishedMeta));
    }
    if (data.containsKey('is_subscription_bought')) {
      context.handle(
          _isSubscriptionBoughtMeta,
          isSubscriptionBought.isAcceptableOrUnknown(
              data['is_subscription_bought'], _isSubscriptionBoughtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TrainingsTable _trainings;
  $TrainingsTable get trainings => _trainings ??= $TrainingsTable(this);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  TrainingDao _trainingDao;
  TrainingDao get trainingDao =>
      _trainingDao ??= TrainingDao(this as MyDatabase);
  UserDao _userDao;
  UserDao get userDao => _userDao ??= UserDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [trainings, users];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TrainingDaoMixin on DatabaseAccessor<MyDatabase> {
  $TrainingsTable get trainings => attachedDatabase.trainings;
}
mixin _$UserDaoMixin on DatabaseAccessor<MyDatabase> {
  $UsersTable get users => attachedDatabase.users;
}

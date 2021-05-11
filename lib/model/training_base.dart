class TrainingBase {
  int id;
  String trainingName;
  int trainingHardness;

  List trainingStartExerciseIdsList;
  List trainingStartExerciseTimeList;

  int trainingMainExerciseFullTime;
  List trainingMainExerciseIdsList;
  List trainingMainExerciseTimeList;

  List trainingEndExerciseIdsList;
  List trainingEndExerciseTimeList;

  int restTime;

  int trainingCalories;

  TrainingBase(this.id,
      this.trainingName,
      this.trainingHardness,
      this.trainingStartExerciseIdsList,
      this.trainingStartExerciseTimeList,
      this.trainingMainExerciseFullTime,
      this.trainingMainExerciseIdsList,
      this.trainingMainExerciseTimeList,
      this.trainingEndExerciseIdsList,
      this.trainingEndExerciseTimeList,
      this.restTime,
      this.trainingCalories);
}
import 'exercise_base.dart';

class StaticExercisesList{

  static String getBodyPartsById(int id){
    var returnString = "";
    for (int i = 0 ; i < sExercisesList.length; i ++){
      if ( StaticExercisesList.sExercisesList[i].id == id ) {
       for ( int x = 0 ; x < StaticExercisesList.sExercisesList[i].exerciseBodyParts.length; x ++){
         StaticExercisesList.sExercisesList[i].exerciseBodyParts[x] == 1 ? returnString += (returnString == '' ? '' : " | ") + sExercisesBodyPartsList[x] : returnString += "";
       }
      }
    }
    return returnString;
  }

  static ExerciseBase getExerciseById(int id){
    for (int i = 0; i < sExercisesList.length; i ++){
      if (sExercisesList[i].id == id ) {
        return sExercisesList[i];
      }
    }
    return null;
  }

  static final sExercisesBodyPartsList = ['Chest', 'Hands', 'Shoulders', 'Press', 'Legs', 'Buttocks', 'Back'];

  static final List<ExerciseBase> sExercisesList = [
    ExerciseBase(	1,	"Diamond push-ups",	5,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	2,	"Kneeling diamond push-ups",	3,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	3,	"Explosive push-ups",	5,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	4,	"Bench dips",	3,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	5,	"Push-ups",	4,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	6,	"Incline push-ups",	3,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	7,	"Assisted push-ups",	1,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	8,	"One arm push-ups",	5,	[1,	1,	1,	0,	0,	0,	0],	"per arm"	),
    ExerciseBase(	10,	"Elevated push-ups",	5,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	11,	"Knee touch push-ups",	5,	[1,	1,	1,	0,	0,	0,	0],	"per side"	),
    ExerciseBase(	12,	"Wide grip push-ups",	3,	[1,	1,	1,	1,	0,	0,	0],	""	),
    ExerciseBase(	13,	"Wide grip incline push-ups",	2,	[1,	1,	1,	0,	0,	0,	0],	""	),
    ExerciseBase(	14,	"Side plank",	3,	[0,	0,	0,	1,	0,	1,	0],	"per side"	),
    ExerciseBase(	15,	"Bicycle",	3,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	16,	"Vertical scissors",	3,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	17,	"Side plank with hip dips",	4,	[0,	0,	0,	1,	0,	1,	0],	"per side"	),
    ExerciseBase(	18,	"Lateral leg raises",	4,	[0,	0,	0,	1,	0,	1,	0],	"per side"	),
    ExerciseBase(	19,	"One arm plank with rotations",	4,	[0,	0,	0,	1,	0,	1,	0],	"per side"	),
    ExerciseBase(	20,	"Reverse hip thrusts",	4,	[1,	1,	1,	1,	0,	0,	0],	""	),
    ExerciseBase(	21,	"Ab skiing",	4,	[1,	1,	1,	1,	1,	1,	0],	""	),
    ExerciseBase(	22,	"Heel touch",	1,	[0,	0,	0,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	23,	"Cross body crunches",	3,	[0,	0,	0,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	24,	"Scissors",	3,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	25,	"Bottoms-up",	4,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	26,	"Plank",	3,	[0,	0,	0,	1,	0,	1,	1],	""	),
    ExerciseBase(	27,	"One arm plank with knee touches",	3,	[0,	0,	1,	1,	1,	1,	0],	"per side"	),
    ExerciseBase(	28,	"Full extension plank",	1,	[1,	1,	1,	1,	0,	0,	0],	""	),
    ExerciseBase(	29,	"Plank jacks",	4,	[0,	0,	0,	1,	1,	1,	1],	""	),
    ExerciseBase(	30,	"Lying leg rotations",	4,	[0,	0,	0,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	31,	"Bend leg twists",	3,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	32,	"High-five crunches",	3,	[0,	0,	1,	1,	0,	0,	0],	""	),
    ExerciseBase(	33,	"Bent knee leg raises",	3,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	34,	"Sit-ups",	2,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	35,	"Lying leg raises",	3,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	36,	"Cross arm crunches",	4,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	37,	"Boat pose",	4,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	38,	"Unilateral lying leg raises",	4,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	39,	"Advanced lying leg raises",	4,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	40,	"Hello darlings",	3,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	41,	"Russian twists",	3,	[0,	0,	0,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	42,	"Mountain climber",	4,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	43,	"Crunches",	1,	[0,	0,	0,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	44,	"Oblique crunches",	3,	[0,	0,	0,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	45,	"Elevated leg crunches",	3,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	46,	"Raised leg crunches",	3,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	47,	"Abdominal cocoons",	3,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	48,	"Jumping leg tucks",	4,	[0,	0,	0,	1,	1,	1,	0],	""	),
    ExerciseBase(	49,	"V-ups",	5,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	50,	"V-twisting",	4,	[0,	0,	0,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	51,	"Reverse crunches with claps",	3,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	52,	"Plank star",	4,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	53,	"Plank with alternate leg lift",	3,	[0,	0,	0,	1,	0,	1,	0],	""	),
    ExerciseBase(	54,	"Static bicycle",	4,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	55,	"Straight arm side plank",	5,	[0,	1,	1,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	56,	"Seated bicycle crunch",	5,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	57,	"Pulse-Ups",	4,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	58,	"Side lunges",	4,	[0,	0,	0,	0,	1,	1,	0],	"per side"	),
    ExerciseBase(	59,	"Jump squats",	4,	[0,	0,	0,	0,	1,	1,	0],	""	),
    ExerciseBase(	60,	"Alternating jump lunges",	4,	[0,	0,	0,	0,	1,	1,	0],	"per leg"	),
    ExerciseBase(	61,	"Forward lunges",	3,	[0,	0,	0,	0,	1,	1,	0],	"per leg"	),
    ExerciseBase(	62,	"Backward lunges",	3,	[0,	0,	0,	0,	1,	1,	0],	"per leg"	),
    ExerciseBase(	63,	"Jumping lunges",	4,	[0,	0,	0,	0,	1,	1,	0],	""	),
    ExerciseBase(	64,	"Deep squats",	4,	[0,	0,	0,	0,	1,	1,	0],	""	),
    ExerciseBase(	65,	"Glute kickbacks",	3,	[0,	0,	0,	0,	0,	1,	0],	"per leg"	),
    ExerciseBase(	66,	"Single leg stiff legged deadlifts",	4,	[0,	0,	0,	0,	1,	1,	1],	"per leg"	),
    ExerciseBase(	67,	"Unilateral calf raises",	2,	[0,	0,	0,	0,	1,	0,	0],	""	),
    ExerciseBase(	68,	"Static squats",	3,	[0,	0,	0,	0,	1,	1,	0],	""	),
    ExerciseBase(	69,	"Forward Leaps",	5,	[0,	0,	0,	0,	1,	1,	0],	""	),
    ExerciseBase(	70,	"Vertical calf jumps",	3,	[0,	0,	0,	0,	1,	0,	0],	""	),
    ExerciseBase(	71,	"Glute bridge",	2,	[0,	0,	0,	0,	1,	1,	1],	""	),
    ExerciseBase(	73,	"Plié squat with knee ups",	4,	[0,	0,	0,	0,	1,	1,	0],	""	),
    ExerciseBase(	74,	"Backward lunges with forward kicks",	3,	[0,	0,	0,	0,	1,	1,	0],	"per leg"	),
    ExerciseBase(	75,	"Single leg glute bridge",	4,	[0,	0,	0,	0,	1,	1,	1],	"per leg"	),
    ExerciseBase(	77,	"Bulgarian split squats",	4,	[0,	0,	0,	0,	1,	1,	0],	"per leg"	),
    ExerciseBase(	78,	"High knees",	2,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	79,	"Burpees",	5,	[1,	1,	1,	1,	1,	1,	0],	""	),
    ExerciseBase(	80,	"Lateral burpees",	5,	[0,	0,	0,	1,	1,	1,	0],	""	),
    ExerciseBase(	84,	"Swinging high kicks",	1,	[0,	0,	0,	1,	1,	1,	0],	"per leg"	),
    ExerciseBase(	85,	"Forward lunge stretch",	1,	[0,	0,	0,	1,	1,	1,	0],	"per leg"	),
    ExerciseBase(	86,	"Lateral jumps",	4,	[0,	0,	0,	0,	1,	1,	0],	""	),
    ExerciseBase(	87,	"Squat reaches",	3,	[0,	0,	0,	0,	1,	1,	1],	"per side"	),
    ExerciseBase(	88,	"Standing lats stretch",	1,	[0,	0,	0,	0,	0,	0,	1],	"per side"	),
    ExerciseBase(	89,	"Standing toe touch",	1,	[0,	0,	0,	0,	1,	1,	1],	""	),
    ExerciseBase(	92,	"Cobra stretch",	1,	[0,	0,	0,	1,	0,	0,	0],	""	),
    ExerciseBase(	93,	"Child's pose",	1,	[0,	0,	0,	0,	0,	0,	1],	""	),
    ExerciseBase(	94,	"Jumping Jacks",	2,	[0,	0,	1,	0,	1,	1,	0],	""	),
    ExerciseBase(	95,	"Lying glute stretch",	1,	[0,	0,	0,	0,	0,	1,	0],	"per leg"	),
    ExerciseBase(	96,	"Lying hamstring stretch",	1,	[0,	0,	0,	0,	1,	1,	0],	"per leg"	),
    ExerciseBase(	97,	"Standing quadriceps stretch",	1,	[0,	0,	0,	0,	1,	0,	0],	"per leg"	),
    ExerciseBase(	98,	"Elevated standing toe touch",	1,	[0,	0,	0,	0,	1,	0,	0],	"per leg"	),
    ExerciseBase(	99,	"Standing behind the neck stretch",	1,	[0,	1,	0,	0,	0,	0,	0],	"per arm"	),
    ExerciseBase(	100,	"Superman",	2,	[0,	0,	1,	0,	1,	1,	0],	""	),
    ExerciseBase(	101,	"Reverse flutter kicks",	3,	[0,	0,	0,	0,	1,	1,	1],	""	),
    ExerciseBase(	102,	"Spiderman steps",	2,	[1,	1,	1,	1,	0,	0,	0],	""	),
    ExerciseBase(	103,	"Shadow-boxing while running in place",	2,	[0,	1,	1,	0,	1,	0,	0],	""	),
    ExerciseBase(	104,	"Lumberjack",	2,	[0,	1,	1,	1,	1,	0,	0],	"per side"	),
    ExerciseBase(	105,	"Side leg lifts",	2,	[0,	0,	0,	1,	1,	0,	0],	""	),
    ExerciseBase(	106,	"Plank walkups",	5,	[1,	1,	1,	1,	0,	0,	0],	""	),
    ExerciseBase(	107,	"Side leg raises",	1,	[0,	0,	0,	1,	0,	1,	0],	"per leg"	),
    ExerciseBase(	108,	"Star jumps",	4,	[0,	0,	0,	0,	1,	1,	0],	""	),
    ExerciseBase(	110,	"Calf raises",	1,	[0,	0,	0,	0,	1,	0,	0],	""	),
    ExerciseBase(	111,	"Elbow to knee sit-ups",	3,	[0,	0,	0,	1,	0,	0,	0],	"per side"	),
    ExerciseBase(	112,	"Standing knee flexions",	1,	[0,	0,	0,	0,	1,	0,	0],	"per leg"	),
    ExerciseBase(	113,	"Bent knee calf raises",	1,	[0,	0,	0,	0,	1,	0,	0],	"per leg"	),
    ExerciseBase(	114,	"Advanced bent knee leg raises",	4,	[0,	0,	0,	1,	0,	0,	0],	""	),
  ];

}
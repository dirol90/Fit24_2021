import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/exercise_base.dart';
import 'package:Fit24/model/static_exercises_list.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/circle_item.dart';
import 'package:flutter/material.dart';

import 'exercise_detailed_screen.dart';

class ExercisesListScreen extends StatefulWidget {
  static const String routName = '/ExercisesListScreen';

  @override
  _ExercisesListScreenState createState() => _ExercisesListScreenState();
}

class _ExercisesListScreenState extends State<ExercisesListScreen> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  var isSortedContainerOpened = false;
  List<bool> sortList1 = [true, true, true, true, true, ];
  List<bool> sortList2 = [true, true, true, true, true, true, true, ];

  var isShowVideo = false;
  var videoPath = '';
  @override
  Widget build(BuildContext context) {

    List<ExerciseBase> listExercisesSorted = StaticExercisesList.sExercisesList.sublist(0, StaticExercisesList.sExercisesList.length);

    listExercisesSorted.sort((a, b) => a.exerciseName.compareTo(b.exerciseName));

    if (!sortList1[0]) {listExercisesSorted.removeWhere((a) => a.exerciseHardness == 1);}
    if (!sortList1[1]) {listExercisesSorted.removeWhere((a) => a.exerciseHardness == 2);}
    if (!sortList1[2]) {listExercisesSorted.removeWhere((a) => a.exerciseHardness == 3);}
    if (!sortList1[3]) {listExercisesSorted.removeWhere((a) => a.exerciseHardness == 4);}
    if (!sortList1[4]) {listExercisesSorted.removeWhere((a) => a.exerciseHardness == 5);}

    sortBodyParts(sortList2, listExercisesSorted);


    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(top: 52.0*UIScaler.getUiScaleFactor(context)),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Exercises',
                textAlign: TextAlign.center,
                style: TextStyleBuilder.textStyleBuilder(16, 500, TextStyleColors.black, FontStyle.normal, context),
              ),
            ),
          ),
          Container(
            child: Padding(
            padding:  EdgeInsets.only(top: 28.0*UIScaler.getUiScaleFactor(context), right: 16, left: 16, bottom: 8),
            child:  Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: (){
                      setState(() {
                        isSortedContainerOpened = !isSortedContainerOpened;
                        if (isSortedContainerOpened) {_controller.animateTo(0,
                            curve: Curves.linear, duration: Duration (milliseconds: 500));}
                      });
                    },
                    child: Container(height : 56*UIScaler.getUiScaleFactor(context), width: 56*UIScaler.getUiScaleFactor(context), child: Padding(
                      padding: const EdgeInsets.only( right: 14, left : 14, top : 14 , bottom : 14),
                      child: Image.asset('assets/img/sort_icon.png',),
                    ))),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 82.0*UIScaler.getUiScaleFactor(context), right: 8, left: 8),
            child: Container(
              height: (MediaQuery.of(context).size.height - 140),
              child: Scrollbar(
                child: listExercisesSorted.length == 0 ?
                isSortedContainerOpened ? Container(child: Padding(padding: EdgeInsets.only(top: 0.0, right: 8, left: 8, bottom: 8), child: sorterContainer(context),),) : Container() :
                ListView.builder(
                  controller: _controller,
                  padding: EdgeInsets.only(
                      top: 0, left: 0, right: 0, bottom: 0),
                    itemCount: listExercisesSorted.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            isShowVideo = true;
                            videoPath = listExercisesSorted[index].id.toString();
                          });
//                          Navigator.of(context)
//                            ..push(MaterialPageRoute(
//                                builder: (BuildContext context) =>
//                                    ExerciseDetailed('video_${listExercisesSorted[index].id}')));
                        },
                        child: Column(
                          children: <Widget>[
                            isSortedContainerOpened && index == 0 ? Container(child: Padding(padding: EdgeInsets.only(top: 0.0, right: 8, left: 8, bottom: 8), child: sorterContainer(context),),) : Container(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 2, bottom: 2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F8),
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                ),
                                width: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: 60*UIScaler.getUiScaleFactor(context),
                                                  width: 60*UIScaler.getUiScaleFactor(context),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            'assets/img/${listExercisesSorted[index].id}.jpg')),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(4.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 0.0, left: 16.0),
                                                  child: Container(
                                                    width: 200*UIScaler.getUiScaleFactor(context),
                                                    height: 60*UIScaler.getUiScaleFactor(context),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container( width : 200*UIScaler.getUiScaleFactor(context), child: Text('${listExercisesSorted[index].exerciseName}',  style: TextStyleBuilder.textStyleBuilder(16, 400, TextStyleColors.black, FontStyle.normal, context), maxLines: 2, overflow: TextOverflow.ellipsis,)),
//                                                        Text('${StaticExercisesList.getBodyPartsById(listExercisesSorted[index].id)}', style: TextStyleBuilder.textStyleBuilder(9, 400, TextStyleColors.darkGrey, FontStyle.normal, context),),
                                                      ],),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 60*UIScaler.getUiScaleFactor(context),
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: <Widget>[
//                                                    Text('Level', style: TextStyleBuilder.textStyleBuilder(10, 400, TextStyleColors.violet, FontStyle.normal, context),),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 8, bottom: 6),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, listExercisesSorted[index].exerciseHardness >= 1 ? Color(0xFF1D1D1D): Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 6, left: 8),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, listExercisesSorted[index].exerciseHardness >= 2 ? Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 6, left: 8),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, listExercisesSorted[index].exerciseHardness >= 3 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 6, left: 8),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, listExercisesSorted[index].exerciseHardness >= 4 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 6, left: 8),
                                                      child: CustomPaint(
                                                          painter: DrawCircle(
                                                              3.0, listExercisesSorted[index].exerciseHardness >= 5 ?  Color(0xFF1D1D1D) : Color.fromRGBO(29, 29, 29, 0.4))),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
          isShowVideo ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(22, 22, 22, 0.90),
            child: ExerciseDetailed(vFileName: videoPath, f: disableVideoScreen),
          ) : Container()
        ],
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
  }

  Widget sorterContainer(BuildContext context){

    return Container(
      width: MediaQuery.of(context).size.width,
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0*UIScaler.getUiScaleFactor(context), top: 8*UIScaler.getUiScaleFactor(context), bottom: 8*UIScaler.getUiScaleFactor(context)),
              child: Text('Level', style: TextStyleBuilder.textStyleBuilder(14, 300, TextStyleColors.black, FontStyle.normal, context), textAlign: TextAlign.start,),
            ),
            Row(children: <Widget>[
              sortedBtn(context, 'Beginner', sortList1, 0),
              sortedBtn(context, 'New', sortList1, 1),
              sortedBtn(context, 'Medium', sortList1, 2),
            ],
            ),
            Row(children: <Widget>[
              sortedBtn(context, 'Pro', sortList1, 3),
              sortedBtn(context, 'Master', sortList1, 4),
            ],
            ),

          ],),
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0*UIScaler.getUiScaleFactor(context), top: 8*UIScaler.getUiScaleFactor(context), bottom: 8*UIScaler.getUiScaleFactor(context)),
              child: Text('Goal', style: TextStyleBuilder.textStyleBuilder(14, 300, TextStyleColors.black, FontStyle.normal, context),),
            ),
            Row(children: <Widget>[
              sortedBtn(context, 'Chest', sortList2, 0),
              sortedBtn(context, 'Hands' , sortList2, 1),
              sortedBtn(context, 'Shoulders' , sortList2, 2),


            ],
            ),
            Row(children: <Widget>[
              sortedBtn(context, 'Press' , sortList2, 3),
              sortedBtn(context, 'Legs' , sortList2, 4),
              sortedBtn(context, 'Buttocks' , sortList2, 5),


            ],
            ),
            Row(children: <Widget>[
              sortedBtn(context, 'Back' , sortList2, 6),
            ],
            ),
          ],),
        ],
      ),);
  }

  Widget sortedBtn(BuildContext context, String s, List list, int index)
  {
    return Padding(
      padding: EdgeInsets.all(4.0*UIScaler.getUiScaleFactor(context)),
      child: SizedBox(
        height: 32.0*UIScaler.getUiScaleFactor(context),
        child: RaisedButton(
          color: list[index] ? Color(0xFF1D1D1D) : Color(0xFFF6F6F8),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0*UIScaler.getUiScaleFactor(context)),
              side: BorderSide(color: Color(0xFF1D1D1D))),
          onPressed: () {
            setState(() {
              list[index] = !list[index];
            });
          },
          child: Row(
            children: <Widget>[
              Text(
                s,
                style: list[index] ? TextStyleBuilder.textStyleBuilder(12, 300, TextStyleColors.white, FontStyle.normal, context) : TextStyleBuilder.textStyleBuilder(12, 300, TextStyleColors.darkText, FontStyle.normal, context),
                textAlign: list[index] ? TextAlign.start : TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.0*UIScaler.getUiScaleFactor(context)),
                child: list[index] ? Icon(Icons.close, color: Colors.white, size: 12*UIScaler.getUiScaleFactor(context),) :  Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Function disableVideoScreen(){
    setState(() {
      isShowVideo = false;
    });
  }

  void sortBodyParts(List<bool> sortList2, List<ExerciseBase> listExercisesSorted){

    listExercisesSorted.removeWhere((a) {
        var isAnySelected = false;
        for (int j = 0; j < sortList2.length; j++){
          if (sortList2[j] && a.exerciseBodyParts[j] == 1) {isAnySelected = true;}
        }
        return !isAnySelected;
    });

  }
}

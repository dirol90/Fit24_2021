//import 'package:flutter/material.dart';
//
//import '../main.dart';
//
//class CustomCircleGroupWithText extends StatefulWidget {
//
//  var selectedWorkIndex = 5;
//
//  @override
//  _CustomCircleGroupWithTextState createState() => _CustomCircleGroupWithTextState();
//}
//
//class _CustomCircleGroupWithTextState extends State<CustomCircleGroupWithText> {
//
//  var isFirstInit = true;
//  List<bool> statusList;
//  List<Widget> wList;
//
//  @override
//  void initState() {
//  if (isFirstInit){
//    isFirstInit = false;
//    statusList = List();
//    for (int x = 0 ; x < 5 ; x ++ ){
//      statusList.add(false);
//    }
//  }
//    super.initState();
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//      wList  = List();
//
//      for (int x = 0 ; x < 5 ; x ++ ){
//        wList.add(GestureDetector(
//          onTap: () {
//            setState(() {
//              for(int i = 0; i < statusList.length; i++){
//                if (i != x){
//                  statusList[i] = false;
//                } else {
//                  MyApp.user.fitnessStyleIndex = i;
//                  widget.selectedWorkIndex = i;
//                  statusList[i] = true;
//                  print(widget.selectedWorkIndex);
//                }
//              }
//            });
//          },
//          child: Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: ClipOval(
//              child: SizedBox(
//                width: 24,
//                height: 24,
//                child: Container(
//                  decoration: new BoxDecoration(
//                    color: statusList[x] ? Theme.of(context).accentColor : Theme.of(context).backgroundColor,
//                    border: Border.all(
//                        width: 2,
//                        color: Theme
//                            .of(context)
//                            .accentColor ??
//                            Theme
//                                .of(context)
//                                .accentColor),
//                    borderRadius: new BorderRadius.circular(100),
//                  ),
//                  child: Center(child: Text((x+1).toString(), style: statusList[x] ? Theme.of(context).textTheme.button : Theme.of(context).textTheme.subhead,)),
//                ),
//              ),
//            ),
//          ),
//        ));
//      }
//
//    return Row(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        ...wList
//      ],
//    );
//  }
//}

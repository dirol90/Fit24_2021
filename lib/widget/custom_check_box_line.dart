//import 'package:Fit24/widget/rounded_check_box.dart';
//import 'package:flutter/material.dart';
//
//class CustomCheckBoxLine extends StatefulWidget {
//  int totalPosCount;
//  int selectedItemIndex;
//  Function refresh;
//
//  get(){
//    return selectedItemIndex;
//  }
//
//  CustomCheckBoxLine(int totalPosCount, int i, Function refresh) {
//    this.totalPosCount = totalPosCount;
//    this.selectedItemIndex = i;
//    this.refresh = refresh;
//  }
//
//  @override
//  _CustomCheckBoxLineState createState() => _CustomCheckBoxLineState();
//}
//
//class _CustomCheckBoxLineState extends State<CustomCheckBoxLine> {
//  var selectedBtnIndex;
//  var isFirstRun = true;
//  List<Widget> lv = [];
//
//  @override
//  void initState() {
//    if (isFirstRun) {
//      isFirstRun = false;
//      selectedBtnIndex = widget.selectedItemIndex;
//    }
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    selectedBtnIndex = widget.selectedItemIndex;
//    for (int i = 0; i < widget.totalPosCount; i++) {
//      lv.add(Container(
//          width: i == widget.totalPosCount - 1
//              ? 25
//              : MediaQuery.of(context).size.width / widget.totalPosCount - 1,
//          child: Row(
//            children: <Widget>[
//              CircleCheckbox(
//                value: selectedBtnIndex == i ? true : false,
//                checkColor: Theme.of(context).accentColor,
//                onChanged: (bool b) {
//                  selectedBtnIndex = i ; print('b $i'); lv = []; setState(() {
//                  });  widget.selectedItemIndex = selectedBtnIndex;
//                  print('b99 ${widget.selectedItemIndex}'); widget.refresh();},
//              ),
//              i != widget.totalPosCount - 1
//                  ? Expanded(
//                      flex: 1,
//                      child: Divider(
//                        height: 2,
//                        color: Theme.of(context).accentColor,
//                      ),
//                    )
//                  : Expanded(
//                      flex: 1,
//                      child: Divider(
//                        height: 2,
//                        color: Theme.of(context).backgroundColor,
//                      ),
//                    ),
//            ],
//          )));
//    }
//
//    return Container(
//      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[...lv],
//      ),
//    );
//  }
//}

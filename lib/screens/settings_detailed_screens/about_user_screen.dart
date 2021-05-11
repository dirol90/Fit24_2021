
import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/custom_select_box.dart';
import 'package:Fit24/widget/my_cupertino_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class AboutUserSettingDetailedScreen extends StatefulWidget {
  static const String routName = '/AboutUserSettingDetailedScreen';

  final Function f;
  AboutUserSettingDetailedScreen({this.f});

  @override
  _AboutUserSettingDetailedScreenState createState() => _AboutUserSettingDetailedScreenState();

}

class _AboutUserSettingDetailedScreenState extends State<AboutUserSettingDetailedScreen> {

  final myController = TextEditingController();

  UserDao _u_dao;

  List<String> weightValues;
  List<String> heightValues;

  var weightValuesIndex = 15;
  var heightValuesIndex = 30;


  var selectedWeightParam = 0;
  var selectedHeightParam = 0;

  List<int> weightListItems;
  List<int>  heightListItems;
  var heightListBritanicItems;

  var selector1;
  var selector2;

  User user;

  bool isSaveBtnActive = true;
  var lastTimestampOfToastShow = 0;

  @override
  void initState() {
    weightListItems = new List();
    heightListItems = new List();
    heightListBritanicItems = new List();

    for (int x = 30; x < 300; x++) {
      weightListItems.add(x);
    }

    for (int x = 120; x < 260; x++) {
      heightListItems.add(x);
      if (!heightListBritanicItems.contains('${x * 0.393701 ~/ 12}\' ${(x * 0.393701 % 12).toStringAsFixed(0)}\"')) {heightListBritanicItems.add('${x * 0.393701 ~/ 12}\' ${(x * 0.393701 % 12).toStringAsFixed(0)}\"');}
    }

    myController.addListener(_printLatestValue);
    super.initState();
  }

  _printLatestValue() {
    user = user.copyWith(name: myController.text);
    if (myController.text ==''){
      setState(() {
        isSaveBtnActive = false;
      });
    } else {
      setState(() {
        isSaveBtnActive = true;
      });
    }
  }

  Function updateParent(int paramSelector) {
    setState(() {
      if (paramSelector == 0) {
        user = user.copyWith(weightMeasure: selector1.selectedItemIndex);
        selectedWeightParam = selector1.selectedItemIndex;
      }
      if (paramSelector == 1) {
        user = user.copyWith(heightMeasure: selector2.selectedItemIndex);
        selectedHeightParam = selector2.selectedItemIndex;
      }
    });

  }


  @override
  Widget build(BuildContext context) {

    if (_u_dao == null ) {
      _u_dao = Provider.of<UserDao>(context);
    }


    weightValues = [ DemoLocalizations.of(context).kg, DemoLocalizations.of(context).lb];
    heightValues = [ DemoLocalizations.of(context).cm, DemoLocalizations.of(context).inc];

    if(user != null) {
      selectedWeightParam = user.weightMeasure;
      selectedHeightParam = user.heightMeasure;

      selector1 = CustomSelectBoxWidget(
          user,
          weightValues,
          user.weightMeasure,
          updateParent, 0);
      selector2 = CustomSelectBoxWidget(
          user,
          heightValues,
          user.heightMeasure,
          updateParent, 1);

      if (myController.text.isEmpty){
        myController.text = user.name == '' ? '' : user.name;
        weightValuesIndex = double.parse(user.weightIndex).toInt();
        heightValuesIndex = double.parse(user.heightIndex).toInt();
      }
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffFF6B4A), // screens.navigation bar color
      statusBarColor: Color(0xffFF6B4A), // status bar color
    ));

    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Padding(
            padding: EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 52*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context)),
            child: StreamBuilder(

                stream: _u_dao.watchAllUsers(),
                builder: (context, AsyncSnapshot<List<User>> snapshot) {

                  final users = snapshot.data ?? List();
                  if (user == null ){ user = users.length > 0 ? users[0] : null;
                  SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {

                  }));}

                  return user != null ?  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 0, right: 8, bottom: 0*UIScaler.getUiScaleFactor(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(onTap: (){widget.f(0);}, child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                            )),
                            GestureDetector(onTap: (){
                              if(isSaveBtnActive){
                                _u_dao.calculateUserParams(user).then((_){
                              widget.f(0);
                            });} else {
                                if (DateTime.now().millisecondsSinceEpoch - lastTimestampOfToastShow > 2000){
                                  lastTimestampOfToastShow = DateTime.now().millisecondsSinceEpoch;
                                  Fluttertoast.showToast(
                                      msg: "Please fill in name field",
                                      toastLength: Toast
                                          .LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Color(
                                          0xFF666666),
                                      textColor: Colors.white,
                                      fontSize: 12.0
                                  );
                                }

                              }}, child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Save', style: TextStyleBuilder.textStyleBuilder(16, 400, isSaveBtnActive ? TextStyleColors.orange : TextStyleColors.grey, FontStyle.normal, context),),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        height: 100*UIScaler.getUiScaleFactor(context),
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 0, bottom: 10),
                                  child: Text(
                                    'Name',
                                    style: TextStyleBuilder.textStyleBuilder(18, 600, TextStyleColors.black, FontStyle.normal, context),
                                  ),
                                ),

                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width - 32,
                                  child: MyCupertinoTextField(
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.sentences,
                                    placeholder: DemoLocalizations.of(context).setName,
                                    expands: true,
                                    maxLines: null,
                                    minLines: null,
                                    padding: const EdgeInsets.all(8.0),
                                    style: TextStyle(color: Colors.black),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      border: Border.all(
                                        color: Color(0xFFC1C1CB),
                                        width: 1, //                   <--- border width here
                                      ),
                                    ),
                                    textInputAction: TextInputAction.done,
                                    controller: myController,
                                  ),),

                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5 * 2,
                            height: MediaQuery.of(context).size.width / 5 * 2 / 3.2,
                            child: RaisedButton(
                                color: user.sexIndex == 0  ? Theme.of(context).accentColor : Color(0xffF6F6F8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  side: BorderSide(
                                    color: user.sexIndex == 0  ? Theme.of(context).accentColor : Color(0xffF6F6F8),),),
                                onPressed: () {
                                  setState(() {
                                    user = user.copyWith(sexIndex: 0);
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(user.sexIndex == 0  ? 'assets/img/woman_pressed_img.png' : 'assets/img/woman_unpressed_img.png', height: 35, width: 35,),
                                    Text(
                                      "Woman",
                                      style: user.sexIndex == 0  ? TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.white, FontStyle.normal, context) : TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.grey, FontStyle.normal, context),
                                    ),
                                  ],)
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5 * 2,
                            height: MediaQuery.of(context).size.width / 5 * 2 / 3.2,
                            child: RaisedButton(
                                color: user.sexIndex == 1 ? Theme.of(context).accentColor : Color(0xffF6F6F8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(
                                        color: user.sexIndex == 1  ? Theme.of(context).accentColor : Color(0xffF6F6F8))),
                                onPressed: () {
                                  setState(() {
                                    user = user.copyWith(sexIndex: 1);
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(user.sexIndex == 1 ? 'assets/img/man_pressed_img.png' : 'assets/img/man_unpressed_img.png', height: 35, width: 35,),
                                    Text(
                                      "Man",
                                      style: user.sexIndex == 1 ? TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.white, FontStyle.normal, context) : TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.grey, FontStyle.normal, context),
                                    ),
                                  ],)
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 35, 16, 12.5),
                        child: Row(
                          children: <Widget>[
                            Text(
                                'Date of birth',
                                style: TextStyleBuilder.textStyleBuilder(18, 600, TextStyleColors.black, FontStyle.normal, context)
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                        height: 400*UIScaler.getUiScaleFactor(context),
                                        child: CupertinoDatePicker(
                                          initialDateTime: user.bd,
                                          onDateTimeChanged: (DateTime newdate) {
                                            user = user.copyWith(bd: newdate);
                                            setState(() {});
                                          },
                                          use24hFormat: true,
                                          maximumDate:
                                          DateTime(DateTime.now().year, 12, 30),
                                          minimumYear: 1930,
                                          maximumYear: DateTime.now().year,
                                          mode: CupertinoDatePickerMode.date,
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                  "${user.bd.month.toString().padLeft(2, '0')}.${user.bd.day.toString().padLeft(2, '0')}.${user.bd.year.toString()}",
                                  style: TextStyleBuilder.textStyleBuilder(18, 400, TextStyleColors.orange, FontStyle.normal, context)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12.5, 16, 12.5),
                        child: Row(
                          children: <Widget>[
                            Text(
                                'Weight',
                                style: TextStyleBuilder.textStyleBuilder(16, 400, TextStyleColors.black, FontStyle.normal, context)
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                              child: selector1,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                        height: 200*UIScaler.getUiScaleFactor(context),
                                        child: CupertinoPicker(
                                            itemExtent: 35,
                                            onSelectedItemChanged: (int index) {
                                              setState(() {
                                                weightValuesIndex = index;
                                                user =  user.copyWith(weightIndex: index.toString());
//                                            user.we
//                                            userWeightIndex = index;
                                              });
                                            },
                                            children: new List<Widget>.generate(
                                                weightListItems.length, (int index) {
                                              return new Center(
                                                child: new Text((selectedWeightParam ==
                                                    0
                                                    ? weightListItems[index]
                                                    .toString()
                                                    : (weightListItems[index] *
                                                    2.2046)
                                                    .round()
                                                    .toString()) +
                                                    weightValues[selectedWeightParam], style: TextStyleBuilder.textStyleBuilder(24, 400, TextStyleColors.black, FontStyle.normal, context),),
                                              );
                                            }),
                                      scrollController: FixedExtentScrollController(initialItem: weightValuesIndex),),
                                      );
                                    });
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      weightListItems.length == 0
                                          ? '0'
                                          : selectedWeightParam == 1
                                          ? (weightListItems[double.parse(user.weightIndex).toInt()] *
                                          2.2046)
                                          .round()
                                          .toString()
                                          : weightListItems[double.parse(user.weightIndex).toInt()]
                                          .toString(),
                                      style: TextStyleBuilder.textStyleBuilder(18, 400, TextStyleColors.orange, FontStyle.normal, context)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12.5, 16, 12.5),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return Container(
                                    height: 200*UIScaler.getUiScaleFactor(context),
                                    child: CupertinoPicker(
                                        itemExtent: 35,
                                        onSelectedItemChanged: (int index) {
                                          setState(() {
                                            selectedHeightParam == 0 ? heightValuesIndex = index : heightValuesIndex = ((index * (heightListItems.length / heightListBritanicItems.length)).toInt()+1);
                                            user = user.copyWith(heightIndex: selectedHeightParam == 0 ? index.toString() : ((index * (heightListItems.length / heightListBritanicItems.length)).toInt()+1).toString());
                                          });
                                        },
                                        children: new List<Widget>.generate(
                                            selectedHeightParam == 0 ? heightListItems.length : heightListBritanicItems.length, (int index) {
                                          return new Center(
                                            child: new Text((selectedHeightParam == 0
                                                ? heightListItems[index].toString()
                                                : '${heightListBritanicItems[index].toString()}'
                                            ) , style: TextStyleBuilder.textStyleBuilder(24, 400, TextStyleColors.black, FontStyle.normal, context),),
                                          );
                                        }),
                                      scrollController: FixedExtentScrollController(initialItem: selectedHeightParam == 0 ? heightValuesIndex : (heightValuesIndex / (heightListItems.length / heightListBritanicItems.length)) < heightListBritanicItems.length ? (heightValuesIndex / (heightListItems.length / heightListBritanicItems.length)).toInt() : heightListBritanicItems.length),),
                                  );
                                });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                  'Height',
                                  style: TextStyleBuilder.textStyleBuilder(16, 400, TextStyleColors.black, FontStyle.normal, context)
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                child: selector2,
                              ),
                              Spacer(),
                              Row(
                                children: <Widget>[
                                  Text(
                                      heightListItems.length == 0
                                          ? heightListItems[double.parse(user.heightIndex).toInt()]
                                          : selectedHeightParam == 1
                                          ? '${heightListBritanicItems[(double.parse(user.heightIndex).toInt() / (heightListItems.length / heightListBritanicItems.length)) < heightListBritanicItems.length ? (double.parse(user.heightIndex).toInt()/ (heightListItems.length / heightListBritanicItems.length)).toInt() : heightListBritanicItems.length]}'
                                          : heightListItems[double.parse(user.heightIndex).toInt()]
                                          .toString(),
                                      style: TextStyleBuilder.textStyleBuilder(18, 400, TextStyleColors.orange, FontStyle.normal, context)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ) : Container();}
            )),
      ),
    );
  }

}

import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/data/moor_user_database.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/custom_select_box.dart';
import 'package:Fit24/widget/my_cupertino_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class UserQuestionnaireScreen0 extends StatefulWidget {
  static const String routName = '/UserQuestionnaireScreen0';
  final Function f;

  UserQuestionnaireScreen0({this.f});

  @override
  _UserQuestionnaireScreen0State createState() =>
      _UserQuestionnaireScreen0State();
}

class _UserQuestionnaireScreen0State extends State<UserQuestionnaireScreen0> {
  UserDao _u_dao;
  
  final myController = TextEditingController();
  var isShowHintName = true;

  List<String> weightValues;
  List<String> heightValues;

  var weightValuesIndex = 15;
  var heightValuesIndex = 30;

  var selectedWeightParam = 0;
  var selectedHeightParam = 0;

  final weightListItems = List();
  final heightListItems = List();
  final heightListBritanicItems = List();

  var selector1;
  var selector2;

  @override
  void initState() {

    for (int x = 30; x < 300; x++) {
      weightListItems.add(x);
    }

    for (int x = 120; x < 260; x++) {
      heightListItems.add(x);
      if (!heightListBritanicItems.contains('${x * 0.393701 ~/ 12}\' ${(x * 0.393701 % 12).toStringAsFixed(0)}\"')) {heightListBritanicItems.add('${x * 0.393701 ~/ 12}\' ${(x * 0.393701 % 12).toStringAsFixed(0)}\"');}
    }

    myController.addListener(_printLatestValue);
    UserRegistrationController.user != null ?  UserRegistrationController.user.name == '' ? myController.text = '' : myController.text = UserRegistrationController.user.name : UserRegistrationController.user = UserRegistrationController.user;

    UserRegistrationController.user != null ? selectedWeightParam = UserRegistrationController.user.weightMeasure : 0;
    UserRegistrationController.user != null ? selectedHeightParam = UserRegistrationController.user.heightMeasure : 0;
    super.initState();
  }


  _printLatestValue() {
    if (myController.text == ''){
      isShowHintName = true;
      setState(() {
      });
    } else {
      isShowHintName = false;
      setState(() {
      });
    }

    UserRegistrationController.user =  UserRegistrationController.user.copyWith(name: capitalizeFirstLetter(myController.text));
    _u_dao.updateUser(UserRegistrationController.user);

  }

  String capitalizeFirstLetter(String s) =>
      (s?.isNotEmpty ?? false) ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    //SystemChrome.setEnabledSystemUIOverlays([]);
    if (_u_dao == null ) {
      _u_dao = Provider.of<UserDao>(context);
    }

    weightValues = [ DemoLocalizations.of(context).kg, DemoLocalizations.of(context).lb];
    heightValues = [ DemoLocalizations.of(context).cm, DemoLocalizations.of(context).inc];


    if (UserRegistrationController.user != null ) {

//      print('STAT ${UserRegistrationController.user.weightMeasure} ${UserRegistrationController.user.heightMeasure}');

      selector1 = CustomSelectBoxWidget(
          UserRegistrationController.user,
          weightValues,
          UserRegistrationController.user.weightMeasure,
          updateParent, 0);
      selector2 = CustomSelectBoxWidget(
          UserRegistrationController.user,
          heightValues,
          UserRegistrationController.user.heightMeasure,
          updateParent, 1);



      return Scaffold(
        body: Container(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: EdgeInsets.only(top: 8*UIScaler.getUiScaleFactor(context)),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 1,
                itemBuilder: (_, index) {

                  return Padding(
                      padding: EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 0, 16, 16*UIScaler.getUiScaleFactor(context)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 116*UIScaler.getUiScaleFactor(context),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0*UIScaler.getUiScaleFactor(context), top: 16*UIScaler.getUiScaleFactor(context), bottom: 10*UIScaler.getUiScaleFactor(context)),
                                      child: Text(
                                        DemoLocalizations.of(context).name,
                                        style: TextStyleBuilder.textStyleBuilder(18, 600, TextStyleColors.black, FontStyle.normal, context),
                                      ),
                                    ),

                                    Container(
                                      height: 50,
                                      width: (MediaQuery.of(context).size.width - 36),
                                      child: MyCupertinoTextField(
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.sentences,
                                      placeholder: DemoLocalizations.of(context).setName,
                                        expands: true,
                                        maxLines: null,
                                        minLines: null,
                                        padding: EdgeInsets.all(8.0*UIScaler.getUiScaleFactor(context)),
                                        style: TextStyle(color: Colors.orange),
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius: BorderRadius.all(Radius.circular(4.0*UIScaler.getUiScaleFactor(context))),
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
                                width: (MediaQuery.of(context).size.width / 5 * 2.1),
                                height: (MediaQuery.of(context).size.width / 5 * 2 / 3.2),
                                child: RaisedButton(
                                    color: UserRegistrationController.user.sexIndex == 0 ? Theme.of(context).accentColor : Color(0xffF6F6F8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0*UIScaler.getUiScaleFactor(context)),
                                      side: BorderSide(
                                        color: UserRegistrationController.user.sexIndex == 0 ? Theme.of(context).accentColor : Color(0xffF6F6F8),),),
                                    onPressed: () {
                                      setState(() {
                                        UserRegistrationController.user =  UserRegistrationController.user.copyWith(sexIndex: 0);
                                        _u_dao.updateUser(UserRegistrationController.user);
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                      Image.asset(UserRegistrationController.user.sexIndex == 0 ? 'assets/img/woman_pressed_img.png' : 'assets/img/woman_unpressed_img.png', height: 32*UIScaler.getUiScaleFactor(context), width: 32*UIScaler.getUiScaleFactor(context),),
                                      Text(
                                        DemoLocalizations.of(context).woman,
                                        style: UserRegistrationController.user.sexIndex == 0 ? TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.white, FontStyle.normal, context) : TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.grey, FontStyle.normal, context),
                                      ),
                                    ],)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: SizedBox(
                                  width: (MediaQuery.of(context).size.width / 5 * 2.1),
                                  height: (MediaQuery.of(context).size.width / 5 * 2 / 3.2),
                                  child: RaisedButton(
                                      color: UserRegistrationController.user.sexIndex == 1 ? Theme.of(context).accentColor : Color(0xffF6F6F8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0*UIScaler.getUiScaleFactor(context)),
                                          side: BorderSide(
                                              color: UserRegistrationController.user.sexIndex == 1 ? Theme.of(context).accentColor : Color(0xffF6F6F8))),
                                      onPressed: () {
                                        setState(() {
                                          UserRegistrationController.user = UserRegistrationController.user.copyWith(sexIndex: 1);
                                          _u_dao.updateUser(UserRegistrationController.user);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                        Image.asset(UserRegistrationController.user.sexIndex == 1 ? 'assets/img/man_pressed_img.png' : 'assets/img/man_unpressed_img.png', height: 32*UIScaler.getUiScaleFactor(context), width: 32*UIScaler.getUiScaleFactor(context),),
                                        Text(
                                          DemoLocalizations.of(context).man,
                                          style: UserRegistrationController.user.sexIndex == 1 ? TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.white, FontStyle.normal, context) : TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.grey, FontStyle.normal, context),
                                        ),
                                      ],)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 35*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context), 12.5*UIScaler.getUiScaleFactor(context)),
                            child: Row(
                              children: <Widget>[
                                Text(
                                    DemoLocalizations.of(context).bd,
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
                                            child: Center(
                                              child: CupertinoDatePicker(
                                                initialDateTime: DateTime(1990, 01, 01),
                                                onDateTimeChanged: (DateTime newdate) {
                                                  UserRegistrationController.user =   UserRegistrationController.user.copyWith(bd: newdate);
                                                  _u_dao.updateUser(UserRegistrationController.user);
                                                  setState(() {});
                                                },
                                                use24hFormat: true,
                                                maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                                minimumYear: 1949,
                                                maximumYear: DateTime.now().year,
                                                mode: CupertinoDatePickerMode.date,
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                      "${UserRegistrationController.user.bd.month.toString().padLeft(2, '0')}.${UserRegistrationController.user.bd.day.toString().padLeft(2, '0')}.${UserRegistrationController.user.bd.year.toString()}",
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
                                    DemoLocalizations.of(context).weight,
                                    style: TextStyleBuilder.textStyleBuilder(16, 300, TextStyleColors.black, FontStyle.normal, context)
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

                                                itemExtent: 32.0,
                                                onSelectedItemChanged: (int index) {
                                                  setState(() {
                                                    weightValuesIndex = index;
                                                    UserRegistrationController.user = UserRegistrationController.user.copyWith(weightIndex: index.toString());
                                                    _u_dao.updateUser(UserRegistrationController.user);
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
                                              scrollController: FixedExtentScrollController(initialItem: weightValuesIndex),
                                            ),
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          weightListItems.length == 0
                                              ? weightListItems[double.parse(UserRegistrationController.user.weightIndex).toInt()]
                                              : selectedWeightParam == 1
                                              ? (weightListItems[double.parse(UserRegistrationController.user.weightIndex).toInt()] *
                                              2.2046)
                                              .round()
                                              .toString()
                                              : weightListItems[double.parse(UserRegistrationController.user.weightIndex).toInt()]
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
                                            itemExtent: 32.0,
                                            onSelectedItemChanged: (int index) {
                                              setState(() {
                                                selectedHeightParam == 0 ? heightValuesIndex = index : heightValuesIndex = ((index * (heightListItems.length / heightListBritanicItems.length)).toInt()+1);
                                                UserRegistrationController.user = UserRegistrationController.user.copyWith(heightIndex: selectedHeightParam == 0 ? index.toString() : ((index * (heightListItems.length / heightListBritanicItems.length)).toInt()+1).toString());
                                                _u_dao.updateUser(UserRegistrationController.user);
                                              });
                                            },
                                            children: new List<Widget>.generate(
                                                selectedHeightParam == 0 ? heightListItems.length : heightListBritanicItems.length, (int index) {
                                              return new Center(
                                                child: new Text(
                                                  (selectedHeightParam == 0
                                                      ? '${heightListItems[index].toString()} ${heightValues[selectedHeightParam]}'
                                                      : '${heightListBritanicItems[index].toString()}'
                                                  ), style: TextStyleBuilder.textStyleBuilder(24, 400, TextStyleColors.black, FontStyle.normal, context),),
                                              );
                                            }),
                                          scrollController: FixedExtentScrollController(initialItem: selectedHeightParam == 0 ? heightValuesIndex : (heightValuesIndex / (heightListItems.length / heightListBritanicItems.length)) < heightListBritanicItems.length ? (heightValuesIndex / (heightListItems.length / heightListBritanicItems.length)).toInt() : heightListBritanicItems.length),),
                                      );
                                    });
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      DemoLocalizations.of(context).height,
                                      style: TextStyleBuilder.textStyleBuilder(16, 300, TextStyleColors.black, FontStyle.normal, context)
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
                                              ? heightListItems[double.parse(UserRegistrationController.user.heightIndex).toInt()]
                                              : selectedHeightParam == 1
                                              ? '${heightListBritanicItems[(double.parse(UserRegistrationController.user.heightIndex).toInt() / (heightListItems.length / heightListBritanicItems.length)) < heightListBritanicItems.length ? (double.parse(UserRegistrationController.user.heightIndex).toInt()/ (heightListItems.length / heightListBritanicItems.length)).toInt() : heightListBritanicItems.length]}'
                                              : heightListItems[double.parse(UserRegistrationController.user.heightIndex).toInt()]
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
                      ),
                  );
                },
              ),
            ),
        ),
      );
    } else {
      return Container();
    }
  }

  Function updateParent(int paramSelector) {
    setState(() {
      if (paramSelector == 0) {
        selectedWeightParam = selector1.selectedItemIndex;
      }
      if (paramSelector == 1) {
        selectedHeightParam = selector2.selectedItemIndex;
      }
    });
  }

  @override
  void dispose() {
//    myController.dispose();
    super.dispose();
  }

}

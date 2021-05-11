import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/data/moor_user_database.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSelectBoxWidget extends StatefulWidget {

  User user;
  List<String> names;
  int selectedItemIndex;
  Function updateParent;
  int paramSelecror;



  get(){
    return selectedItemIndex;
  }

  CustomSelectBoxWidget(User user, List<String> weightValues, int i, Function updateParent, int paramSelecror) {this.user = user; this.names = weightValues; this.selectedItemIndex = i; this.updateParent = updateParent; this.paramSelecror = paramSelecror;}


  @override
  _CustomSelectBoxWidgetState createState() => _CustomSelectBoxWidgetState();

}

class _CustomSelectBoxWidgetState extends State<CustomSelectBoxWidget> {
  UserDao _u_dao;
  var isFirstRun= true;
  var selectedBtnIndex = 0;

  @override
  void initState() {
    if (isFirstRun){
      isFirstRun= false;
      selectedBtnIndex = widget.selectedItemIndex;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (_u_dao == null  ) {
      _u_dao = Provider.of<UserDao>(context);
    }

    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 52.0,
            height: 28.0,
            child: RaisedButton(
              color: selectedBtnIndex == 0
                  ? Theme.of(context).accentColor
                  : Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0)),
                side:
                BorderSide(width: 2, color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                setState(() async {
                  selectedBtnIndex = 0;
                  widget.selectedItemIndex = 0;

                  if (widget.paramSelecror == 0 ){
                    UserRegistrationController.user = widget.user.copyWith(weightMeasure: selectedBtnIndex);
                    await _u_dao.updateUser(widget.user);
                  } else {
                    UserRegistrationController.user = widget.user.copyWith(heightMeasure: selectedBtnIndex);
                    await _u_dao.updateUser(widget.user);
                  }

                  widget.updateParent(widget.paramSelecror);
                });
              },
              child: Text(widget.names[0],
                  style: selectedBtnIndex == 0
                      ? TextStyle(
                      fontSize: 13.0*UIScaler.getUiScaleFactor(context),
                      fontWeight: FontWeight.normal,
                      color: Color(0xffFFFFFF))
                      : TextStyle(
                      fontSize: 13.0*UIScaler.getUiScaleFactor(context),
                      fontWeight: FontWeight.normal,
                      color: Color(0xffFF6B4A))),
            ),
          ),
          SizedBox(
            width: 52.0,
            height: 28.0,
            child: RaisedButton(
              color: selectedBtnIndex == 1
                  ? Theme.of(context).accentColor
                  : Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0)),
                side:
                BorderSide(width: 2, color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                setState(() async {
                  selectedBtnIndex = 1;
                  widget.selectedItemIndex = 1;

                  if (widget.paramSelecror == 0 ){
                    UserRegistrationController.user = widget.user.copyWith(weightMeasure: selectedBtnIndex);
                    await _u_dao.updateUser(widget.user);
                  } else {
                    UserRegistrationController.user = widget.user.copyWith(heightMeasure: selectedBtnIndex);
                    await _u_dao.updateUser(widget.user);
                  }

                  widget.updateParent(widget.paramSelecror);

                });
              },
              child: Text(widget.names[1],
                  style: selectedBtnIndex == 1
                      ? TextStyle(
                      fontSize: 14.0*UIScaler.getUiScaleFactor(context),
                      fontWeight: FontWeight.normal,
                      color: Color(0xffFFFFFF))
                      : TextStyle(
                      fontSize: 14.0*UIScaler.getUiScaleFactor(context),
                      fontWeight: FontWeight.normal,
                      color: Color(0xffFF6B4A))),
            ),
          ),
        ],
      ),
    );
  }
}

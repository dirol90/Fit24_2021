import 'dart:async';
import 'dart:io' show Platform;

import 'package:Fit24/dao/app_dao.dart';
import 'package:Fit24/screens/screeen_holder/user_registration_holder.dart';
import 'package:Fit24/subscription_helper.dart';
import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/screens/introduction_screens/splash_screen.dart';
import 'package:Fit24/screens/screeen_holder/screen_main_holder.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UserSubscriptionScreen5 extends StatefulWidget {
  static const String routName = '/UserSubscriptionScreen5';
  static var isColdBoot = true;
  final Function f;
  UserSubscriptionScreen5({this.f});

  @override
  _UserSubscriptionScreen5State createState() =>
      _UserSubscriptionScreen5State();
}



var selectedSubscriptionIndex = 0;
var lastSelectedIndex = 0;

var imagesList = [
  'assets/img/galery_sample_1.png',
  'assets/img/galery_sample_2.png',
  'assets/img/galery_sample_3.png'
];

var textList = [
  'More than 300 workouts\n with over 100 exercises.',
  'All training materials\n are created by ISSA\n certified instructors.',
  'Customized training plan\n based on your goals\n and abilities.'
];

Container image;
Container text;

class _UserSubscriptionScreen5State extends State<UserSubscriptionScreen5> {


  @override
  void dispose() async{
    super.dispose();

  }

  bool loadOnce = true;
  bool toastShowOnce = false;
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;

  bool isShowProgress = false;
  UserDao _u_dao;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

//    setState(() {
//      isShowProgress = false;
//    });

    //SystemChrome.setEnabledSystemUIOverlays([]);

//    if (Platform.isIOS){
//    _purchaseErrorSubscription == null ? _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
//      if (!toastShowOnce){
//
//        print('purchase-error: $purchaseError || ${purchaseError.code} || ${purchaseError.debugMessage} || ${purchaseError.responseCode} || ${purchaseError.toJson()}');
//        Fluttertoast.showToast(
//            msg: "Error, please try again",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIos: 1,
//            backgroundColor: Colors.grey,
//            textColor: Colors.black,
//            fontSize: 12.0
//        );
//
//        toastShowOnce = true;
//      }
//    }) : _purchaseErrorSubscription;}

//    dismissProgress ();

    if (_u_dao == null ) {
      _u_dao = Provider.of<UserDao>(context);
    }

    //TODO uncomment for Ios app subscription checking and subscription prise showing in UI
//    if (Platform.isIOS ) {
//      _purchaseUpdatedSubscription == null ? _purchaseUpdatedSubscription =
//          FlutterInappPurchase.purchaseUpdated.listen((productItem) {
//            if (!toastShowOnce) {
//              if (Platform.isIOS) {
//                loadOnce = false;
//                //VALIDATE SUBSCRIPTION
//                SplashScreen.subscriptionHelper.init().then((_) {
//                  SplashScreen.subscriptionHelper.validateReceipt(
//                      SplashScreen.subscriptionHelper.purchases.last).then((
//                      bool) {
//                    if (bool) {
//                      Navigator.of(context)
//                        ..pushAndRemoveUntil(MaterialPageRoute(
//                            builder: (BuildContext context) =>
//                                MainScreenHolder()),
//                            ModalRoute.withName(MainScreenHolder.routName));
//                      SplashScreen.subscriptionHelper.dismissAll();
//                    }
//                  });
//                });
//              }
//            }
//            toastShowOnce = true;
//          }) : _purchaseUpdatedSubscription;
//    }
//    if (Platform.isIOS && loadOnce) {
//      loadOnce = false;
//      //VALIDATE SUBSCRIPTION
//      SplashScreen.subscriptionHelper.init().then((_) {
//        SplashScreen.subscriptionHelper.validateReceipt(
//            SplashScreen.subscriptionHelper.purchases.last).then((bool) {
//          if (bool) {
//            Navigator.of(context)
//              ..pushAndRemoveUntil(MaterialPageRoute(
//                  builder: (BuildContext context) => MainScreenHolder()),
//                  ModalRoute.withName(MainScreenHolder.routName));
//            SplashScreen.subscriptionHelper.dismissAll();
//          }
//        }).catchError((e){
//
//        });
//      });
//    }

    image = Container(
      key: Key(lastSelectedIndex.toString()),
      child: Image.asset(
        imagesList[lastSelectedIndex],
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );

    text = Container(
      key: Key(lastSelectedIndex.toString()),
      child: Text(
        textList[lastSelectedIndex],
        style: TextStyleBuilder.textStyleBuilder(18, 600, TextStyleColors.darkText, FontStyle.normal, context),
        textAlign: TextAlign.center,
      ),
    );

    if (UserSubscriptionScreen5.isColdBoot) {
      UserSubscriptionScreen5.isColdBoot = false;
    }

    if (t == null) {
      changeMaterials();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height+200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width + 25,
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: image,
                              ),
                            )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 120*UIScaler.getUiScaleFactor(context),
                            width: MediaQuery.of(context).size.width/5*(1.45*3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
//                                GestureDetector(
//                                  onTap: () {
//                                    setState(() {
//                                      selectedSubscriptionIndex = 0;
//                                    });
//                                  },
//                                  child: Container(
//                                      height: 160*UIScaler.getUiScaleFactor(context),
//                                      width: MediaQuery.of(context).size.width/5*1.45,
//                                      child: Card(
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(
//                                              Radius.circular(8.0),
//                                            ),
//                                            side: BorderSide(
//                                                color:
//                                                selectedSubscriptionIndex ==
//                                                    0
//                                                    ? Theme.of(context)
//                                                    .buttonColor
//                                                    : Colors.white,
//                                                width:
//                                                selectedSubscriptionIndex ==
//                                                    0
//                                                    ? 3
//                                                    : 0)),
//                                        margin: EdgeInsets.all(0.5),
//                                        elevation: 8,
//                                        color: Colors.white,
//                                        child: Column(
//                                          mainAxisAlignment:
//                                          MainAxisAlignment.spaceEvenly,
//                                          crossAxisAlignment:
//                                          CrossAxisAlignment.center,
//                                          children: <Widget>[
//                                            Text(
//                                              '1 week',
//                                              style: TextStyleBuilder.textStyleBuilder(15, 600, TextStyleColors.black, FontStyle.normal, context),
//                                            ),
//                                            Text('${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty ? SplashScreen.subscriptionHelper.items[1].localizedPrice : 0.00}',
//                                              style: TextStyleBuilder.textStyleBuilder(21, 600, TextStyleColors.violet, FontStyle.normal, context),),
//                                            Text('${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty ? SplashScreen.subscriptionHelper.items[1].price : 0.00} ${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty ? SplashScreen.subscriptionHelper.items[1].currency : '\$'} / week',
//                                              style: TextStyleBuilder.textStyleBuilder(12, 400, TextStyleColors.black, FontStyle.normal, context),),
//                                          ],
//                                        ),
//                                      )),
//                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSubscriptionIndex = 0;
//                                      selectedSubscriptionIndex = 1;

                                    });
                                  },
                                  child: Container(
                                      height: 120*UIScaler.getUiScaleFactor(context),
                                      width: MediaQuery.of(context).size.width-72,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                            side: BorderSide(
                                                color:
                                                selectedSubscriptionIndex == 0
//                                                selectedSubscriptionIndex ==
//                                                    1
                                                    ? Color(0xFF1D1D1D)
                                                    : Colors.white,
                                                width:
                                                selectedSubscriptionIndex ==
                                                    1
                                                    ? 2
                                                    : 2)),
                                        margin: EdgeInsets.all(0.5),
                                        elevation: 8,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '1 WEEK',
//                                              '1 year',
                                              style: TextStyleBuilder.textStyleBuilder(16, 400, TextStyleColors.black, FontStyle.normal, context),
                                            ),
                                        Text('${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty ? SplashScreen.subscriptionHelper.items[1].localizedPrice : 0.00}',
                                              style: TextStyleBuilder.textStyleBuilder(21, 600, TextStyleColors.orange, FontStyle.normal, context),),
                                            Container(height: 18,)
//                                            Text('${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty ? SplashScreen.subscriptionHelper.items[1].price : 0.00} ${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty ? SplashScreen.subscriptionHelper.items[1].currency : '\$'} / week',
//                                              style: TextStyleBuilder.textStyleBuilder(12, 400, TextStyleColors.black, FontStyle.normal, context),),
//                                            Text('${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty? SplashScreen.subscriptionHelper.items[2].localizedPrice : 0.00}',
//                                              style: TextStyleBuilder.textStyleBuilder(21, 600, TextStyleColors.violet, FontStyle.normal, context),),
//                                            Text('${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty? ((double.parse(SplashScreen.subscriptionHelper.items[2].price))/52).toStringAsFixed(2) : 0.00} ${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty? SplashScreen.subscriptionHelper.items[2].currency : '\$'} / week',
//                                              style: TextStyleBuilder.textStyleBuilder(12, 400, TextStyleColors.black, FontStyle.normal, context),),
                                          ],
                                        ),
                                      )),
                                ),
//                                GestureDetector(
//                                  onTap: () {
//                                    setState(() {
//                                      selectedSubscriptionIndex = 2;
//
//                                    });
//                                  },
//                                  child: Container(
//                                      height: 160*UIScaler.getUiScaleFactor(context),
//                                      width: MediaQuery.of(context).size.width/5*1.45,
//                                      child: Card(
//                                        shape: RoundedRectangleBorder(
//                                            borderRadius: BorderRadius.all(
//                                              Radius.circular(8.0),
//                                            ),
//                                            side: BorderSide(
//                                                color:
//                                                selectedSubscriptionIndex ==
//                                                    2
//                                                    ? Theme.of(context)
//                                                    .buttonColor
//                                                    : Colors.white,
//                                                width:
//                                                selectedSubscriptionIndex ==
//                                                    2
//                                                    ? 3
//                                                    : 0)),
//                                        margin: EdgeInsets.all(0.5),
//                                        elevation: 8,
//                                        color: Colors.white,
//                                        child: Column(
//                                          mainAxisAlignment:
//                                          MainAxisAlignment.spaceEvenly,
//                                          crossAxisAlignment:
//                                          CrossAxisAlignment.center,
//                                          children: <Widget>[
//                                            Text(
//                                              '1 month',
//                                              style: TextStyleBuilder.textStyleBuilder(15, 600, TextStyleColors.black, FontStyle.normal, context),
//                                            ),
//                                            Text('${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty? SplashScreen.subscriptionHelper.items[0].localizedPrice : 0.00}',
//                                              style: TextStyleBuilder.textStyleBuilder(21, 600, TextStyleColors.violet, FontStyle.normal, context),),
//                                            Text('${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty? ((double.parse(SplashScreen.subscriptionHelper.items[0].price))/4).toStringAsFixed(2) : 0.00} ${Platform.isIOS && SplashScreen.subscriptionHelper.items.isNotEmpty? SplashScreen.subscriptionHelper.items[0].currency: '\$'} / week',
//                                              style: TextStyleBuilder.textStyleBuilder(12, 400, TextStyleColors.black, FontStyle.normal, context),),
//                                          ],
//                                        ),
//                                      )),
//                                ),
                              ],
                            ),
                          ),
                        ),
//                        Align(
//                          alignment: Alignment.bottomCenter,
//                          child: Padding(
//                            padding: EdgeInsets.only(bottom: 145*UIScaler.getUiScaleFactor(context)),
//                            child: SizedBox(
//                              width: 72.0,
//                              height: 27.0,
//                              child: RaisedButton(
//                                color: Theme.of(context).buttonColor,
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(19.0),
//                                    side: BorderSide(color: Theme.of(context).buttonColor)),
//                                onPressed: () {
//                                  return null;
//                                },
//                                child: Text(
//                                  "-72%".toUpperCase(),
//                                  style: TextStyleBuilder.textStyleBuilder(15, 600, TextStyleColors.white, FontStyle.normal, context),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 150*UIScaler.getUiScaleFactor(context),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: text,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom : 32, right: 16),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40.0*UIScaler.getUiScaleFactor(context),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side:
                                  BorderSide(color: Theme.of(context).buttonColor)),
                              onPressed: () async {

                                toastShowOnce = false;
                                //TODO uncomment for Ios app subscription checking
//                                if (Platform.isIOS) {
//                                  setState(() {
//                                    isShowProgress = true;
//                                  });
//                                  purchasedFun(selectedSubscriptionIndex);
//                                } else {
                                  var list = await _u_dao.allUserEntries;
                                  list[0] =
                                      list[0].copyWith(
                                          isSubscriptionBought: true);
                                  await _u_dao.updateUser(list[0]);
                                  Navigator.of(context)..pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainScreenHolder()), ModalRoute.withName(MainScreenHolder.routName));
//                                }
//                            Navigator.of(context)..pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainScreenHolder()), ModalRoute.withName(MainScreenHolder.routName));
                              },
                              child: Text(
                                'START FREE 7 DAY TRIAL'.toUpperCase(),
                                style: TextStyleBuilder.textStyleBuilder(16, 600, TextStyleColors.white, FontStyle.normal, context),
                              ),
                            ),
                          ),
                          Container(
                            height: 160,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 8),
                              child: Text(
                                'Once you register, you’ll get access to a personalized workout plan consisting of more than 100 exercises.\n\n Your membership will automatically renew at the end of each term, and your credit card willbe charged via your iTunes account. You can disable automatic subscription renewal at anytime in your iTunes account settings, but no refund will be granted for any unused portion ofyour subscription. If you decide to cancel, you need to do so at least 24 hours prior to termexpiration to avoid being billed.', style: TextStyleBuilder.textStyleBuilder(10, 300, TextStyleColors.darkGrey, FontStyle.normal, context), textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          isShowProgress? Container(color: Color.fromRGBO(23, 23, 23, 0.68),height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width ) : Container(),
          isShowProgress? Align(alignment: Alignment.center , child: SizedBox(height: 64, width: 64 , child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFF6B4A)),))) : Container(),
        ],
      ),
    );
  }

  Timer t;
  void changeMaterials() {
    if (t != null) t.cancel();
    t = Timer(Duration(seconds: 3), () {
      setState(() {
        if (lastSelectedIndex + 1 < imagesList.length) {
          lastSelectedIndex++;
          changeMaterials();
        } else {
          lastSelectedIndex = 0;
          changeMaterials();
        }
      });
    });
  }

  void purchasedFun(int selectedSubscriptionIndex){
    var ssHelperItem = selectedSubscriptionIndex == 2 ? SplashScreen.subscriptionHelper.items[0] : selectedSubscriptionIndex == 1 ? SplashScreen.subscriptionHelper.items[2] : SplashScreen.subscriptionHelper.items[1];

    SplashScreen.subscriptionHelper.purchase(ssHelperItem, dismissProgress).then((bool) async {

      if (bool){
        dismissProgress();
        UserRegistrationController.user =
            UserRegistrationController.user.copyWith(
                isSubscriptionBought: true);
        await _u_dao.updateUser(UserRegistrationController.user);
        Navigator.of(context)
          ..pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => MainScreenHolder()),
              ModalRoute.withName(MainScreenHolder.routName));
        SplashScreen.subscriptionHelper.dismissAll();
      } else {
        dismissProgress();
      }

    }).catchError((e){
      dismissProgress();
    });
  }

  Function dismissProgress (){
    setState(() {
//      print('DISMISS');
      isShowProgress = false;
    });
  }
}

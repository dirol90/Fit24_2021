import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/material.dart';

class SubscriptionTextScreen extends StatelessWidget {
  static const String routName = '/SubscriptionTextScreen';
  final Function f;

  SubscriptionTextScreen(this.f);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(child:
      Padding(
        padding:  EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 52*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 0, right: 8, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(onTap: (){f(0);}, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 5 * 3.3,
                      child: Center(
                        child: GestureDetector(onTap: (){f(0); /** SAVE IT!!! **/}, child: Text('Subscription Information', style: TextStyleBuilder.textStyleBuilder(16, 600, TextStyleColors.black, FontStyle.normal, context),)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: SingleChildScrollView(
                child: Container(
                  child: Text('Once you register, you’ll get access to a personalized workout plan consisting of more than 100 exercises. \n\nYour membership will automatically renew at the end of each term, and your credit card will be charged via your iTunes account. You can disable automatic subscription renewal at any time in your iTunes account settings, but no refund will be granted for any unused portion of your subscription. If you decide to cancel, you need to do so at least 24 hours prior to term expiration to avoid being billed. '),
                ),
              ),
            ),
          ],
        ),
      ),),
    );
  }
}

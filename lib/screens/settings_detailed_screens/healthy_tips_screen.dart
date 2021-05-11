import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:Fit24/widget/my_cupertino_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class HealthyTipsUserSettingsDetailedScreen extends StatefulWidget {
  static const String routName = '/HealthyTipsUserSettingsDetailedScreen';
  final Function f;

  HealthyTipsUserSettingsDetailedScreen(this.f);

  @override
  _HealthyTipsUserSettingsDetailedScreenState createState() =>
      _HealthyTipsUserSettingsDetailedScreenState();
}

class _HealthyTipsUserSettingsDetailedScreenState
    extends State<HealthyTipsUserSettingsDetailedScreen> {

  double containerHeight;
  TextEditingController controller = TextEditingController();

  String text = 'Subcribe! Get the latest news.';

  @override
  Widget build(BuildContext context) {

    if (containerHeight != 300.0) {
      containerHeight = MediaQuery
          .of(context)
          .size
          .height - 128;
    }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16*UIScaler.getUiScaleFactor(context), 52*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context), 16*UIScaler.getUiScaleFactor(context)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 0, right: 8, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(onTap: (){widget.f(0);}, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 5 * 3.3,
                      child: Center(
                        child: GestureDetector(onTap: (){widget.f(0); /** SAVE IT!!! **/}, child: Text('Healthy tips', style: TextStyleBuilder.textStyleBuilder(16, 600, TextStyleColors.black, FontStyle.normal, context),)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: containerHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/img/letter_image.png', height: 180*UIScaler.getUiScaleFactor(context), width: 180*UIScaler.getUiScaleFactor(context),),
                    Text(text, style: TextStyleBuilder.textStyleBuilder(16, 500, TextStyleColors.black, FontStyle.normal, context), textAlign: TextAlign.center,),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, left: 40, right: 40),
                      child: Container(
                        height: 50*UIScaler.getUiScaleFactor(context),
                        width: MediaQuery.of(context).size.width - 32,
                        child: Stack(
                          children: <Widget>[
                            FocusScope(
                              child: Focus(
                                onFocusChange: (focus) {
                                  setState(() {
                                    containerHeight = 300*UIScaler.getUiScaleFactor(context);
                                  });
                                },
                                child:
                                Container(
                                  height: 50,
                                  width: (MediaQuery.of(context).size.width - 36),
                                  child: MyCupertinoTextField(
                                    keyboardType: TextInputType.emailAddress,
                                    textCapitalization: TextCapitalization.sentences,
                                    placeholder: "Enter your email",
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
                                    controller: controller,
                                  ),),

//                                TextField(
//                                  controller: controller,
//                                  keyboardType: TextInputType.emailAddress,
//                                  decoration: InputDecoration(
//                                      border: OutlineInputBorder(
//                                        borderSide: BorderSide(color: Color(0xFFC1C1CB)),
//                                        borderRadius: const BorderRadius.all(
//                                          const Radius.circular(4.0),
//                                        ),
//                                      ),
//                                      filled: true,
//                                      hintStyle: TextStyleBuilder.textStyleBuilder(18, 500, TextStyleColors.grey, FontStyle.normal, context),
//                                      hintText: "Enter your email",
////                                      fillColor: Color(0xffFFFFFF),
//                                  ),
//                                ),


                              ),
                            ),
                            Container(
                              child: Align(alignment: Alignment.centerRight, child: Container(
                                child: SizedBox(
                                  height: 48*UIScaler.getUiScaleFactor(context),
                                  width: 75*UIScaler.getUiScaleFactor(context),
                                  child: RaisedButton(
                                    onPressed: (){
                                      setState(() async {
                                        final MailOptions mailOptions = MailOptions(
                                          body: 'Subscribe for : ${controller.text}',
                                          subject: 'Subscribe for news',
                                          recipients: ['fitandripped24@gmail.com'],
                                          isHTML: false,
                                        );

                                        await FlutterMailer.send(mailOptions);

                                        controller.clear();
                                      });
                                    },
                                    color: Theme.of(context).buttonColor,
                                  ),
                                ),
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 75.0/3),
                              child: Align(alignment: Alignment.centerRight, child: Image.asset('assets/img/plane_icon.png', height: 22, width: 27,)),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],),
              ),
            )


          ],
        ),
      ),
    );
  }
}

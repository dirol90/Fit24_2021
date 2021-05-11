import 'package:flutter/cupertino.dart';

class UIScaler {


  //IPhone 8 -
  // flutter: HEIGHT: 667.0
  //flutter: WIDTH: 375.0
  static double getUiScaleFactor(BuildContext context){
//    print('HEIGHT: ${MediaQuery.of(context).size.height}');
//    print('WIDTH: ${MediaQuery.of(context).size.width}');
    if (MediaQuery.of(context).size.height < 667 && MediaQuery.of(context).size.width < 375){

      return 0.8;
    } else {
      return 1.0;
    }
  }


}
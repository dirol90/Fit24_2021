import 'dart:async';
import 'dart:convert';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_inapp_purchase/modules.dart';

class SubscriptionHelper {

    List<String> _productLists = ['subscription_week', 'subscription_month', 'subscription_year'];
    List<IAPItem> items = List();
    List purchases = List();

    Future init() async {
    await FlutterInappPurchase.instance.initConnection;
    await getItems();
    await getPurchases();
  }

    Future dismissAll() async {
    await FlutterInappPurchase.instance.endConnection;
//    _purchaseUpdatedSubscription.cancel();
//    _purchaseUpdatedSubscription = null;
//    _purchaseErrorSubscription.cancel();
//    _purchaseErrorSubscription = null;
  }

    Future getItems () async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(_productLists);
    this.items = List();
    for (var item in items) {
//      print('${item.toString()}');
      this.items.add(item);
    }
  }

    Future getPurchases() async {
    purchases = List<PurchasedItem>();
    List<PurchasedItem> items = List<PurchasedItem>();
    try {
      items = await FlutterInappPurchase.instance.getAvailablePurchases();
    } catch (e){}

    for (var item in items) {
      purchases.add(item);
    }
  }


    Future<bool> purchase(IAPItem item, Function f) async {
      FlutterInappPurchase.purchaseError.listen((purchaseError) {
        f();
      });
    await FlutterInappPurchase.instance.requestPurchase(item.productId).then((_) async {
      await getPurchases().whenComplete(() async {
        return await validateReceipt(purchases.last);
      });
    }).catchError((e){
      return false;
    });
  }



    Future<bool> validateReceipt(PurchasedItem purchased) async {
    final receiptBody = {
      'receipt-data': purchased.transactionReceipt,
      'password': 'd8bc18b915ad4de88e29efa7c70554a8' // APPSTORE PASS
    };
    final result = await FlutterInappPurchase.instance.validateReceiptIos(
      // TODO: SET FALSE FOR RELEASE version!!!!
        receiptBody: receiptBody, isTest: true);

//    print('RESULT: ${result.body}');

    if (result.body.contains('"status":0')) {
      var data = json.decode(result.body);

      var isAnyValidSubscriptions = false;
        final items = (data['latest_receipt_info'] as List).map((i) => Map<String, dynamic>.from(i));

        for (final item in items) {
          item.forEach((k, v){
            // ignore: missing_return
            if (k == 'expires_date_ms'){

//              print('${v.toString()}');
//              print('${int.parse(v.toString())}');
//              print('${DateTime.now().millisecond}');
//              print('${int.parse(v.toString()) > DateTime.now().millisecondsSinceEpoch}');

              if (int.parse(v.toString()) > DateTime.now().millisecondsSinceEpoch){
//                print('Reciept VALID');
                isAnyValidSubscriptions = true;
              }
            }
          });
        }
//      print('Reciept status: ${isAnyValidSubscriptions}');
      return isAnyValidSubscriptions;
    } else {
//      print('Reciept INVALIDE, code : ${result.body}');
      return false;

    }
  }

}
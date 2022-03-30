

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:flutter_upayments/src/api_services/api_base_helper.dart';
import 'package:flutter_upayments/src/api_services/app_const.dart'; 
import 'package:flutter_upayments/src/u_data.dart';
import 'package:flutter_upayments/src/upaymentDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../flutter_upayments.dart';

Future<dynamic> RequestPayment(
  context,
  paymentDetails data,
  Function(
    bool isSuccess,
    Map TransactionDetails,
    String message,
  )
      OnSuccess,
  Function(bool isSuccess, Map TransactionDetails, String message,) OnFailure,
) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ));
      });
   final ApiBaseHelper _helper = ApiBaseHelper();

  var paymentUrl;

try {
     var salt10 = await FlutterBcrypt.saltWithRounds(rounds: 10);
    var encryptedSHA = await FlutterBcrypt.hashPw(
          password: data.apiKey!, salt: salt10);

  Map details = {
    "merchant_id": data.merchantId,
    "username": data.username,
    "password": data.password,
    "api_key": data.testMode == "0" ? encryptedSHA : data.apiKey,
    "order_id": data.orderId,
    "total_price": data.totalPrice,
    "CurrencyCode": data.currencyCode,
    "success_url": data.successUrl,
    "error_url": data.errorUrl,
    "test_mode": data.testMode,
    "CstFName": data.customerFName,
    "CstEmail": data.customerEmail,
    "CstMobile": data.customerMobile,
    "payment_gateway": data.paymentGateway,
    "whitelabled": data.whitelabled,
    "ProductTitle": data.productTitle,
    "ProductName": data.productName,
    "ProductPrice": data.productPrice,
    "ProductQty": data.productQty,
    "Reference": data.reference,
    "notifyURL": data.notifyURL,
  };

  var head = {"Content-Type": "application/json"};
  //encode Map to JSON
  var body = json.encode(details);

  print(head);
  print(body);
  final response = await _helper.post(
      data.testMode == "0"
          ? AppConst.getProductionPaymentUrl
          : AppConst.getTestPaymentUrl,
      body);
  if (response['status'] == 'success') {
    paymentUrl = response['paymentURL'];
    Navigator.pop(context);
  } else {
    Map details = {};
    Fluttertoast.showToast(
            msg: "Something Went Wrong!\nTry Again Later",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0)
        .then((value) => OnFailure(false, details,'error'));
    Navigator.pop(context);

    print(response);
  }
} catch (e) {
  Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
             Navigator.pop(context);

}

 
  BuildContext dialogContext;

  paymentUrl != null
      ? showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return upayDialog(
                data: data,
                OnFailure: OnFailure,
                OnSuccess: OnSuccess,
                weblink: paymentUrl);
          })
      : null;
}

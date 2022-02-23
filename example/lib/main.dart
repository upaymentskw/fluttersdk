import 'package:flutter/material.dart';
import 'package:flutter_upayments/flutter_upayments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Detailforms(),
    );
  }
}

// ignore_for_file: prefer_const_constructors, file_names

class Detailforms extends StatefulWidget {
  const Detailforms({Key? key}) : super(key: key);

  @override
  _DetailformsState createState() => _DetailformsState();
}

class _DetailformsState extends State<Detailforms> {
  final _formKey = GlobalKey<FormState>();
  bool webview = false;
  bool developmentSelected = true;
  paymentDetails userData = paymentDetails(
    merchantId: "1201",
    username: "test",
    password: "test",
    apiKey: "jtest123",
    orderId: "12345",
    totalPrice: "3.000",
    currencyCode: "NA",
    successUrl: "https://example.com/success.html",
    errorUrl: "https://example.com/error.html",
    testMode: "1",
    customerFName: "test23",
    customerEmail: "test23@gmail.com",
    customerMobile: "12345678",
    paymentGateway: "knet",
    whitelabled: "true",
    productTitle: "productTitle",
    productName: "Product1",
    productPrice: "12",
    productQty: "2",
    reference: "Ref00001",
    notifyURL: "https://example.com/success.html",
  );
  paymentDetails productiondata = paymentDetails();
  bool loading = false;
  String callurl = '';

  callback(data) {
    setState(() {
      webview = data;
    });
  }

  OnSuccess(isSuccess, data, message) {
    print(data['PaymentID']);
    setState(() {
      webview = isSuccess;
    });
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Data fetched from url'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(data.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  OnFailure(isSuccess, TransactionDetails, message) {
    setState(() {
      webview = isSuccess;
    });
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Something went wrong !"),
                Text(TransactionDetails.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upayments"),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.center,
              child: Text('Clear all'),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (!developmentSelected) {
                                      developmentSelected = true;
                                    }
                                  });
                                },
                                child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: developmentSelected
                                            ? Colors.blue
                                            : Colors.grey,
                                        borderRadius: BorderRadius.zero),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10),
                                      child: Text(
                                        "Development",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (developmentSelected) {
                                      _formKey.currentState?.reset();
                                      developmentSelected = false;
                                    }
                                  });
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: developmentSelected
                                            ? Colors.grey
                                            : Colors.blue,
                                        borderRadius: BorderRadius.zero),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10),
                                      child: Text(
                                        "Production",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      developmentSelected == true
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Username",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.username,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.username = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Password",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.password,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.password = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Api key",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.apiKey,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.apiKey = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                  Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Payment Gateway",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.paymentGateway,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.paymentGateway = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "White Labled",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.whitelabled,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.whitelabled = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Order ID",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.orderId,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.orderId = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Merchant ID",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.merchantId,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.merchantId = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Total Price",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.totalPrice,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.totalPrice = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Currency Code",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue:
                                                  userData.currencyCode,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.currencyCode = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Test Mode",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.testMode,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.testMode = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Success Url",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.successUrl,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.successUrl = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Error Url",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.errorUrl,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.errorUrl = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Customer Full Name",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue:
                                                  userData.customerFName,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.customerFName = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Customer Email",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue:
                                                  userData.customerEmail,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.customerEmail = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Customer Mobile",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue:
                                                  userData.customerMobile,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.customerMobile = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Product Title",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue:
                                                  userData.productTitle,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.productTitle = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Product Name",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue:
                                                  userData.productName,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.productName = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Product Price",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue:
                                                  userData.productPrice,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.productPrice = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Product Qty",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.productQty,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.productQty = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Refrence",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.reference,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.reference = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Notify Url",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              initialValue: userData.notifyURL,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                              onChanged: (val) {
                                                setState(() {
                                                  userData.notifyURL = val;
                                                });
                                              },
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow: TextOverflow.clip,
                                                  color: Color.fromRGBO(
                                                      73, 69, 79, 1)),
                                            ))),
                                  ],
                                ),
                              ],
                            )
                          : Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Username",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.username =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Password",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.password =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                 Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Api key",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.apiKey =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
              Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Payment Gateway",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.paymentGateway =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                   Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "White Labled",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.whitelabled =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Order ID",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.orderId =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Merchant ID",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.merchantId =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Total Price",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.totalPrice =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Currency Code",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata
                                                        .currencyCode = val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Test Mode",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.testMode =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Success Url",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.successUrl =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Error Url",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.errorUrl = val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Customer Full Name",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata
                                                        .customerFName = val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Customer Email",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata
                                                        .customerEmail = val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Customer Mobile",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata
                                                        .customerMobile = val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Product Title",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata
                                                        .productTitle = val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Product Name",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.productName =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Product Price",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata
                                                        .productPrice = val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Product Qty",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.productQty =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Refrence",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.reference =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Notify Url",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        flex: 1,
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1))),
                                                onChanged: (val) {
                                                  setState(() {
                                                    productiondata.notifyURL =
                                                        val;
                                                  });
                                                },
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.clip,
                                                    color: Color.fromRGBO(
                                                        73, 69, 79, 1)),
                                              ))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      GestureDetector(
                        onTap: () {
                          RequestPayment(
                              context,
                              developmentSelected ? userData : productiondata,
                              developmentSelected ? false : true,
                              OnSuccess,
                              OnFailure);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 5, left: 2, right: 2, top: 5),
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(246, 197, 64, 1)),
                          width: double.infinity,
                          child: Text(
                            "Launch",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))),
    );
  }
}
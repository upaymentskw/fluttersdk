# flutter_upayments

The UPayments flutter SDK allows you to integrate easily and faster with native Android and iOS apps.

Manage your transactions and clients effectively and in real-time through our easy-to-use real-time dashboard.

We provide a powerful, secure payment and pre-built UI that can be used out-of-the-box to collect your users’ payment details.

This pre-built UI lets you accept KNET, Apple Pay, Samsung Pay, Visa and MasterCard.

## Prerequisites

To have the plugin integration working in a live environment, please refer to the section prerequisites and read it for more details

# Integration

## Installation

1. Add flutter_upayments plugin to your pubspec.yaml file.

```yaml

dependencies:

  flutter_upayments: <latest_version>

```

2. Install the plugin by running the following command.

```bash

$ flutter pub get

```

## Usage

Inside your Dart code, do the following:

1. To use the flutter_upayments plugin, import it into your Flutter app.

```dart

import ‘package:flutter_upayments/flutter_upayments.dart’;

```

 

2. Request Payment.

* **Requestpayment**: This step will request payment and return the callback data on payment success. 

```dart

   RequestPayment(

                              context,

                              PaymentDetails, //All payment details

                              OnSuccess, // method OnSuccess which returns data on callback

                              OnFailure // method OnFailure which returns data on error

); 

```

## Parameters

* **PaymentDetails (Required)**: All payment details model should be passed in this parameter.

```dart

  paymentDetails userData = paymentDetails(

    merchantId: “”,

    // SetMerchantID    

    username: “”, 

    // Set User Name Provided, For Test Pass test  

    password: “”, 

    // Set Password, For Test pass test

    apiKey: “”, 

    // API Key for Test jtest123

    orderId: “”,

    // MIN 30 characters with a strong unique function (like hashing function with time) 

    totalPrice: “”, 

    // Total Price Payable amount (max 3 decimal points)

    currencyCode: “”, 

    /* Supported currency code  KWD, SAR, USD, BHD, EUR, OMR, QAR, AED Contact us at support@upayments.com For sandbox: NA */

    successUrl: “”, 

    // URL to redirect the user to a successful transaction. For Test: https://example.com/success.html

    errorUrl: “”,

    // URL where the user will redirect after an error in payment. For Test: https://example.com/error.html

    testMode: “”, 

    // 0 for production mode,1 Sandbox Mode

    customerFName: “”, 

    // Customer Name

    customerEmail: “”, 

    // Customer Email

    customerMobile: “”, 

    // Customer Mobile number

    paymentGateway: “”, 

    /* knet for KNet transaction, c for Credit Card Transaction For Sandbox: NA */

    whitelabled: “”, 

    /* 1 = true (must be enabled by admin) 0 = false

    For SandBox : NA */

    productTitle: “”, 

    // Product Name/Description

    productName: “”, 

    /* Encoded array of product names Ex: Posting Products Name : 

    For SandBox: NA

    List<String> listProductName = new ArrayList<String>();

    listProductName.add(“product1”);

    listProductName.add(“product2”); */

    productPrice: “”, 

    /* Encoded array of product prices

    Ex: List<String> listProductPrice = new ArrayList<String>();

    listProductPrice.add(“12”);

    listProductPrice.add(“14”);

    For SandBox : NA */

    productQty: “”, 

    /* Encoded array of product quantities

    Ex: List<String> listProductQuantity = new ArrayList<String>();

    listProductQuantity.add(“2”);

    listProductQuantity.add(“4”); */

    reference: “”, 

    /* Merchant Order ID or Reference number for Sandbox: NA */

    notifyURL: “”, 

    // Notification URL that you can provide with every call to receive confirmations 

  );

 RequestPayment( context, userData, OnSuccess, OnFailure ); 

```

* **OnSuccess (Required)**: You have to create a method that will contain 3 parameters that will give you the status of callback, data received on callback, and message.

```dart

  OnSuccess(isSuccess, data, message) {

             print(isSuccess); // it will print true if success else false

             print(data);// it will print all transaction details.

             print(message);// it will print a message.

        }

```

* **OnFailure (Required)**: You have to create a method that will contain 3 parameters that will give you the status of error, data received on callback and message.

```dart

  OnFailure(isSuccess, data, message) {

             print(isSuccess); // it will print true if success else false

             print(data);// it will print all transaction details.

             print(message);// it will print a message.

        }

```

### Example

``` dart

import ‘package:flutter/material.dart’;

import ‘package:flutter_upayments/flutter_upayments.dart’;

paymentDetails userData = paymentDetails(

  merchantId: “1201”,

  username: “test”,

  password: “test”,

  apiKey: “jtest123”,

  orderId: “12345”,

  totalPrice: “3.000”,

  currencyCode: “NA”,

  successUrl: “https://example.com/success.html”,

  errorUrl: “https://example.com/error.html”,

  testMode: “1”,

  customerFName: “test23”,

  customerEmail: “test23@gmail.com”,

  customerMobile: “12345678”,

  paymentGateway: “knet”,

  whitelabled: “true”,

  productTitle: “productTitle”,

  productName: “Product1”,

  productPrice: “12”,

  productQty: “2”,

  reference: “Ref00001”,

  notifyURL: “https://example.com/success.html”,

);

OnSuccess(isSuccess, data, message) {

  print(isSuccess); // it will print true if success else false.

  print(data); // it will print all transaction details.

  print(message); // it will print the message.

}

OnFailure(isSuccess, data, message) {

  print(isSuccess); // it will print true if success else false.

  print(data); // it will print all transaction details.

  print(message); // it will print the message.

}

class mainapp extends StatelessWidget {

  const mainapp({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return Container(

      child: Center(

        child: RaisedButton(

          onPressed: () =>

              RequestPayment(context, userData, OnSuccess, OnFailure),

          child: Text(‘Pay’),

        ),

      ),

    );

  }

}

void main() => runApp(

      MaterialApp(

        home: Material(child: mainapp()),

      ),

    );

```
## Contributing

Pull requests are welcome. For major changes, please open the issue first to discuss what you would like to change.

Please make sure to update the tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)

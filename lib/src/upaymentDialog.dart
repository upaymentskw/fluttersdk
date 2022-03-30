import 'package:flutter/material.dart';
import 'package:flutter_upayments/src/u_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class upayDialog extends StatefulWidget {
    paymentDetails data;
    String? weblink;
    Function(
      bool status,
      Map TransactionDetails,
      String message,
    )
        OnSuccess;
    Function(bool status, Map TransactionDetails,String message,) OnFailure;
  upayDialog({Key ?key,required this.data,required this.OnFailure,required this.OnSuccess,required this.weblink }) : super(key: key);

  @override
  _upayDialogState createState() => _upayDialogState();
}

class _upayDialogState extends State<upayDialog> {
  
    NavigationDecision _interceptNavigation(NavigationRequest request) {
    print(request.url);


    if(request.url.contains('https://example.com/error.html')){
      var data= Uri.dataFromString(request.url);
// print(data.queryParametersAll);
Map val =data.queryParametersAll;
          Fluttertoast.showToast(
              msg: "Something Went Wrong!\nTry Again Later",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0)
          .then((value) =>  widget.OnFailure(false,val,"Payment Failed"));
Navigator.pop(context);
      return NavigationDecision.prevent;
    }
    if(request.url.startsWith('https://example.com/success.html')){
var data= Uri.dataFromString(request.url);
// print(data.queryParametersAll);
Map val =data.queryParametersAll;
         Fluttertoast.showToast(
              msg: "Payment Completed Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0)
          .then((value) =>  widget.OnSuccess(false,val,'Payment succeed'));
Navigator.pop(context);

      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }


  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      insetPadding:EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0) ,
      backgroundColor: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async{
          return false;
        },
        child:  Stack(
                  children: [
                 ClipRRect(
          borderRadius: BorderRadius.all(
            const Radius.circular(20.0),
          ),
                      child: WebView(
                        initialUrl:widget.weblink,
                        javascriptMode: JavascriptMode.unrestricted,
                        navigationDelegate:  _interceptNavigation,
                      ),
                    ),
                 
                  ],
                ),
    ),);
  }
}

 
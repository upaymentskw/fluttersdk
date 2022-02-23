library flutter_upayments; 

class paymentDetails {
  String? merchantId;
  String? username;
  String? password;
  String? apiKey;
  String? orderId;
  String? totalPrice;
  String? currencyCode;
  String? successUrl;
  String? errorUrl;
  String? testMode;
  String? customerFName;
  String? customerEmail;
  String? customerMobile;
  String? paymentGateway;
  String? whitelabled;
  String? productTitle;
  String? productName;
  String? productPrice;
  String? productQty;
  String? reference;
  String? notifyURL;

  paymentDetails(
      {this.merchantId,
      this.username,
      this.password,
      this.apiKey,
      this.orderId,
      this.totalPrice,
      this.currencyCode,
      this.successUrl,
      this.errorUrl,
      this.testMode,
      this.customerFName,
      this.customerEmail,
      this.customerMobile,
      this.paymentGateway,
      this.whitelabled,
      this.productTitle,
      this.productName,
      this.productPrice,
      this.productQty,
      this.reference,
      this.notifyURL});

  paymentDetails.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchant_id'];
    username = json['username'];
    password = json['password'];
    apiKey = json['api_key'];
    orderId = json['order_id'];
    totalPrice = json['total_price'];
    currencyCode = json['CurrencyCode'];
    successUrl = json['success_url'];
    errorUrl = json['error_url'];
    testMode = json['test_mode'];
    customerFName = json['customerFName'];
    customerEmail = json['customerEmail'];
    customerMobile = json['customerMobile'];
    paymentGateway = json['payment_gateway'];
    whitelabled = json['whitelabled'];
    productTitle = json['ProductTitle'];
    productName = json['ProductName'];
    productPrice = json['ProductPrice'];
    productQty = json['ProductQty'];
    reference = json['Reference'];
    notifyURL = json['notifyURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_id'] = this.merchantId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['api_key'] = this.apiKey;
    data['order_id'] = this.orderId;
    data['total_price'] = this.totalPrice;
    data['CurrencyCode'] = this.currencyCode;
    data['success_url'] = this.successUrl;
    data['error_url'] = this.errorUrl;
    data['test_mode'] = this.testMode;
    data['customerFName'] = this.customerFName;
    data['customerEmail'] = this.customerEmail;
    data['customerMobile'] = this.customerMobile;
    data['payment_gateway'] = this.paymentGateway;
    data['whitelabled'] = this.whitelabled;
    data['ProductTitle'] = this.productTitle;
    data['ProductName'] = this.productName;
    data['ProductPrice'] = this.productPrice;
    data['ProductQty'] = this.productQty;
    data['Reference'] = this.reference;
    data['notifyURL'] = this.notifyURL;
    return data;
  }
}
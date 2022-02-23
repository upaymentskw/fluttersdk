import 'dart:io';  
import 'package:flutter_upayments/src/api_services/api_exceptions.dart';
import 'package:flutter_upayments/src/api_services/app_const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'dart:async';   

class ApiBaseHelper {
  Future<dynamic> post(String url, dynamic body,) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final _authority = AppConst.baseUrl;
      final _path = url;
      Uri formattedUrl = Uri.parse(_authority + _path); 
      Map<String, String> header = new Map();
      header["Content-Type"] = "application/json";

      final response =
          await http.post(formattedUrl, body: body, headers: header);
      print(formattedUrl);
      print(body);
      print(header);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  // Future<dynamic> put(String url, dynamic body) async {
  //   print('Api Put, url $url');
  //   var responseJson;
  //   try {
  //     final _authority = AppConst.baseUrl;
  //     final _path = url;
  //     Uri formattedUrl = Uri.parse(_authority + _path);
  //     final response = await http.put(formattedUrl, body: body);
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     print('No net');
  //     throw FetchDataException('No Internet connection');
  //   }
  //   print('api put.');
  //   print(responseJson.toString());
  //   return responseJson;
  // }

//   Future<dynamic> delete(String url,
//       {bool requiresTenant = false, bool requiresToken = false}) async {
//     print('Api delete, url $url');
//     var apiResponse;
//     try {
//       final _authority = AppConst.baseUrl;
//       final _path = url;
//       Uri formattedUrl = Uri.parse(_authority + _path);
//       print(formattedUrl);
//       final prefs = await SharedPreferences.getInstance();
//       Map<String, String> header = new Map();
//       header["Content-Type"] = "application/json";
//       try {
//         if (requiresTenant && prefs.containsKey('tenant')) {
//           header["X-TenantID"] = prefs.getString('tenant');
//         }
//         if (requiresToken && prefs.containsKey('token')) {
//           header["Authorization"] = prefs.getString('token');
//         }
//       } catch (ex) {
//         print('api get header error!');
//       }

//       final response = await http.delete(formattedUrl, headers: header);
//       apiResponse = _returnResponse(response);
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//     print('api delete.');
//     return apiResponse;
//   }
// }

dynamic _returnResponse(http.Response response) {
  print(response.statusCode);
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      var responseJson = json.decode(response.body.toString());
//  throw UnauthorisedException(response.body.toString());
      return responseJson;
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
}
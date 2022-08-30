import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../../utils/constants.dart';
import '../../utils/errorMessageKeys.dart';
import 'accountsException.dart';

class AccountsRemoteDataSource {
  //response of this will be map of badges
  /*
      "message" : { 
          //badge type key
          "badge_type" :
            //badge data
           {
            "type" : "",
            "id" : "",
            ...
          }
        }
       */
  Future<Response> getAccounts() async {
    try {
      //body of post request
      var dio = Dio();
      Response response;
      if (kDebugMode) {
        print(baseUrl);
      }
     // final response = await http.post(Uri.parse(baseUrl), body: body, headers: await ApiUtils.getHeaders());
       response = await dio.get(baseUrl);

//print(response.data["entries"]);
     // final responseJson = jsonDecode(response.data["entries"]);
     // print(response.data["entries"]);


      if (response.statusCode! >= 400) {
        throw AccountsException(errorMessageCode: "Accounts can not be hold");
      }

      return response;
    } on SocketException catch (_) {
      throw AccountsException(errorMessageCode: noInternetCode);
    } on AccountsException catch (e) {
      throw AccountsException(errorMessageCode: e.toString());
    } catch (e) {
      throw AccountsException(errorMessageCode: defaultErrorMessageCode);
    }
  }

}

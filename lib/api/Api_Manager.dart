import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/api/Request/LoginRequest.dart';
import 'package:ecommerce/api/Request/RegisterRequest.dart';
import 'package:ecommerce/api/Response/Login/LoginResponse.dart';
import 'package:ecommerce/api/Response/categories/CategoriesResponse.dart';
import 'package:ecommerce/api/Response/register/RegisterResponse.dart';
import 'package:ecommerce/api/interceptor/Logging_Interceptor.dart';
import 'package:ecommerce/domain/customException/NetworkException.dart';
import 'package:ecommerce/domain/customException/ServerError.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:injectable/injectable.dart';
@singleton
class ApiManager {
  static const String baseUrl = "ecommerce.routemisr.com";
  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  Future<RegisterResponse> register(String name, String email, String phone,
      String password, String repassword) async {
    var url = Uri.https(baseUrl, "api/v1/auth/signup");
    try{
      var requestBody = RegisterRequest(
          name: name,
          email: email,
          password: password,
          phone: phone,
          rePassword: repassword);
      var response = await client.post(url, body: requestBody.toJson());
      var registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));
      if (!registerResponse.isSuccess()) {
        throw ServerError(
            errorMessage: registerResponse.message,
            httpResponseCode: response.statusCode);
      }
      return registerResponse;
    }on TimeoutException {
      throw NetworkException("TimeOut : Please check internet connection");
    } on HttpException {
      throw NetworkException("Http exception : Couldn't reach Server");
    }

  }

  Future<LoginResponse> login(String email, String password) async {
    var url = Uri.https(baseUrl, "api/v1/auth/signin");
    try {
      var requestBody = LoginRequest(email: email, password: password);
      var response = await client.post(url, body: requestBody.toJson());
      var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      if (!loginResponse.isSuccess()) {
        throw ServerError(
            errorMessage: loginResponse.message,
            statusMsg: loginResponse.statusMsg,
            httpResponseCode: response.statusCode);
      }
      return loginResponse;
    } on TimeoutException catch (e) {
      throw NetworkException("TimeOut : Please check internet connection");
    } on HttpException catch (e) {
      throw NetworkException("Http exception : Couldn't reach Server");
    }
  }

  Future<CategoriesResponse> getCategories({String? CategorySlug,int limit = 20,int page = 1}) async {
    var params = {
      'limit' : '$limit',
      'page' : '$page'
    };
    if(CategorySlug!=null){
      params['keyword'] = CategorySlug;
    }
    var url = Uri.https(baseUrl, "/api/v1/categories",params );
    try {
      var response = await client.get(url);
      return CategoriesResponse.fromJson(jsonDecode(response.body));
    } on TimeoutException catch (e) {
      throw NetworkException("TimeOut : Please check internet connection");
    } on HttpException catch (e) {
      throw NetworkException("Http exception : Couldn't reach Server");
    }
  }
}

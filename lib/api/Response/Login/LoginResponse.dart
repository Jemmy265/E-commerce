
import 'package:ecommerce/api/User.dart';
import 'package:ecommerce/domain/model/AuthResultDto.dart';

/// message : "success"
/// user : {"name":"mohamed","email":"mohamed2548@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1YjI1MDUxNDE4YzhiY2MwZWUxNjE3OCIsIm5hbWUiOiJtb2hhbWVkIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MDYxODQ4MTgsImV4cCI6MTcxMzk2MDgxOH0.tSSMhXydmzcQugeW0-luxoDNAKnYH5xCO9FMmb2rBvs"

class LoginResponse {
  LoginResponse({
      this.message, 
      this.user, 
      this.token,});

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    statusMsg = json['statusMsg'];
  }
  String? message;
  User? user;
  String? token;
  String? statusMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

  bool isSuccess(){
    return statusMsg != "fail";
  }

  AuthResultDto toAuthResultDto(){
    return AuthResultDto(
      user: user?.toUserDto(),
      token: token,
    );
  }
}
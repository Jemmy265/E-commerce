import 'package:ecommerce/api/Response/register/RegisterError.dart';
import 'package:ecommerce/domain/model/AuthResultDto.dart';

import '../../User.dart';

/// user : {"name":"Jemmy","email":"jemmy@yahoo.com"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1YjBkODQxODY4MzE4YjdiMDAyZTJjZiIsIm5hbWUiOiJKZW1teSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzA2MDg4NTE0LCJleHAiOjE3MTM4NjQ1MTR9.36j4HgoCXw3uMJ-9tM7aTIbEE53isZXqRmvcBGIZcWU"

class RegisterResponse {
  RegisterResponse({
    this.message,
    this.user,
    this.token,
  });

  RegisterResponse.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    error =
        json['errors'] != null ? RegisterError.fromJson(json['errors']) : null;
  }
  String? message;
  User? user;
  String? token;
  RegisterError? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

  bool isSuccess() {
    return error == null && message =='success';
  }

  String getErrorMessage() {
    return (message ?? error?.message) ?? "";
  }
  AuthResultDto toAuthResultDto(){
    return AuthResultDto(
      user: user?.toUserDto(),
      token: token
    );
  }
}

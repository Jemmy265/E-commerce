import 'package:ecommerce/domain/model/UserDto.dart';

class AuthResultDto {
  UserDto? user;
  String? token;

  AuthResultDto({this.user, this.token});
}
import 'package:ecommerce/domain/model/AuthResultDto.dart';

abstract class AuthOnlineDataSource {
  Future<AuthResultDto>login(String email, String password);
  Future<AuthResultDto>register(String name, String email, String phone, String password,
      String repassword);
}

import 'package:ecommerce/domain/dataSource/auth_online_dataSource.dart';
import 'package:ecommerce/domain/model/AuthResultDto.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // depends on data Sources
  AuthOnlineDataSource onlineDataSource; // we used the abstract not the impl, if impl changed or deleted, that won't affect here
  AuthRepositoryImpl(this.onlineDataSource);
  @override
  Future<AuthResultDto> login(String email, String password) {
    return onlineDataSource.login(email, password);
  }
  @override
  Future<AuthResultDto> register(String name, String email, String phone, String password, String repassword) {
    return onlineDataSource.register(name, email, phone, password, repassword);
  }
}
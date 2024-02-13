import 'package:ecommerce/domain/model/AuthResultDto.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';

class RegisterUseCase {
  AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<AuthResultDto> invoke(String name, String email, String phone, String password,
      String repassword)async{
    return repository.register(name, email, phone, password, repassword);
  }
}
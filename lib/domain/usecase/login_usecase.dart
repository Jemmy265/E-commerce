import 'package:ecommerce/domain/model/AuthResultDto.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase{
  AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthResultDto> invoke(String email, String password)async{
    return repository.login(email, password);
  }
}
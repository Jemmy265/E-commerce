import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/data/dataSource/auth_online_dataSource_impl.dart';
import 'package:ecommerce/data/repository/auth_repository.dart';
import 'package:ecommerce/domain/customException/ServerError.dart';
import 'package:ecommerce/domain/dataSource/auth_online_dataSource.dart';
import 'package:ecommerce/domain/model/AuthResultDto.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';
import 'package:ecommerce/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/customException/NetworkException.dart';

@injectable
class LoginViewModel extends Cubit<LoginViewState> {
  LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase) : super(InitialState());

  void login(String email, String password) async {
    emit(LoadingState(loadingMessage: "Loading...."));
    try {
      var response = await loginUseCase.invoke(email, password);
      // if(!response.isSuccess()){
      //   emit(FailState(message: response.message));
      //   return;
      // }
      emit(SuccessState(response));
    } on ServerError catch (ex) {
      emit(FailState(message: ex.errorMessage, exception: ex));
    } on NetworkException catch (ex) {
      emit(FailState(
          message: "Please check your internet connection", exception: ex));
    }
  }
}

abstract class LoginViewState {}

class InitialState extends LoginViewState {}

class LoadingState extends LoginViewState {
  String? loadingMessage;
  LoadingState({this.loadingMessage});
}

class SuccessState extends LoginViewState {
  AuthResultDto response;
  SuccessState(this.response);
}

class FailState extends LoginViewState {
  String? message;
  Exception? exception;

  FailState({this.message, this.exception});
}

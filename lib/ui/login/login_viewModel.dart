import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/data/dataSource/auth_online_dataSource_impl.dart';
import 'package:ecommerce/data/repository/auth_repository.dart';
import 'package:ecommerce/domain/customException/ServerError.dart';
import 'package:ecommerce/domain/dataSource/auth_online_dataSource.dart';
import 'package:ecommerce/domain/model/AuthResultDto.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';
import 'package:ecommerce/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/customException/NetworkException.dart';

class LoginViewModel extends Cubit<LoginViewState> {
  late ApiManager apiManager;
  late AuthOnlineDataSource onlineDataSource;
  late AuthRepository authRepository;
  late LoginUseCase loginUseCase;

  LoginViewModel() : super(InitialState()) {
    apiManager = ApiManager();
    onlineDataSource = AuthOnlineDataSourceImpl(apiManager);
    authRepository = AuthRepositoryImpl(
        onlineDataSource); // i can not make object from the abstract so i used impl
    loginUseCase = LoginUseCase(authRepository);
  }
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

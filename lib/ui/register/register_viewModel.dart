import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/data/dataSource/auth_online_dataSource_impl.dart';
import 'package:ecommerce/data/repository/auth_repository.dart';
import 'package:ecommerce/domain/customException/NetworkException.dart';
import 'package:ecommerce/domain/customException/ServerError.dart';
import 'package:ecommerce/domain/dataSource/auth_online_dataSource.dart';
import 'package:ecommerce/domain/model/AuthResultDto.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecase/register_usecase.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterViewState> {
  RegisterUseCase registerUseCase;

  RegisterViewModel(this.registerUseCase) : super(InitialState());

  void register(String name, String email, String phone, String password,
      String repassword) async {
    emit(LoadingState(loadingMessage: "Loading...."));
    try {
      var response = await registerUseCase.invoke(
          name, email, phone, password, repassword);
      // if (!response.isSuccess()) {
      //   emit(FailState(message: response.getErrorMessage()));
      //   return;
      // }
      emit(SuccessState(response));
    } on ServerError catch (ex) {
      emit(FailState(message: ex.errorMessage, exception: ex));
    } on NetworkException catch (ex) {
      emit(FailState(message: "Please check your internet connection", exception: ex));
    }
  }
}

abstract class RegisterViewState {}

class InitialState extends RegisterViewState {}

class LoadingState extends RegisterViewState {
  String? loadingMessage;
  LoadingState({this.loadingMessage});
}

class SuccessState extends RegisterViewState {
  AuthResultDto response;
  SuccessState(this.response);
}

class FailState extends RegisterViewState {
  String? message;
  Exception? exception;

  FailState({this.message, this.exception});
}

import 'package:ecommerce/api/User.dart';
import 'package:ecommerce/domain/model/UserDto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProvider extends Cubit<CurrentUserState>{
  UserProvider():super(LoggedOutState()){
    // read user data from shared prefs
  }
  bool isUserLoggedIn(){
    return state is LoggedInState;
  }
  void login(LoggedInState loggedInState){
    emit(loggedInState);
  }
  void logout(LoggedOutState loggedOutState){
    emit(loggedOutState);
  }
}

abstract class CurrentUserState{}

class LoggedInState extends CurrentUserState{
  String token;
  UserDto user;
  LoggedInState(this.user,this.token);
}

class LoggedOutState extends CurrentUserState{

}
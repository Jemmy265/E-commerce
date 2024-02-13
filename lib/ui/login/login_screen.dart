import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/ui/components/custom_form_field.dart';
import 'package:ecommerce/ui/home/home_screen.dart';
import 'package:ecommerce/ui/login/login_viewModel.dart';
import 'package:ecommerce/ui/register/register_screen.dart';
import 'package:ecommerce/utils/dialog_utils.dart';
import 'package:ecommerce/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";
  var formKey = GlobalKey<FormState>();

  var emailcontroller = TextEditingController(text: "mohamed25481@gmail.com");

  var passwordcontroller = TextEditingController(text: "jemmy6");

  LoginViewModel loginViewModel = getIt<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginViewModel, LoginViewState>(
      bloc: loginViewModel,
      listenWhen: (previous, current) {
        if (previous is LoadingState) {
          dialogs.hidedialog(context);
        }
        if (current is SuccessState ||
            current is LoadingState ||
            current is FailState) {
          return true;
        } else {
          return false;
        }
      },
      buildWhen: (previous, current) {
        if (current is InitialState) return true;
        return false;
      },
      listener: (context, state) {
        if (state is FailState) {
          dialogs.showMessage(
            context,
            state.message ??
                state.exception?.toString() ??
                "Something Went Wrong",
            PosActionName: "ok",
          );
        } else if (state is LoadingState) {
          dialogs.showloadingdialog(
              context, state.loadingMessage ?? "Loading...");
        } else if (state is SuccessState) {
          dialogs.showMessage(context, "Logged in Successfully",
              PosActionName: "ok", PosAction: () {
            UserProvider userProvider =
                BlocProvider.of<UserProvider>(context, listen: false);
            userProvider.login(
                LoggedInState(state.response.user!, state.response.token!));
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Image.asset("assets/images/route_big_logo.png"),
                  Text(
                    "Welcome Back to Route",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    "please sign in with your email",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomFormField(
                          controller: emailcontroller,
                          label: "Email Address",
                          hint: "Please Enter Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return "Please Enter Email";
                            }
                            if (!ValidationUtils.isValidEmail(text)) {
                              return "Email not valid";
                            }
                          },
                        ),
                        CustomFormField(
                          controller: passwordcontroller,
                          label: "Password",
                          hint: "Please Enter Password",
                          keyboardType: TextInputType.text,
                          isPassword: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return "Please Enter Password";
                            }
                            if (text.length < 6) {
                              return "Password should be at least 6 characters";
                            }
                          },
                        ),
                        ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: EdgeInsets.symmetric(vertical: 12)),
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            )),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text(
                            "Don't have an account? Create Account ",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    loginViewModel.login(emailcontroller.text, passwordcontroller.text);
  }
}

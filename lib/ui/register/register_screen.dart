import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/ui/components/custom_form_field.dart';
import 'package:ecommerce/ui/home/home_screen.dart';
import 'package:ecommerce/ui/login/login_screen.dart';
import 'package:ecommerce/ui/register/register_viewModel.dart';
import 'package:ecommerce/utils/dialog_utils.dart';
import 'package:ecommerce/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "register";
  var formKey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();

  var emailcontroller = TextEditingController();

  var mobilecontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var passwordconfirmationcontroller = TextEditingController();

  var viewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterViewModel, RegisterViewState>(
        bloc: viewModel,
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
            dialogs.showMessage(context, "User Registered Successfully",
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
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Image.asset("assets/images/route_big_logo.png"),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomFormField(
                            controller: namecontroller,
                            label: "Full Name",
                            hint: "Please Enter Full Name",
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return "Please Enter Full Name";
                              }
                            },
                          ),
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
                            controller: mobilecontroller,
                            label: "Mobile Number",
                            hint: "Please Enter Mobile Number",
                            keyboardType: TextInputType.phone,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return "Please Enter Mobile Number";
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
                          CustomFormField(
                            controller: passwordconfirmationcontroller,
                            label: "Password Confirmation",
                            hint: "Please Enter Password Confirmation",
                            keyboardType: TextInputType.text,
                            isPassword: true,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return "Please Enter Password-Confirmation";
                              }
                              if (passwordcontroller.text != text) {
                                return "password doesn't match";
                              }
                            },
                          ),
                          ElevatedButton(
                              onPressed: () {
                                register();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 12)),
                              child: Text(
                                "Register",
                                style: TextStyle(fontSize: 24),
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Text(
                              "Already have account ? Login",
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
        });
  }

  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.register(
        namecontroller.text,
        emailcontroller.text,
        mobilecontroller.text,
        passwordcontroller.text,
        passwordconfirmationcontroller.text);
  }
}

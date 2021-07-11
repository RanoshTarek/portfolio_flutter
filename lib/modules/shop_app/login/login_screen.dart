import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/home_layout/home_layout.dart';
import 'package:first_app/modules/shop_app/register/register.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) {
          return LoginCubit();
        },
        child: BlocConsumer<LoginCubit, LoginStates>(builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          defaultFromField(
                              controller: emailTextEditingController,
                              textInputType: TextInputType.emailAddress,
                              prefixIcon: Icon(Icons.email),
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "email must not be null";
                                }
                                return null;
                              },
                              labelText: 'Email Address'),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFromField(
                              controller: passwordTextEditingController,
                              textInputType: TextInputType.text,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: cubit.isObscureText
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              suffixIconPressed: () {
                                cubit.setObscure();
                              },
                              isObscureText: cubit.isObscureText,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "password must not be null";
                                }
                                return null;
                              },
                              labelText: 'Password'),
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) {
                              return defaultButton(
                                  function: () {
                                    if (formKey.currentState.validate()) {
                                      cubit.login(
                                          emailTextEditingController.text,
                                          passwordTextEditingController.text);
                                      print("email: " +
                                          emailTextEditingController.text +
                                          ", password: " +
                                          passwordTextEditingController.text);
                                    }
                                  },
                                  text: 'Login');
                            },
                            fallback: (context) {
                              return centerProgressBar();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  navigateTo(
                                      context: context,
                                      widget: RegisterScreen());
                                  print('Register now clicked');
                                },
                                child: Text(
                                  "Register now",
                                  style: TextStyle(color: primaryColor),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }, listener: (context, state) {
          if (state is LoginSuccessfulState) {
            DioHelper.init();
            showToast(text: "Successful Login", state: ToastStates.SUCCESS);
            navigateAndRemove(context: context, widget: HomeLayout());
          } else if (state is LoginUserCredentialsErrorState) {
            showToast(text: state.message, state: ToastStates.SUCCESS);
          } else if (state is LoginErrorState) {
            showToast(text: state.error, state: ToastStates.SUCCESS);
          }
          return;
        }));
  }
}

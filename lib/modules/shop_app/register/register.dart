import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/home_layout/home_layout.dart';
import 'package:first_app/model/user/shop/user_body_register.dart';
import 'package:first_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:first_app/modules/shop_app/login/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
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
              title: Text('Register'),
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
                            'Register',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          defaultFromField(
                              controller: nameTextEditingController,
                              textInputType: TextInputType.name,
                              prefixIcon: Icon(Icons.person),
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "person must not be null";
                                }
                                return null;
                              },
                              labelText: 'Name'),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFromField(
                              controller: phoneTextEditingController,
                              textInputType: TextInputType.phone,
                              prefixIcon: Icon(Icons.phone),
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "phone must not be null";
                                }
                                return null;
                              },
                              labelText: 'Phone'),
                          SizedBox(
                            height: 20,
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
                              textInputType: TextInputType.emailAddress,
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
                            condition: state is! RegisterLoadingState,
                            builder: (context) {
                              return defaultButton(
                                  function: () {
                                    if (formKey.currentState.validate()) {
                                      cubit.register(UserBodyRegister(
                                          phone:
                                              phoneTextEditingController.text,
                                          name: nameTextEditingController.text,
                                          email:
                                              emailTextEditingController.text,
                                          password:
                                              passwordTextEditingController
                                                  .text));
                                      print("email: " +
                                          emailTextEditingController.text +
                                          ", password: " +
                                          passwordTextEditingController.text);
                                    }
                                  },
                                  text: 'Register');
                            },
                            fallback: (context) {
                              return centerProgressBar();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }, listener: (context, state) {
          if (state is RegisterSuccessfulState) {
            showToast(
                text: "Successfully Registered", state: ToastStates.SUCCESS);
            DioHelper.init();
            navigateAndRemove(context: context, widget: HomeLayout());
          } else if (state is RegisterErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          return;
        }));
  }
}

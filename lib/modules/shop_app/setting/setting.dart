import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/home_layout/cubit/cubit.dart';
import 'package:first_app/layout/home_layout/cubit/states.dart';
import 'package:first_app/model/user/shop/user_body_register.dart';
import 'package:first_app/modules/shop_app/login/login_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/local/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    cubit.getUserDataResponse();
    return BlocConsumer<ShopCubit, ShopStates>(builder: (context, state) {
      return ConditionalBuilder(
          condition: cubit.userModule != null,
          builder: (BuildContext context) {
            emailTextEditingController.text = cubit.userModule.data.email;
            nameTextEditingController.text = cubit.userModule.data.name;
            phoneTextEditingController.text = cubit.userModule.data.phone;
            return Scaffold(
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            defaultFromField(
                                controller: nameTextEditingController,
                                textInputType: TextInputType.text,
                                prefixIcon: Icon(Icons.person),
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return "name must not be null";
                                  }
                                  return null;
                                },
                                labelText: 'Name'),
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
                            SizedBox(
                              height: 20,
                            ),
                            ConditionalBuilder(
                              condition: state is! UpdateLoadingState,
                              builder: (context) {
                                return defaultButton(
                                    function: () {
                                      if (formKey.currentState.validate()) {
                                        cubit.updateUserData(UserBodyUpdate(
                                          phone:
                                              phoneTextEditingController.text,
                                          name: nameTextEditingController.text,
                                          email:
                                              emailTextEditingController.text,
                                        ));
                                      }
                                    },
                                    text: 'Update Data');
                              },
                              fallback: (context) {
                                return centerProgressBar();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultButton(
                                background: Colors.black54,
                                function: () {
                                  logout(context, cubit);
                                },
                                text: 'Logout')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => centerProgressBar());
    }, listener: (context, state) {
      if (state is UpdateSuccessfulState) {
        showToast(text: "Updated Registered", state: ToastStates.SUCCESS);
      } else if (state is UpdateErrorState) {
        showToast(text: state.error, state: ToastStates.ERROR);
      }
      return;
    });
  }

  void logout(context, ShopCubit shopCubit) {
    SharedPreferencesHelper.removeData(
      key: TOKEN,
    ).then((value) {
      if (value) {
        navigateAndRemove(
          widget: LoginScreen(),
          context: context,
        );
      }
      shopCubit.currentIndex = 0;
    });
  }
}

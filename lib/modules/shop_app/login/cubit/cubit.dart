import 'package:first_app/model/user/shop/user_body.dart';
import 'package:first_app/model/user/shop/user_body_register.dart';
import 'package:first_app/model/user/shop/user_data.dart';
import 'package:first_app/modules/shop_app/login/cubit/states.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/local/shared_helper.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  var isObscureText = true;

  LoginCubit() : super(LoginStatesInit());

  static LoginCubit get(context) => BlocProvider.of(context);

  void setObscure() {
    isObscureText = !isObscureText;

    emit(LoginStatesObscure());
  }

  void login(String email, String password) {
    UserBody userBody = UserBody(email: email, password: password);
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, body: userBody.toJson()).then((value) {
      UserResponse userResponse = UserResponse.fromJson(value.data);
      if (userResponse.status) {
        SharedPreferencesHelper.putSharedLocalData(
            key: TOKEN, value: userResponse.data.token);
        print("userResponse ${userResponse.toString()}");
        emit(LoginSuccessfulState());
      } else {
        print(onError);
        emit(LoginUserCredentialsErrorState(userResponse.message));
      }
    }).catchError((onError) {
      print(onError);
      emit(LoginErrorState(onError.toString()));
    });
  }

  void register(UserBodyRegister userBody) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: Register, body: userBody.toJson()).then((value) {
      UserResponse userResponse = UserResponse.fromJson(value.data);
      if (userResponse.status) {
        SharedPreferencesHelper.putSharedLocalData(
            key: TOKEN, value: userResponse.data.token);
        print("userResponse ${userResponse.toString()}");
        emit(RegisterSuccessfulState());
      } else {
        print(onError);
        emit(RegisterErrorState(userResponse.message));
      }
    }).catchError((onError) {
      print(onError);
      emit(RegisterErrorState(onError.toString()));
    });
  }
}

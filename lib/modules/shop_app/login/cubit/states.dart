abstract class LoginStates {}

class LoginStatesInit extends LoginStates {}

class LoginStatesObscure extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessfulState extends LoginStates {}

class LoginUserCredentialsErrorState extends LoginStates {
  final String message;
  LoginUserCredentialsErrorState(this.message);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends LoginStates {}

class RegisterSuccessfulState extends LoginStates {}

class RegisterErrorState extends LoginStates {
  final String error;
  RegisterErrorState(this.error);
}

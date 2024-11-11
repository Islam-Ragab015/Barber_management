

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

class LoginEmailNotVerified extends LoginState {}

class LoginPasswordVisibilityChanged extends LoginState {}

class EmailVerificationSent extends LoginState {}

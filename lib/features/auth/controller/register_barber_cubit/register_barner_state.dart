abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationImagePicked extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final String error;
  RegistrationError(this.error);
}

class PasswordHiddenState extends RegistrationState {
  final bool isPasswordHidden;
  PasswordHiddenState({this.isPasswordHidden = true});
}

class PasswordMatchState extends RegistrationState {
  final bool passwordsMatch;

  PasswordMatchState({
    this.passwordsMatch = true,
  });
}

class PasswordConfirmHiddenState extends RegistrationState {
  final bool isConfirmPasswordHidden;
  PasswordConfirmHiddenState({this.isConfirmPasswordHidden = true});
}

class UploadBackgroundImageLoading extends RegistrationState {}

class UploadBackgroundImageSuccess extends RegistrationState {}

class UploadBackgroundImageError extends RegistrationState {
  String error;
  UploadBackgroundImageError(this.error);
}

class UploadProfileImageLoading extends RegistrationState {}

class UploadProfileImageSuccess extends RegistrationState {}

class UploadProfileImageError extends RegistrationState {
  String error;
  UploadProfileImageError(this.error);
}

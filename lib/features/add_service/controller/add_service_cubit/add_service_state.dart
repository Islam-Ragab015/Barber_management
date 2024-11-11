part of 'add_service_cubit.dart';

@immutable
sealed class AddServiceState {}

final class AddServiceInitial extends AddServiceState {}

class ImagePicked extends AddServiceState {}

class ImagePickedError extends AddServiceState {
  final String error;
  ImagePickedError(this.error);
}

class UploadImageLoading extends AddServiceState {}

class UploadImageSuccess extends AddServiceState {}

class UploadImageError extends AddServiceState {
  final String error;
  UploadImageError(this.error);
}

class AddServiceLoading extends AddServiceState {}

class AddServiceSuccess extends AddServiceState {}

class AddServiceError extends AddServiceState {
  final String error;
  AddServiceError(this.error);
}

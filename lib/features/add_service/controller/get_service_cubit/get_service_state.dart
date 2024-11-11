part of 'get_service_cubit.dart';

@immutable
sealed class GetServiceState {}

final class GetServiceInitial extends GetServiceState {}

final class GetServiceLoading extends GetServiceState {}

final class GetServiceSuccess extends GetServiceState {
  final List<SeviceModel> services;
  GetServiceSuccess(this.services);
}

final class GetServiceError extends GetServiceState {
  final String error;
  GetServiceError(this.error);
}

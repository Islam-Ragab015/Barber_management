class AppointmentModel {
  String? barberId;
  String? userId;
  String? appointmentId;
  String? status;

  AppointmentModel({
    this.barberId,
    this.userId,
    this.appointmentId,
    this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      barberId: json['barberId'],
      userId: json['userId'],
      appointmentId: json['appointmentId'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barberId': barberId,
      'userId': userId,
      'appointmentId': appointmentId,
      'status': status,
    };
  }
}

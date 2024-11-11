import 'package:flutter/material.dart';
import 'package:barber/models/appointment_model.dart';

class AppointmentProvider with ChangeNotifier {
  final List<AppointmentModel> _appointments = [];

  List<AppointmentModel> get appointments => _appointments;

  void addAppointment(AppointmentModel appointment) {
    _appointments.add(appointment);
    notifyListeners(); // Notify listeners to rebuild UI when appointments are added
  }
}

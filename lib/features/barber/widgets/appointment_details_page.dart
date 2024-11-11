import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final String clientName;
  final String serviceType;
  final String timeSlot;
  final String date;
  final String barberName;
  final double price;
  final String status;
  final String appointmentId;

  const AppointmentDetailsPage({
    super.key,
    required this.appointmentId,
    required this.clientName,
    required this.serviceType,
    required this.timeSlot,
    required this.date,
    required this.barberName,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$clientName\'s Appointment',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.teal[50],
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appointment Details',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(Icons.workspace_premium, 'Service:',
                            serviceType, screenWidth),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                            Icons.access_time, 'Time:', timeSlot, screenWidth),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                            Icons.calendar_today, 'Date:', date, screenWidth),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                            Icons.person, 'Barber:', barberName, screenWidth),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.attach_money, 'Price:',
                            '\$${price.toStringAsFixed(2)}', screenWidth),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                            Icons.check_circle, 'Status:', status, screenWidth),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Action buttons
                _buildButtonRow(context, screenWidth),
                const SizedBox(height: 10),
                _buildButtonRow2(context, screenWidth),
                const SizedBox(height: 10),
                _buildAdditionalButtonsRow(context, screenWidth),
                const SizedBox(height: 10),
                _buildFinalButtonsRow(context, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String title, String value, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.teal[700]),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.teal[700],
              ),
            ),
          ],
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.045,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton('Confirm', Colors.teal, () {
          confirmAppointment(context);
          // showCustomToast(context, "Confirmed appointment.", Colors.teal);
        }),
        _buildActionButton('Cancel', Colors.red, () {
          cancelAppointment(context);
          // showCustomToast(context, "Cancelled appointment.", Colors.red);
        }),
        _buildActionButton('Reschedule', Colors.orange, () {
          showCustomToast(context, "Appointment rescheduled.", Colors.orange);
        }),
      ],
    );
  }

  Widget _buildButtonRow2(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton('Mark Completed', Colors.green, () {
          showCustomToast(context, "Marked as completed.", Colors.green);
        }),
        _buildActionButton('Leave Note', Colors.blue, () {
          showCustomToast(context, "Note added.", Colors.blue);
        }),
      ],
    );
  }

  Widget _buildAdditionalButtonsRow(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton('View History', Colors.purple, () {
          showCustomToast(context, "Viewing history.", Colors.purple);
        }),
        _buildActionButton('Add Service', Colors.deepOrange, () {
          showCustomToast(context, "Added service.", Colors.deepOrange);
        }),
      ],
    );
  }

  Widget _buildFinalButtonsRow(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton('Modify Appointment', Colors.lightBlue, () {
          showCustomToast(context, "Modifying appointment.", Colors.lightBlue);
        }),
        _buildActionButton('Send Reminder', Colors.pink, () {
          showCustomToast(context, "Reminder sent.", Colors.pink);
        }),
      ],
    );
  }

  // Custom FlutterToast function with modern UI
  void showCustomToast(
      BuildContext context, String message, Color backgroundColor) {
    final screenWidth = MediaQuery.of(context).size.width;

    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: Colors.white),
          const SizedBox(width: 12.0),
          Flexible(
            child: Text(
              message,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 4),
    );
  }

  void confirmAppointment(BuildContext context) async {
    if (status == 'pending') {
      CollectionReference appointments =
          FirebaseFirestore.instance.collection('appointments');

      // Create a new appointment document
      await appointments
          .doc(
        appointmentId,
      )
          .update({
        'status': 'confirmed',
      });
      showCustomToast(context, "Confirmed appointment.", Colors.teal);

      Navigator.pop(context);
    } else {
      showCustomToast(context, "Already confirmed.", Colors.teal);
    }
  }

  void cancelAppointment(BuildContext context) async {
    if (status == 'pending') {
      CollectionReference appointments =
          FirebaseFirestore.instance.collection('appointments');

      // Create a new appointment document
      await appointments
          .doc(
        appointmentId,
      )
          .update({
        'status': 'cancelled',
      });
      showCustomToast(context, "Cancelled appointment.", Colors.red);

      Navigator.pop(context);
    } else {
      showCustomToast(context, "Already cancelled.", Colors.red);
    }
  }
}

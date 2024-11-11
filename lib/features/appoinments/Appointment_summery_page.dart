import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentSummaryPage extends StatefulWidget {
  const AppointmentSummaryPage({super.key});

  @override
  State<AppointmentSummaryPage> createState() => _AppointmentSummaryPageState();
}

class _AppointmentSummaryPageState extends State<AppointmentSummaryPage> {
  @override
  void initState() {
    getAppointments();
    super.initState();
  }

  List appointments = [];
  bool loading = false;
  getAppointments() async {
    setState(() {
      loading = true;
    });
    // get appointments
    appointments = await getAppointment();
    setState(() {
      loading = false;
    });
  }

  Future getAppointment() async {
    CollectionReference appointments =
        FirebaseFirestore.instance.collection('appointments');
    QuerySnapshot querySnapshot = await appointments
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        )
        .get();
    return querySnapshot.docs;
  }

  @override
  build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Appointments"),
        backgroundColor: Colors.blueGrey[900],
        elevation: 10,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : appointments.isEmpty
              ? const Center(
                  child: Text(
                    "No appointments booked yet.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    getAppointments();
                  },
                  child: ListView.builder(
                    itemCount: appointments.length,
                    padding: EdgeInsets.all(
                        screenWidth * 0.03), // Responsive padding
                    itemBuilder: (context, index) {
                      Timestamp timestamp =
                          appointments[index]['appointmentDate'];
                      String time = appointments[index]['appointmentTime'];

                      // Convert Timestamp to DateTime
                      DateTime appointmentDate = timestamp.toDate();

                      // Format the date
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(appointmentDate);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5, // Adjusted elevation
                        shadowColor: Colors.black.withOpacity(0.3),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.cyanAccent, Colors.blueAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: 15.0), // Responsive padding
                            leading: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 30,
                            ),
                            title: Text(
                              "Date: $formattedDate", // Set the formatted date
                              style: TextStyle(
                                fontSize:
                                    screenWidth * 0.05, // Responsive font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "Time: $time", // Keep the time as is
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

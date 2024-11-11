// presentation/views/dashboard_view.dart
import 'package:barber/features/barber/views/appointment_details.dart';
import 'package:barber/features/barber/views/settings_view.dart';
import 'package:barber/features/barber/views/stats_view.dart';
import 'package:barber/features/barber/widgets/appointment_card.dart';
import 'package:barber/models/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarberDashboard extends StatefulWidget {
  const BarberDashboard({super.key});

  @override
  _BarberDashboardState createState() => _BarberDashboardState();
}

class _BarberDashboardState extends State<BarberDashboard> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages.add(const HomeBody());
    _pages.add(const StatsView());
    _pages.add(const SettingsView());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal, // App bar color
        elevation: 8,
        title: Text(
          'Barber Dashboard',
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: _onItemTapped,
      ),
      body: _pages[_selectedIndex], // Show the selected page
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    getservices();
    super.initState();
  }

  List<AppointmentModel> services = [];
  bool loading = false;
  Future getservices() async {
    setState(() {
      loading = true;
    });
    // get services

    services = await getAppointment();

    setState(() {
      loading = false;
    });
  }

  Future<List<AppointmentModel>> getAppointment() async {
    CollectionReference services =
        FirebaseFirestore.instance.collection('appointments');
    QuerySnapshot querySnapshot = await services
        .where(
          'barberId',
          isEqualTo: FirebaseAuth.instance.currentUser?.email,
        )
        .get();

    return querySnapshot.docs
        .map((doc) =>
            AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Appointments',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await getservices();
                      },
                      child: ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              AppointmentCard(
                                  status: services[index].status ?? '',
                                  appointmentId:
                                      services[index].appointmentId ?? '',
                                  appointment: appointments[index]),
                              const SizedBox(
                                  height:
                                      16), // Adjust this value for more space
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

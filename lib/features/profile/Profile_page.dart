import 'package:barber/features/appoinments/Appointment_summery_page.dart';
import 'package:barber/features/auth/view/User_type_screen.dart';
import 'package:barber/features/data_performance/data_performance_page.dart';
import 'package:barber/features/favourite/favorites_page.dart';
import 'package:barber/features/profile/user_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final List<Map<String, dynamic>> appointments;

  const ProfilePage({super.key, required this.appointments});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  String? phone;

  String? bio;

  String? name;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Profile Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar with Gradient Border
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      "IR",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Islam Ragab Ahmed",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),

                // Profile Options
                Expanded(
                  child: ListView(
                    children: [
                      _buildStylishListTile(
                        context,
                        Icons.person,
                        "Your Details",
                        () => _navigateToUserDetails(context),
                      ),
                      _buildStylishListTile(
                        context,
                        Icons.favorite,
                        "Favorites",
                        () => _navigateToFavorites(context),
                      ),
                      _buildStylishListTile(
                        context,
                        Icons.calendar_today,
                        "Your Appointments",
                        () => _navigateToAppointments(context),
                      ),
                      _buildStylishListTile(
                        context,
                        Icons.settings,
                        "Data Preferences",
                        () => _navigateToSettings(context),
                      ),
                      _buildStylishListTile(
                        context,
                        Icons.logout,
                        "Logout",
                        () => _handleLogout(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to style the ListTile
  Widget _buildStylishListTile(
      BuildContext context, IconData icon, String title, Function onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      shadowColor: Colors.blueGrey.withOpacity(0.3),
      child: SizedBox(
        height: 60,
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
          onTap: () => onTap(),
          tileColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }

  Future getUserData() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot.get('name');

        bio = documentSnapshot.get('bio');

        phone = documentSnapshot.get('phone');

        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  // Navigation methods
  void _navigateToUserDetails(BuildContext context) async {
    getUserData().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsPage(
              bio: bio ?? '',
              name: name ?? '',
              phone: phone ?? '',
            ),
          ),
        ));
  }

  void _navigateToFavorites(BuildContext context) {
    final favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavoritesPage(favoriteShops: [{}]),
      ),
    );
  }

  void _navigateToAppointments(BuildContext context) {
    if (widget.appointments.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AppointmentSummaryPage(),
        ),
      );
    }
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DataPreferencesPage(),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    // Add your logout logic here, e.g., clearing user session, redirecting to login page
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Clear user session and navigate to login page
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UserTypeScreen())); // Example
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

class FavoritesProvider with ChangeNotifier {
  List<String> favoriteShops = []; // Replace with your model
}

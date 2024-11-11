import 'package:barber/features/auth/view/User_type_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade100,
              Colors.teal.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionCard(
              title: 'Account Settings',
              children: [
                _buildListTile(
                  title: 'Profile',
                  subtitle: 'Update your personal information',
                  onTap: () {
                    // Handle profile tap
                  },
                ),
                _buildListTile(
                  title: 'Change Password',
                  subtitle: 'Update your password',
                  onTap: () {
                    // Handle change password tap
                  },
                ),
              ],
            ),
            _buildSectionCard(
              title: 'Appointment Settings',
              children: [
                _buildListTile(
                  title: 'Manage Appointments',
                  subtitle: 'View and manage your appointments',
                  onTap: () {
                    // Handle manage appointments tap
                  },
                ),
                _buildListTile(
                  title: 'Notifications',
                  subtitle: 'Set notification preferences',
                  onTap: () {
                    // Handle notifications tap
                  },
                ),
              ],
            ),
            _buildSectionCard(
              title: 'Barber Shop Settings',
              children: [
                _buildListTile(
                  title: 'Services Offered',
                  subtitle: 'Manage the services you offer',
                  onTap: () {
                    // Handle services offered tap
                  },
                ),
                _buildListTile(
                  title: 'Pricing',
                  subtitle: 'Set prices for your services',
                  onTap: () {
                    // Handle pricing tap
                  },
                ),
              ],
            ),
            _buildSectionCard(
              title: 'App Settings',
              children: [
                _buildListTile(
                  title: 'Language',
                  subtitle: 'Change app language',
                  onTap: () {
                    // Handle language tap
                  },
                ),
                _buildListTile(
                  title: 'Theme',
                  subtitle: 'Switch between light and dark themes',
                  onTap: () {
                    // Handle theme change tap
                  },
                ),
                _buildStylishListTile(
                  context,
                  Icons.logout,
                  "Logout",
                  () => _handleLogout(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to style the ListTile
  Widget _buildStylishListTile(
      BuildContext context, IconData icon, String title, Function onTap) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 60,
      child: ListTile(
        // leading: Container(
        //   padding: const EdgeInsets.all(8.0),
        //   decoration: BoxDecoration(
        //     color: Colors.red[900],
        //     shape: BoxShape.circle,
        //   ),
        //   child: Icon(icon, color: Colors.white, size: 24),
        // ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
        onTap: () => onTap(),
        tileColor: Colors.white,
        // contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
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

  Widget _buildSectionCard(
      {required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(title),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
      {required String title, String? subtitle, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.teal[800],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'register_barber_screen.dart';
import 'register_uesr_screen.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 70,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegisterScreen();
                    }));
                  },
                  child: const Text(
                    'Sigin as Customer',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 70,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegistrationBarberScreen();
                    }));
                  },
                  child: const Text('  Sigin as barber  ',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 20))),
            ),
          ],
        ),
      ),
    );
  }
}

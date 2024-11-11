import 'package:barber/core/component/custom_botton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../home/HomePage.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.barberId,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedServices,
  });
  final String? barberId;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final List<Map<String, dynamic>> selectedServices;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cvvCode = TextEditingController();
  bool isCvvFocused = false;

  bool isloading = false;
  paymentMethod() async {
    setState(() {
      isloading = true;
    });

    if (!formKey.currentState!.validate()) {
      setState(() {
        isloading = false;
      });
      return;
    }
    await Future.delayed(const Duration(seconds: 2), () {});
    if (cardNumber.text == '0000 0000 0000 0000') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment Successfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        isloading = false;
      });
      _addAppointment();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid card number'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        isloading = false;
      });
      return;
    }
  }

  void onCreditCardModelChange(CreditCardModel? data) {
    if (data != null) {
      cardNumber.text = data.cardNumber;
      expiryDate.text = data.expiryDate;
      cardHolderName.text = data.cardHolderName;
      cvvCode.text = data.cvvCode;
      isCvvFocused = data.isCvvFocused;
    }
    setState(() {});
  }

  void _addAppointment() async {
    try {
      // Create a reference to the Firestore collection
      CollectionReference appointments =
          FirebaseFirestore.instance.collection('appointments');

      // Convert TimeOfDay to a string format (e.g., "HH:mm")
      String appointmentTime = widget.selectedTime!.format(context);

      // Create a new appointment document
      await appointments.add({
        'appointmentId': '',
        'status': 'pending',
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'barberId': widget.barberId,
        'services': widget
            .selectedServices, // Assuming this is a List<Map<String, dynamic>>
        'appointmentDate': widget.selectedDate,
        'appointmentTime': appointmentTime, // Store as string
        'createdAt': FieldValue.serverTimestamp(),
      }).then((value) => {'appointmentId': value.id});

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment booked successfully!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to book appointment: $e'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Payment',
            style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 2)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreditCardWidget(
              cardBgColor: Colors.black,
              cardNumber: cardNumber.text,
              expiryDate: expiryDate.text,
              cardHolderName: cardHolderName.text,
              cvvCode: cvvCode.text,
              showBackView: isCvvFocused,
              cardType: CardType.mastercard,
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  formKey: formKey,
                  cardNumber: cardNumber.text,
                  expiryDate: expiryDate.text,
                  cardHolderName: cardHolderName.text,
                  cvvCode: cvvCode.text,
                  onCreditCardModelChange: (CreditCardModel creditCardModel) {
                    onCreditCardModelChange(creditCardModel);
                  },
                  obscureCvv: true,
                  obscureNumber: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: CustomBottom(
                        color1: Colors.red,
                        color2: Colors.orange,
                        text: 'Payment Now',
                        onTap: () {
                          paymentMethod();
                        },
                        isloading: !isloading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

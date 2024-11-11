import 'package:barber/features/barber/views/barber_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/function/push_screen.dart';
import '../../../../core/utils/cashe_helper.dart';
import '../../../home/HomePage.dart';
import 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  IconData passwordIcon = Icons.remove_red_eye_outlined;

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(LoginLoading());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user!.emailVerified) {
        emit(LoginEmailNotVerified());
      } else {
        CacheHelper.setEmail(email);
        documentExists(email).then((value) {
          if (value) {
            pushAndRemoveUntil(
              context: context,
              screen: const BarberDashboard(),
            );
            // TODO
          } else {
            pushAndRemoveUntil(
              context: context,
              screen: const HomePage(),
            );
          }
        });

        emit(LoginSuccess());
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<bool> documentExists(String documentId) async {
    try {
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Barbers')
          .doc(documentId)
          .get();
      return doc.exists;
    } catch (e) {
      print('Error checking document existence: $e');
      return false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    passwordIcon = isPasswordVisible
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityChanged());
  }

  void sendEmailVerification() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    emit(EmailVerificationSent());
  }
}

import 'dart:io';
import 'dart:math';
import 'package:barber/features/barber/views/barber_dashboard.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/cashe_helper.dart';
import 'register_barner_state.dart';

// States for RegistrationCubit
class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  String? userId;
  String? profileUrl;
  String? coverUrl;
  final storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  File? backgroundImage;
  File? profileImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController rePasswordTextController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late CollectionReference users =
      FirebaseFirestore.instance.collection('Barbers');

  Future<void> registerBarber({
    required String email,
    required String password,
  }) async {
    emit(RegistrationLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        value.user?.sendEmailVerification();
      });
    } catch (e) {}
  }

  int rand = Random().nextInt(9999999);

  Future<void> pickBackgroundImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      backgroundImage = File(pickerFile.path);
      emit(RegistrationImagePicked());
    } else {
      emit(RegistrationError('No Image Selected'));
    }
  }

  Future<void> pickProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(RegistrationImagePicked());
    } else {
      emit(RegistrationError('No Image Selected'));
    }
  }

  Future<void> uploadProfileImage() async {
    if (profileImage != null) {
      emit(UploadProfileImageLoading());
      try {
        var uploadTask = await storage
            .ref()
            .child(
                'users/$userId/$rand${Uri.file(profileImage!.path).pathSegments.last}')
            .putFile(profileImage!);
        profileUrl = await uploadTask.ref.getDownloadURL();
        emit(UploadProfileImageSuccess());
      } on firebase_core.FirebaseException catch (e) {
        emit(UploadProfileImageError(e.toString()));
      }
    }
  }

  Future<void> uploadBackgroundImage() async {
    if (backgroundImage != null) {
      emit(UploadProfileImageLoading());
      try {
        var uploadTask = await storage
            .ref()
            .child(
                'users/$userId/$rand${Uri.file(backgroundImage!.path).pathSegments.last}')
            .putFile(backgroundImage!);
        coverUrl = await uploadTask.ref.getDownloadURL();
        emit(UploadBackgroundImageSuccess());
      } on firebase_core.FirebaseException catch (e) {
        emit(UploadBackgroundImageError(e.toString()));
      }
    }
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
    String? bio,
    String? phone,
  }) async {
    emit(RegistrationLoading());
    try {
      if (profileImage != null) {
        await uploadProfileImage();
      }
      if (backgroundImage != null) {
        await uploadBackgroundImage();
      }
      await registerBarber(email: email, password: password).then((_) async {
        await users.doc(email).set({
          'name': name,
          'email': email,
          'password': password,
          'bio': bio,
          'phone': phone,
          'profileImage': profileUrl,
          'coverImage': coverUrl,
        });
      });
      CacheHelper.setEmail(email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BarberDashboard(),
        ),
      );
      emit(RegistrationSuccess());
    } catch (e) {
      emit(RegistrationError(e.toString()));
    }
  }

  // Toggle password visibility
  bool isPasswordHidde = true;
  bool isConfirmPasswordHidde = true;
  void togglePasswordVisibility() {
    isPasswordHidde = !isPasswordHidde;
    emit(PasswordHiddenState(isPasswordHidden: isPasswordHidde));
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidde = !isConfirmPasswordHidde;
    emit(PasswordConfirmHiddenState(
        isConfirmPasswordHidden: isConfirmPasswordHidde));
  }

  void checkPasswordsMatch() {
    final password = passwordTextController.text;
    final confirmPassword = rePasswordTextController.text;
    emit(PasswordMatchState(passwordsMatch: password == confirmPassword));
  }
}

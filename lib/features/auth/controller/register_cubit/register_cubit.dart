import 'package:barber/core/function/push_screen.dart';
import 'package:barber/features/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/cashe_helper.dart';
import '../../models/user_model.dart';

class RegisterState {
  final bool isPasswordHidden;
  final bool isLoading;
  final bool passwordsMatch;
  final bool isEmailVerified;

  RegisterState({
    this.isPasswordHidden = true,
    this.isLoading = false,
    this.passwordsMatch = true,
    this.isEmailVerified = false,
  });

  RegisterState copyWith({
    bool? isPasswordHidden,
    bool? isLoading,
    bool? passwordsMatch,
    bool? isEmailVerified,
  }) {
    return RegisterState(
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isLoading: isLoading ?? this.isLoading,
      passwordsMatch: passwordsMatch ?? this.passwordsMatch,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController rePasswordTextController =
      TextEditingController();

  String? userId;
  late CreateUserModel model;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  Future<void> signUp(BuildContext context) async {
    if (passwordTextController.text != rePasswordTextController.text) {
      emit(state.copyWith(passwordsMatch: false));
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      await auth
          .createUserWithEmailAndPassword(
              email: emailTextController.text,
              password: passwordTextController.text)
          .then((value) async {
        value.user?.sendEmailVerification();
        CacheHelper.setEmail(emailTextController.text);

        userId = FirebaseAuth.instance.currentUser?.uid;
        model = CreateUserModel(
          email: emailTextController.text,
          name: nameTextController.text,
          image:
              'https://th.bing.com/th/id/R.b9941d2d7120044bd1d8e91c5556c131?rik=sDJfLfGGErT9Fg&pid=ImgRaw&r=0',
        );
        await _createUser(model);

        emit(state.copyWith(isEmailVerified: true, isLoading: false));
        pushAndRemoveUntil(
          context: context,
          screen: const HomePage(),
        );
      });
    } catch (e) {
      print(e);
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _createUser(CreateUserModel userModel) async {
    if (userModel.email!.isNotEmpty) {
      await users.doc(userId).set(userModel.toJson());
    }
  }

  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    rePasswordTextController.dispose();
    phoneTextController.dispose();
  }
}

import 'package:barber/features/auth/view/register_uesr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../../../core/component/custom_botton.dart';
import '../../../core/component/custom_textformfield.dart';
import '../controller/login/login_cubit.dart';
import '../controller/login/login_cubit_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 263, 10, 263),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 1, 41),
                    child: const Text(
                      'Log-in',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      final cubit = context.read<LoginCubit>();
                      return Column(
                        children: [
                          CustomTextFormField(
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'E-mail',
                            hintText: 'E-mail',
                            textController: cubit.emailController,
                            validator: ValidationBuilder()
                                .email()
                                .maxLength(50)
                                .build(),
                          ),
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            labelText: 'Password',
                            hintText: 'Password',
                            ispassword: cubit.isPasswordVisible,
                            suffix: IconButton(
                              onPressed: cubit.togglePasswordVisibility,
                              icon: Icon(cubit.passwordIcon),
                            ),
                            textController: cubit.passwordController,
                            validator: ValidationBuilder()
                                .minLength(6)
                                .maxLength(50)
                                .build(),
                          ),
                          const SizedBox(height: 20),
                          state is LoginLoading
                              ? const CircularProgressIndicator()
                              : CustomBottom(
                                  text: 'Submit',
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.login(
                                        email: cubit.emailController.text,
                                        password: cubit.passwordController.text,
                                        context: context,
                                      );
                                    }
                                  },
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (state is LoginEmailNotVerified)
                            Container(
                              color: const Color.fromARGB(255, 0, 26, 255),
                              height: 50,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    const Text('Verify your email'),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        cubit.sendEmailVerification();
                                      },
                                      child: const Text(
                                        'Send',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (state is LoginError)
                            Text(
                              (state).error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          const SizedBox(height: 100),
                          Row(
                            children: [
                              const Text(
                                'If you don’t have an account please ',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ));
                                },
                                child: const Text('Register',
                                    style: TextStyle(
                                      color: Color(0xff3356d2),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

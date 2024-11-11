import 'package:barber/features/auth/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/component/custom_botton.dart';
import '../../../core/component/custom_textformfield.dart';
import 'package:form_validator/form_validator.dart';
import '../controller/register_cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          final cubit = context.read<RegisterCubit>();

          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 150, 15, 195),
                width: double.infinity,
                child: Form(
                  key: GlobalKey<
                      FormState>(), // Make sure to use the formKey from cubit if needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        labelText: 'Name',
                        hintText: 'Name',
                        fieldType: TextInputType.name,
                        textController: cubit.nameTextController,
                        validator: ValidationBuilder()
                            .minLength(5)
                            .maxLength(50)
                            .build(),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: 'E-mail',
                        hintText: 'E-mail',
                        fieldType: TextInputType.emailAddress,
                        textController: cubit.emailTextController,
                        validator:
                            ValidationBuilder().email().maxLength(50).build(),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: 'Phone',
                        hintText: 'Phone',
                        fieldType: TextInputType.phone,
                        textController: cubit.phoneTextController,
                        validator: ValidationBuilder().phone().build(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'Password',
                              ispassword: state.isPasswordHidden,
                              textController: cubit.passwordTextController,
                              suffix: IconButton(
                                icon: Icon(state.isPasswordHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  cubit.togglePasswordVisibility();
                                },
                              ),
                              validator: ValidationBuilder()
                                  .minLength(3)
                                  .maxLength(50)
                                  .build(),
                              hintText: 'password',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'Confirm Password',
                              ispassword: state.isPasswordHidden,
                              textController: cubit.rePasswordTextController,
                              validator: ValidationBuilder()
                                  .maxLength(3)
                                  .maxLength(50)
                                  .build(),
                              hintText: 'Confirm Password',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (!state.passwordsMatch)
                        const Text(
                          "Passwords do not match",
                          style: TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 10),
                      state.isLoading
                          ? const CircularProgressIndicator()
                          : CustomBottom(
                              text: 'Submit',
                              onTap: () {
                                cubit.signUp(context);
                              },
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            },
                            child: const Text('Log in'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

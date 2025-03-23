import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:nutritionforlife/constants.dart';
import 'package:nutritionforlife/features/auth/presention/cubit/signup_state/sign_up_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: "Username"),
          TextFormField(
            controller: _userNameController,
            decoration: InputDecoration(hintText: "theflutterway"),
            validator:
                RequiredValidator(errorText: "Username is required").call,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Email"),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "test@email.com"),
            validator: EmailValidator(errorText: "Use a valid email!").call,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Phone"),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: "+123487697"),
            validator:
                RequiredValidator(errorText: "Phone number is required").call,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Password"),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "******"),
            validator: passwordValidator.call,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Confirm Password"),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "*****"),
            validator: (pass) {
              if (pass != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          const SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                bool isLoading = state is SignUpLoading;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding,
                    ),
                  ),
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            if (widget.formKey.currentState!.validate()) {
                              context
                                  .read<SignUpCubit>()
                                  .createUserWithEmailAndPassword(
                                    _emailController.text.trim(),
                                    _passwordController.text,
                                    _userNameController.text.trim(),
                                  );
                            }
                          },
                  child:
                      isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}

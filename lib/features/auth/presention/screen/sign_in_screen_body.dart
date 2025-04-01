import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutritionforlife/constants.dart';
import 'package:nutritionforlife/features/auth/presention/cubit/signin_cubit/sign_in_cubit.dart';
import 'package:nutritionforlife/features/auth/presention/screen/signup_view.dart';
import 'package:nutritionforlife/features/auth/presention/screen/widgets/components/sign_in_form.dart';
import 'package:nutritionforlife/features/home/screen/home_view.dart';

class SignInScreenBody extends StatefulWidget {
  const SignInScreenBody({super.key});

  @override
  State<SignInScreenBody> createState() => _SignInScreenBodyState();
}

class _SignInScreenBodyState extends State<SignInScreenBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Login successful!')));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
            // ممكن تنقل المستخدم لصفحة تانية هنا بعد النجاح
            // Navigator.pushReplacement(...);
          } else if (state is SignInError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(
              "assets/icons/Sign_Up_bg.svg",
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupView(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      SignInForm(
                        formKey: _formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<SignInCubit, SignInState>(
                          builder: (context, state) {
                            bool isLoading = state is SignInLoading;
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
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          context
                                              .read<SignInCubit>()
                                              .signInWithEmailAndPassword(
                                                emailController.text.trim(),
                                                passwordController.text.trim(),
                                              );
                                        }
                                      },
                              child:
                                  isLoading
                                      ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : const Text(
                                        "Sign In",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                        ),
                                      ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      Center(
                        child: GoogleAuthButton(
                          onPressed: () {
                            context.read<SignInCubit>().signInWithGoogle();
                          },

                          style: AuthButtonStyle(
                            margin: const EdgeInsets.only(bottom: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

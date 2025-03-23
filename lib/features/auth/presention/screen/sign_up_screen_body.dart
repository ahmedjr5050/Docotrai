import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutritionforlife/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutritionforlife/features/auth/presention/cubit/signup_state/sign_up_cubit.dart';
import 'package:nutritionforlife/features/auth/presention/screen/sign_in_screen_body.dart';
import 'package:nutritionforlife/features/auth/presention/screen/signin.dart';
import 'package:nutritionforlife/features/auth/presention/screen/widgets/components/sign_up_form.dart';

class SignUpScreenBody extends StatelessWidget {
  // It's time to validat the text field
  final _formKey = GlobalKey<FormState>();

  SignUpScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Account created successfully!')),
            );
            // ممكن تنقله لصفحة تسجيل الدخول:
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SigninView()));
          } else if (state is SignUpError) {
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
              // Now it takes 100% of our height
            ),
            Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("Already have an account?"),
                          TextButton(
                            onPressed:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SigninView(),
                                  ),
                                ),
                            child: Text(
                              "Sign In!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      SignUpForm(formKey: _formKey),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutritionforlife/core/services/getit_services.dart';
import 'package:nutritionforlife/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nutritionforlife/features/auth/presention/cubit/signup_state/sign_up_cubit.dart';
import 'package:nutritionforlife/features/auth/presention/screen/sign_up_screen_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt<AuthRepoImpl>()),
      child: Builder(builder: (context) => SignUpScreenBody()),
    );
  }
}

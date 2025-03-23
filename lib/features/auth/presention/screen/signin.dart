import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutritionforlife/core/services/getit_services.dart';
import 'package:nutritionforlife/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nutritionforlife/features/auth/presention/cubit/signin_cubit/sign_in_cubit.dart';
import 'package:nutritionforlife/features/auth/presention/screen/sign_in_screen_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getIt<AuthRepoImpl>()),
      child: Builder(
        builder: (context) => SignInScreenBody(),
      ),
    );
  }
}


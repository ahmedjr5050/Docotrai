import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nutritionforlife/core/services/getit_services.dart';
import 'package:nutritionforlife/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nutritionforlife/features/auth/presention/cubit/signin_cubit/sign_in_cubit.dart';
import 'package:nutritionforlife/features/home/domain/repos/prediction_repo.dart';
import 'package:nutritionforlife/features/home/screen/cubit/doctorai_cubit.dart';
import 'package:nutritionforlife/features/home/screen/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignInCubit(getIt<AuthRepoImpl>())),
        BlocProvider(
          create: (context) => PredictionCubit(getIt<PredictionRepo>()),
        ),
      ],
      child: Scaffold(body: PredictionScreen()),
    );
  }
}

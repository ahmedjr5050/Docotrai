import 'package:flutter/material.dart';
import 'package:nutritionforlife/features/auth/presention/cubit/signin_cubit/sign_in_cubit.dart';
import 'package:provider/provider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nutrition for life",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            "Welcome to the Nutrition for Life app! Here, you can find personalized meal plans, nutrition tips, and recipes to help you achieve your health goals.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                context.read<SignInCubit>().signOut(context);
              },
              child: const Text(
                'Sign out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // Add more widgets here as needed
        ],
      ),
    );
  }
}

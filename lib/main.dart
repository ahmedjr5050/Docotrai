import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutritionforlife/features/home/screen/home_view.dart';
import 'package:nutritionforlife/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutritionforlife/core/helper_functions/custom_bloc_observer.dart';
import 'package:nutritionforlife/core/services/getit_services.dart';
import 'package:nutritionforlife/features/auth/presention/screen/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding first
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setup(); // Now initialize GetIt services
  Bloc.observer = CustomBlocObserver();

  // Check if user is already logged
  bool isLoggedIn = await _isUserLoggedIn();
  log(isLoggedIn.toString());
  runApp(DoctorAi(isLoggedIn: isLoggedIn));
}

Future<bool> _isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('user_id');
}

class DoctorAi extends StatelessWidget {
  final bool isLoggedIn;

  const DoctorAi({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomeView() : const WelcomeScreen(),
    );
  }
}

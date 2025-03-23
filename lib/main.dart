
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutritionforlife/core/helper_functions/custom_bloc_observer.dart';
import 'package:nutritionforlife/core/services/getit_services.dart';
import 'package:nutritionforlife/features/auth/presention/screen/welcome/welcome_screen.dart';
import 'firebase_options.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = CustomBlocObserver();
  runApp(const FruitHub());
}

class FruitHub extends StatelessWidget {
  const FruitHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     theme: ThemeData(
       fontFamily: 'Cairo',
     ),
     
      debugShowCheckedModeBanner: false,
      home:WelcomeScreen(),
    );
  }
}
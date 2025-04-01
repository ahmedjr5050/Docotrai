import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutritionforlife/features/home/prediction_result_screen.dart';
import 'package:nutritionforlife/features/home/screen/cubit/doctorai_cubit.dart';
import 'package:nutritionforlife/features/home/screen/cubit/doctorai_state.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();

  final List<String> diseaseClasses = [
    'Anemia',
    'Goiter',
    'Kwashiorkor',
    'Marasmus',
    'Obesity',
    'Scurvy',
  ];

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // FormKey for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6CD8D1),
        centerTitle: true,
        title: const Text(
          "Nutrition For Life",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach the form key to the form
          child: ListView(
            children: [
              _buildTextField(
                ageController,
                "Age",
                Icons.calendar_today,
                'Please enter a valid age.',
              ),
              _buildTextField(
                bmiController,
                "BMI",
                Icons.line_weight,
                'Please enter a valid BMI.',
              ),
              _buildTextField(
                proteinController,
                "Protein Intake",
                Icons.fastfood,
                'Please enter a valid protein intake.',
              ),
              _buildTextField(
                symptomsController,
                "Symptoms",
                Icons.healing,
                'Please enter valid symptoms.',
              ),
              const SizedBox(height: 20),
              _buildAnimatedButton(context),
              const SizedBox(height: 20),
              BlocBuilder<PredictionCubit, PredictionState>(
                builder: (context, state) {
                  if (state is PredictionLoaded) {
                    _navigateToResultScreen(context, state.prediction.result);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 تصميم محسّن لحقل الإدخال مع التحقق من صحة البيانات
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    String validationMessage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          final parsedValue = double.tryParse(value);
          if (parsedValue == null || parsedValue <= 0) {
            return validationMessage; // Show custom error message
          }
          return null; // Return null if input is valid
        },
      ),
    );
  }

  /// 🔹 زر التنبؤ مع الانتقال للصفحة الجديدة بعد التحقق من صحة البيانات
  Widget _buildAnimatedButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 1, end: 1.05),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: ElevatedButton(
            onPressed: () {
              // Validate the form
              if (_formKey.currentState?.validate() ?? false) {
                final age = int.tryParse(ageController.text) ?? 0;
                final bmi = double.tryParse(bmiController.text) ?? 0.0;
                final protein = double.tryParse(proteinController.text) ?? 0.0;
                final symptoms = int.tryParse(symptomsController.text) ?? 0;

                context.read<PredictionCubit>().fetchPrediction(
                  age: age,
                  bmi: bmi,
                  proteinIntake: protein,
                  symptoms: symptoms,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            child: const Text("Get Prediction", style: TextStyle(fontSize: 18)),
          ),
        );
      },
    );
  }

  /// 🔹 الانتقال إلى صفحة عرض النتيجة
  void _navigateToResultScreen(BuildContext context, int predictionIndex) {
    if (predictionIndex >= 0 && predictionIndex < diseaseClasses.length) {
      final diseaseName = diseaseClasses[predictionIndex];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => PredictionResultScreen(diseaseName: diseaseName),
          ),
        );
      });
    }
  }
}

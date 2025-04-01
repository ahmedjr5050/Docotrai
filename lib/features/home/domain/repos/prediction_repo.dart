import 'package:nutritionforlife/features/home/domain/entities/doctorentities.dart';

abstract class PredictionRepo {
  Future<PredictionEntity> predict({
    required int age,
    required double bmi,
    required double proteinIntake,
    required int symptoms,
  });
}

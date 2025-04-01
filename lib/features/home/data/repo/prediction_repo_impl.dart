import 'package:dio/dio.dart';
import 'package:nutritionforlife/features/home/domain/entities/doctorentities.dart';
import 'package:nutritionforlife/features/home/domain/repos/prediction_repo.dart';


class PredictionRepoImpl implements PredictionRepo {
  final Dio dio;

  PredictionRepoImpl(this.dio);

  @override
  Future<PredictionEntity> predict({
    required int age,
    required double bmi,
    required double proteinIntake,
    required int symptoms,
  }) async {
    try {
      final response = await dio.post(
        'https://mohamed446-zag-server5.hf.space/predict',
        data: {
          "Age": age,
          "BMI": bmi,
          "Protein_Intake": proteinIntake,
          "Symptoms": symptoms,
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        return PredictionEntity(result: response.data[0]);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Failed to fetch prediction: $e');
    }
  }
}

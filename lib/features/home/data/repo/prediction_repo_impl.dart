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
    // تحقق من المدخلات قبل إرسال الطلب
    if (age <= 0 || bmi <= 0 || proteinIntake <= 0 || symptoms < 0) {
      throw Exception('المدخلات غير صحيحة، يرجى إدخال قيم صالحة');
    }

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
      } else if (response.statusCode == 400) {
        // حالة 400: المدخلات غير صحيحة
        throw Exception('المدخلات غير صحيحة، يرجى التحقق من القيم المدخلة');
      } else {
        // حالات أخرى
        throw Exception('حدث خطأ غير معروف: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('فشل في جلب التنبؤ: $e');
    }
  }
}

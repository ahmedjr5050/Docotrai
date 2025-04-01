import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutritionforlife/features/home/domain/repos/prediction_repo.dart';
import 'package:nutritionforlife/features/home/screen/cubit/doctorai_state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  final PredictionRepo predictionRepo;

  PredictionCubit(this.predictionRepo) : super(PredictionInitial());

  Future<void> fetchPrediction({
    required int age,
    required double bmi,
    required double proteinIntake,
    required int symptoms,
  }) async {
    emit(PredictionLoading());
    try {
      final prediction = await predictionRepo.predict(
        age: age,
        bmi: bmi,
        proteinIntake: proteinIntake,
        symptoms: symptoms,
      );
      emit(PredictionLoaded(prediction));
    } catch (e) {
      log('Error fetching prediction: $e');
      emit(PredictionError(e.toString()));
    }
  }
}

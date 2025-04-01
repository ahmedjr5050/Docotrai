
import 'package:equatable/equatable.dart';
import 'package:nutritionforlife/features/home/domain/entities/doctorentities.dart';

abstract class PredictionState extends Equatable {
  @override
  List<Object> get props => [];
}

class PredictionInitial extends PredictionState {}

class PredictionLoading extends PredictionState {}

class PredictionLoaded extends PredictionState {
  final PredictionEntity prediction;
  PredictionLoaded(this.prediction);

  @override
  List<Object> get props => [prediction];
}

class PredictionError extends PredictionState {
  final String message;
  PredictionError(this.message);

  @override
  List<Object> get props => [message];
}

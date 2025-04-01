import 'package:dio/dio.dart';
import 'package:nutritionforlife/core/services/firebase_auth_services.dart';
import 'package:nutritionforlife/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nutritionforlife/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:nutritionforlife/features/home/data/repo/prediction_repo_impl.dart';
import 'package:nutritionforlife/features/home/domain/repos/prediction_repo.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<PredictionRepo>(
    () => PredictionRepoImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());

  // Register AuthRepo and AuthRepoImpl separately if needed
  final authRepoImpl = AuthRepoImpl(
    firebaseAuthServices: getIt<FirebaseAuthService>(),
  );

  getIt.registerSingleton<AuthRepo>(authRepoImpl);
  getIt.registerSingleton<AuthRepoImpl>(authRepoImpl);
}

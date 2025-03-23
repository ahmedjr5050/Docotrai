import 'package:dartz/dartz.dart';
import 'package:nutritionforlife/core/errors/failures.dart';
import 'package:nutritionforlife/features/auth/domain/entities/user_entitiy.dart';

abstract class AuthRepo {

  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name);
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();

}


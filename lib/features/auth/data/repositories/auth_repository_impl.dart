import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:nutritionforlife/core/errors/exception.dart';
import 'package:nutritionforlife/core/errors/failures.dart';
import 'package:nutritionforlife/core/services/firebase_auth_services.dart';
import 'package:nutritionforlife/features/auth/data/models/user_model.dart';
import 'package:nutritionforlife/features/auth/domain/entities/user_entitiy.dart';
import 'package:nutritionforlife/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthServices;

  AuthRepoImpl({required this.firebaseAuthServices});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      var user = await firebaseAuthServices.crateUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImp createUserWithEmailAndPassword : $e.toString()',
      );
      return left(ServerFailure('حدث خطأ ما يرجى المحاولة مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var user = await firebaseAuthServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImp signInWithEmailAndPassword : $e.toString()',
      );
      return left(ServerFailure('حدث خطأ ما يرجى المحاولة مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      var user = await firebaseAuthServices.signInWithGoogle();
      return right(UserModel.fromFirebaseUser(user));
    } catch (e) {
      log('Exception in AuthRepoImp signInWithGoogle : $e.toString()');
      return left(ServerFailure('حدث خطأ ما يرجى المحاولة مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await firebaseAuthServices.signout();
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImp signOut : $e');
      return left(ServerFailure('حدث خطأ ما يرجى المحاولة مرة أخرى'));
    }
  }
}

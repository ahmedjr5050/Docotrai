import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nutritionforlife/features/auth/domain/entities/user_entitiy.dart';
import 'package:nutritionforlife/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:nutritionforlife/features/auth/presention/screen/signin.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepo) : super(SignInInitial());
  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(SignInLoading());
    var result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(SignInError(failure.message)),
      (UserEntity) => emit(SignInSuccess(userEntity: UserEntity)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(SignInLoading());
    var result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SignInError(failure.message)),
      (UserEntity) => emit(SignInSuccess(userEntity: UserEntity)),
    );
  }

  Future<void> signOut(BuildContext context) async {
    emit(SignInLoading());
    var result = await authRepo.signOut();
    result.fold((failure) => emit(SignInError(failure.message.toString())), (
      _,
    ) {
      emit(SignOutSuccess('تم تسجيل الخروج بنجاح'));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SigninView()),
      );
    });
  }
}

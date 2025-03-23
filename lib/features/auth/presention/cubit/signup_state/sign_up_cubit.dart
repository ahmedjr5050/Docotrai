import 'package:bloc/bloc.dart';
import 'package:nutritionforlife/features/auth/domain/entities/user_entitiy.dart';
import 'package:nutritionforlife/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo) : super(SignUpInitial());
  final AuthRepo authRepo;
  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignUpLoading());
    final result =
        await authRepo.createUserWithEmailAndPassword(email, password, name);
    result.fold(
      (failure) => emit(
        SignUpError(failure.message),
      ),
      (UserEntity) => emit(
        SignUpSuccess(
          userEntity: UserEntity,
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutritionforlife/features/auth/domain/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.uId});
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      email: user.email ?? '',
      name: user.displayName ?? '',
      uId: user.uid,
    );
  }
}

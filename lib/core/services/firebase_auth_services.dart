import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutritionforlife/core/errors/exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  Future<void> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in FirebaseAuthService.Signout: ${e.toString()} and code is ${e.code}",
      );
      throw CustomException(message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
    } catch (e) {
      log('Exception in FirebaseAuthServices Signout : $e');
      throw CustomException(message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
    }
  }

  Future<User> crateUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}",
      );
      if (e.code == 'weak-password') {
        throw CustomException(message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تاكد من اتصالك بالانترنت.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: 'البريد الإلكتروني مستخدم بالفعل');
      } else {
        throw CustomException(message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthServices crateUserWithEmailAndPassword : $e.toString()',
      );
      throw CustomException(message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}",
      );
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'البريد الإلكتروني غير مسجل');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'كلمة المرور غير صحيحة');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تاكد من اتصالك بالانترنت.');
      } else {
        throw CustomException(message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthServices signInWithEmailAndPassword : $e.toString()',
      );
      throw CustomException(message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }
}

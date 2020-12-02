import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  Future signIn(String emailId, String password) async {
    try {
      final result = await login(emailId, password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        try {
          final result = signUp(emailId, password);
          return result;
        } on FirebaseAuthException catch (e) {
          return e.code;
        }
      } else
        return e.code;
    }
  }

  Future<UserCredential> signUp(String emailId, String password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailId, password: password);
  }

  Future<UserCredential> login(String emailId, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailId, password: password);
  }
}

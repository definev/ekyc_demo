import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  static final provider = Provider((ref) => AuthService());

  Future<User?> signIn(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  }

  Future<User?> signUp(String email, String password, String fullName) async {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    final user = credential.user;
    if (user != null) {
      await user.updateDisplayName(fullName);
      return user;
    }
    return null;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

final authStateProvider = StreamProvider<User?>((ref) async* {
  yield* FirebaseAuth.instance.authStateChanges();
});

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/register/firebase_auth.dart';

final needVerifyProvider = FutureProvider.autoDispose<bool>(
  (ref) {
    final user = ref.watch(authStateProvider);
    return user.maybeWhen(
      orElse: () => false,
      data: (user) async {
        if (user == null) return false;
        final snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (snapshot.exists) {
          return snapshot.data()!['needVerify'] as bool;
        } else {
          return true;
        }
      },
    );
  },
  dependencies: [authStateProvider],
);

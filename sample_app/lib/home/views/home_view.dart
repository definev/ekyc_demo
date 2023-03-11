import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/home/services/home_service.dart';
import 'package:sample_app/home/views/face_recognition_view.dart';
import 'package:sample_app/home/views/id_scan_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needVerify = ref.watch(needVerifyProvider);
    return needVerify.when(
      data: (data) {
        if (data) return const IDScanView();
        return const FaceRecognitionView();
      },
      error: (error, stack) => Text('$error'),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

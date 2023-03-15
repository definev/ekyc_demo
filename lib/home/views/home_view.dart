import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/ekyc/id_scan_view.dart';
import 'package:sample_app/home/views/verified_home_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needVerify = ref.watch(currentUserIdInformationProvider);
    return needVerify.when(
      data: (data) {
        if (data == null) return const IDScanView();
        return VerifiedHomeView(idInformation: data);
      },
      error: (error, stack) => Text('$error'),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sample_app/ekyc/result_card.dart';
import 'package:sample_app/home/domain/id_information.dart';
import 'package:sample_app/register/firebase_auth.dart';
import 'package:sample_app/register/login_view.dart';

final currentUserIdInformationProvider = FutureProvider.autoDispose<IDInformation?>(
  (ref) async {
    final user = await ref.watch(authStateProvider.future);
    if (user == null) return null;
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (snapshot.exists) {
      return IDInformation.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  },
);

class VerifiedHomeView extends StatefulWidget {
  const VerifiedHomeView({
    super.key,
    required this.idInformation,
  });

  final IDInformation idInformation;

  @override
  State<VerifiedHomeView> createState() => _VerifiedHomeViewState();
}

class _VerifiedHomeViewState extends State<VerifiedHomeView> {
  late IDInformation initial = widget.idInformation;
  late IDInformation idInformation = widget.idInformation;

  @override
  void didUpdateWidget(covariant VerifiedHomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.idInformation != widget.idInformation) {
      idInformation = widget.idInformation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Người dùng đã được xác minh'),
        centerTitle: true,
      ),
      body: SeparatedColumn(
        padding: const EdgeInsets.all(15),
        separatorBuilder: () => const Gap(15),
        children: [
          ResultCard(
            title: 'Số CMT/CCCD',
            value: widget.idInformation.id,
            onChanged: (value) {
              idInformation = idInformation.copyWith(id: value);
              setState(() {});
            },
          ),
          ResultCard(
            title: 'Họ và tên',
            value: widget.idInformation.name,
            onChanged: (value) {
              idInformation = idInformation.copyWith(name: value);
              setState(() {});
            },
          ),
          ResultCard(
            title: 'Ngày sinh',
            value: widget.idInformation.birth,
            onChanged: (value) {
              idInformation = idInformation.copyWith(birth: value);
              setState(() {});
            },
          ),
          ResultCard(
            title: 'Quê quán',
            value: widget.idInformation.add,
            onChanged: (value) {
              idInformation = idInformation.copyWith(add: value);
              setState(() {});
            },
          ),
          ResultCard(
            title: 'Thường trú',
            value: widget.idInformation.home,
            onChanged: (value) {
              idInformation = idInformation.copyWith(home: value);
              setState(() {});
            },
          ),
          if (idInformation != initial)
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update(idInformation.toJson());
                initial = idInformation;
                setState(() {});
              },
              child: const Align(
                heightFactor: 1.0,
                child: Text('Lưu thay đổi'),
              ),
            ),
          FilledButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await FirebaseAuth.instance.signOut();
              navigator.popUntil((route) => route.isFirst);
              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            },
            child: const Align(
              heightFactor: 1.0,
              child: Text('Đăng xuất'),
            ),
          ),
        ],
      ),
    );
  }
}

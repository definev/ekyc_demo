import 'dart:developer';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sample_app/register/firebase_auth.dart';

import '../home/views/home_view.dart';

class SignupView extends HookConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(AuthService.provider);

    final emailTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();
    final fullNameTextController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng kí'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SeparatedColumn(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 40),
            separatorBuilder: () => const SizedBox(height: 16),
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  hintText: 'Nhập email',
                ),
              ),
              TextField(
                controller: fullNameTextController,
                decoration: const InputDecoration(
                  hintText: 'Nhập họ và tên',
                ),
              ),
              TextField(
                controller: passwordTextController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Nhập mật khẩu',
                ),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Nhập lại mật khẩu',
                ),
              ),
              Row(
                children: [
                  FilledButton(
                    onPressed: () async {
                      try {
                        final navigator = Navigator.of(context);
                        final user = await service.signUp(
                          emailTextController.text,
                          passwordTextController.text,
                          fullNameTextController.text,
                        );

                        if (user != null) {
                          navigator.popUntil((route) => route.isFirst);
                          navigator.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ),
                          );
                        }
                      } catch (e) {
                        log(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    child: const Text('Đăng kí'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

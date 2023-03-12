import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sample_app/home/views/home_view.dart';
import 'package:sample_app/register/firebase_auth.dart';
import 'package:sample_app/register/signup_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
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
                controller: passwordTextController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Nhập mật khẩu',
                ),
              ),
              Row(
                children: [
                  FilledButton(
                    onPressed: () async {
                      try {
                        final navigator = Navigator.of(context);
                        final user = await ref
                            .read(AuthService.provider)
                            .signIn(emailTextController.text, passwordTextController.text);

                        if (user != null) {
                          navigator.popUntil((route) => route.isFirst);
                          navigator.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    child: const Text('Đăng nhập'),
                  ),
                  const Gap(12),
                  OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupView(),
                      ),
                    ),
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

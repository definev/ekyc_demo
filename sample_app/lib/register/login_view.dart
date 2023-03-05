import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sample_app/home/face_recognition_view.dart';
import 'package:sample_app/home/home_view.dart';
import 'package:sample_app/register/signup_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập email',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập mật khẩu',
                ),
              ),
              Row(
                children: [
                  FilledButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FaceRecognitionView(),
                      ),
                    ),
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

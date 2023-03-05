import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
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
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập email',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập họ và tên',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập mật khẩu',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập lại mật khẩu',
                ),
              ),
              Row(
                children: [
                  FilledButton(
                    onPressed: () {},
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

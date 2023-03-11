import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/firebase_options.dart';
import 'package:sample_app/register/firebase_auth.dart';
import 'package:sample_app/register/login_view.dart';

import 'home/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FlexColorScheme.light(
      useMaterial3: true,
      tones: FlexTones.jolly(Brightness.light),
      scheme: FlexScheme.amber,
    ).toTheme;
    return MaterialApp(
        title: 'EKYC App',
        theme: theme.copyWith(
          buttonTheme: const ButtonThemeData(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size.square(48)),
            ),
          ),
          filledButtonTheme: const FilledButtonThemeData(
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size.square(48)),
            ),
          ),
          outlinedButtonTheme: const OutlinedButtonThemeData(
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size.square(48)),
            ),
          ),
          textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size.square(48)),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(authStateProvider);
            return user.when(
              data: (data) {
                if (data != null) return const HomeView();
                return const LoginView();
              },
              error: (error, stack) => Text('$error'),
              loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
            );
          },
        ));
  }
}

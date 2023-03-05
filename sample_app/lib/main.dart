import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/register/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme =  FlexColorScheme.light(
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
      home: LoginView(),
    );
  }
}

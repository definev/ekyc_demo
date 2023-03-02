import 'dart:io';
import 'dart:ui';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_app/parsed_result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EKYC App',
      theme: FlexColorScheme.light(
        useMaterial3: false,
        scheme: FlexScheme.amber,
      ).toTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: 2.seconds);
    controller.repeat();
    controller.addListener(_reset);
  }

  void _reset() => setState(() {});

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<String> _pathBuilder() async {
    final Directory extDir = await getTemporaryDirectory();
    final testDir = await Directory('${extDir.path}/test').create(recursive: true);
    return '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return CameraAwesomeBuilder.custom(
      saveConfig: SaveConfig.photo(pathBuilder: _pathBuilder),
      builder: (state, previewSize, previewRect) => Stack(
        children: [
          Center(
            child: IgnorePointer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                            child: AspectRatio(
                          aspectRatio: 85.6 / 53.98,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              backgroundBlendMode: BlendMode.clear,
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                              border: BoxBorder.lerp(
                                Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                                Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 4),
                                controller.value,
                              ),
                            ),
                          ),
                        )),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white54,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text('Đưa CMT/CCCD vào khung để chụp ảnh', style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 100,
              width: double.maxFinite,
              child: ColoredBox(
                color: Colors.black.withOpacity(0.5),
                child: SafeArea(
                  top: false,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.square(80),
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        child: const Icon(Icons.camera_alt),
                        onPressed: () => state.when(
                          onPhotoMode: (photoState) async {
                            final navigator = Navigator.of(context);
                            final image = await photoState.takePhoto();
                            navigator.push(
                              MaterialPageRoute(
                                builder: (_) => ParsedResultScreen(image: image),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

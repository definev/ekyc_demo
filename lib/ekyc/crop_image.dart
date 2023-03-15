import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:sample_app/ekyc/id_result_view.dart';

class CropImageScreen extends StatefulWidget {
  const CropImageScreen({super.key, required this.fileName});

  final String fileName;

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Crop(
            key: cropKey,
            image: FileImage(File(widget.fileName)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final scale = cropKey.currentState!.scale;
                final area = cropKey.currentState!.area!;
                final file = File(widget.fileName);
                final cropped = await ImageCrop.cropImage(
                  file: file,
                  area: area,
                  scale: scale,
                );
                
                navigator.push(
                  MaterialPageRoute(
                    builder: (context) => IDResultView(image: cropped),
                  ),
                );
              },
              child: const Text('Crop'),
            ),
          ],
        ),
      ],
    );
  }
}

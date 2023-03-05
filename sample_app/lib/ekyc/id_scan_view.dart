import 'dart:convert';
import 'dart:io';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:sample_app/home/id_information.dart';

class IDScanView extends StatefulWidget {
  const IDScanView({
    super.key,
    required this.image,
  });

  final String image;

  @override
  State<IDScanView> createState() => _IDScanViewState();
}

class _IDScanViewState extends State<IDScanView> {
  Map<String, dynamic>? result;

  AsyncValue<IDInformation> card = const AsyncValue.loading();

  final baseUrl = 'https://dc20-2405-4803-fbbf-3d0-4988-4f7b-6cc9-a6df.ap.ngrok.io';

  Future<void> fetchData() async {
    final uri = Uri.parse('$baseUrl/predict/image');
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll({'Accept': 'application/json', 'Content-Type': 'multipart/form-data'});
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await File(widget.image).readAsBytes(),
        filename: widget.image.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();
    if (response.statusCode != 200) {
      card = AsyncValue.error('Failed to load data', StackTrace.current);
      setState(() {});
      return;
    }
    response.stream.transform(utf8.decoder).listen((value) {
      card = AsyncValue.data(
        IDInformation.fromJson(jsonDecode(value)),
      );
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả phân tích'),
        centerTitle: true,
      ),
      body: card.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        data: (data) => SeparatedColumn(
          separatorBuilder: () => const Gap(12),
          padding: const EdgeInsets.all(12),
          children: [
            AspectRatio(
              aspectRatio: 85.6 / 53.98,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _Card(
              title: 'Số CMT/CCCD',
              value: data.id,
            ),
            _Card(
              title: 'Họ và tên',
              value: data.name,
            ),
            _Card(
              title: 'Ngày sinh',
              value: data.birth,
            ),
            _Card(
              title: 'Quê quán',
              value: data.add,
            ),
            _Card(
              title: 'Thường trú',
              value: data.home,
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: PaddedRow(
        padding: const EdgeInsets.all(12),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:sample_app/ekyc/result_card.dart';
import 'package:sample_app/home/domain/id_information.dart';
import 'package:sample_app/home/views/verified_home_view.dart';

class IDResultView extends ConsumerStatefulWidget {
  const IDResultView({
    super.key,
    required this.image,
  });

  final File image;

  @override
  ConsumerState<IDResultView> createState() => _IDResultViewState();
}

class _IDResultViewState extends ConsumerState<IDResultView> {
  Map<String, dynamic>? result;

  AsyncValue<IDInformation> card = const AsyncValue.loading();

  final baseUrl =
      'https://0053-2405-4802-1c89-98f0-bc71-4b41-71cc-1cf4.ap.ngrok.io';

  Future<void> fetchData() async {
    final uri = Uri.parse('$baseUrl/uploader');

    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(
        {'Accept': 'application/json', 'Content-Type': 'multipart/form-data'});
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await widget.image.readAsBytes(),
        filename: widget.image.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();
    if (response.statusCode != 200) {
      card = AsyncValue.error('Failed to load data', StackTrace.current);
      setState(() {});
      return;
    }
    response.stream.transform(utf8.decoder).listen((value) async {
      final data = jsonDecode(jsonDecode(value)["res"]);
      final idInformation = IDInformation.fromJson(data);
      card = AsyncValue.data(idInformation);
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: card.when(
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
                  ResultCard(
                    title: 'Số CMT/CCCD',
                    value: data.id,
                    onChanged: (id) => card = AsyncData(data.copyWith(id: id)),
                  ),
                  ResultCard(
                    title: 'Họ và tên',
                    value: data.name,
                    onChanged: (name) => card = AsyncData(data.copyWith(name: name)),
                  ),
                  ResultCard(
                    title: 'Ngày sinh',
                    value: data.birth,
                    onChanged: (birth) => card = AsyncData(data.copyWith(birth: birth)),
                  ),
                  ResultCard(
                    title: 'Quê quán',
                    value: data.add,
                    onChanged: (add) => card = AsyncData(data.copyWith(add: add)),
                  ),
                  ResultCard(
                    title: 'Thường trú',
                    value: data.home,
                    onChanged: (home) => card = AsyncData(data.copyWith(home: home)),
                  ),
                  FilledButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(data.toJson());
                      ref.invalidate(currentUserIdInformationProvider);
                      navigator.pop();
                    },
                    child: const Align(
                      heightFactor: 1.0,
                      child: Text('Xác nhận'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

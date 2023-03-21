import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResultCard extends StatefulWidget {
  const ResultCard({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  late final textController = TextEditingController(text: widget.value);

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
            widget.title,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(12),
          Expanded(
            child: SizedBox(
              height: 24,
              child: TextField(
                controller: textController,
                style: theme.textTheme.bodyMedium,
                onChanged: widget.onChanged,
                decoration: const InputDecoration.collapsed(hintText: ''),
                maxLines: 1,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NoItems extends StatelessWidget {
  final String pluralItem;

  const NoItems(
      this.pluralItem, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.pending_outlined,
          size: 64,
        ),
        Text(
          "No $pluralItem found",
          style: const TextStyle(fontSize: 24),
        )
      ],
    );
  }
}
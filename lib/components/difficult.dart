import 'package:flutter/material.dart';

class Difficult extends StatelessWidget {
  final int difficultValue;

  const Difficult({required this.difficultValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(difficultValue >= 1 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultValue >= 1 ? Colors.orange : Colors.black12),
        Icon(difficultValue >= 2 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultValue >= 2 ? Colors.orange : Colors.black12),
        Icon(difficultValue >= 3 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultValue >= 3 ? Colors.orange : Colors.black12),
        Icon(difficultValue >= 4 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultValue >= 4 ? Colors.orange : Colors.black12),
        Icon(difficultValue >= 5 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultValue >= 5 ? Colors.orange : Colors.black12),
      ],
    );
  }
}

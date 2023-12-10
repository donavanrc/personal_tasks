import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {
  final int difficultyValue;

  const Difficulty({required this.difficultyValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(difficultyValue >= 1 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultyValue >= 1 ? Colors.orange : Colors.black12),
        Icon(difficultyValue >= 2 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultyValue >= 2 ? Colors.orange : Colors.black12),
        Icon(difficultyValue >= 3 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultyValue >= 3 ? Colors.orange : Colors.black12),
        Icon(difficultyValue >= 4 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultyValue >= 4 ? Colors.orange : Colors.black12),
        Icon(difficultyValue >= 5 ? Icons.star : Icons.star_outline,
            size: 20,
            color: difficultyValue >= 5 ? Colors.orange : Colors.black12),
      ],
    );
  }
}

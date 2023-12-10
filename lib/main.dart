import 'package:flutter/material.dart';
import 'package:personal_tasks/data/inherited_task.dart';
import 'package:personal_tasks/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: InheritedTask(child: const Home()),
    );
  }
}

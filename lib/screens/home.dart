import 'package:flutter/material.dart';
import 'package:personal_tasks/data/inherited_task.dart';
import 'package:personal_tasks/screens/new_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.task_outlined,
          size: 32,
          color: Colors.black54,
        ),
        title: const Text("Personal Tasks"),
      ),
      body: Container(
        color: Colors.black12,
        width: 500,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: InheritedTask.of(context).allTasks,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (newContext) => NewTask(taskContext: context,)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

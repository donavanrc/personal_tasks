import 'package:flutter/material.dart';
import 'package:personal_tasks/components/task.dart';

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
        width: 400,
        child: AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: ListView(
            children: const [
              Task("Running", 5, "assets/images/running.webp"),
              Task("Meditate", 3, "assets/images/meditate.jpeg"),
              Task("Make the lunch", 4, "assets/images/cooking.jpg"),
              Task("Wash the dishes", 2, "assets/images/wash_dishes.jpg"),
              Task("Learn Flutter", 3, "assets/images/learn_flutter.png"),
              Task("Read a book", 5, "assets/images/read_book.jpg"),
              Task("Learn C++", 3, "assets/images/learn_cpp.jpg"),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}

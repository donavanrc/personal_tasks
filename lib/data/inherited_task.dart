import 'package:flutter/material.dart';
import 'package:personal_tasks/components/task.dart';

class InheritedTask extends InheritedWidget {
  InheritedTask({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> allTasks = [
    Task(0, "Running", 5, "assets/images/running.webp"),
    Task(1, "Meditate", 3, "assets/images/meditate.jpeg"),
    Task(2, "Make the lunch", 4, "assets/images/cooking.jpg"),
    Task(3, "Wash the dishes", 2, "assets/images/wash_dishes.jpg"),
    Task(4, "Learn Flutter", 3, "assets/images/learn_flutter.png"),
    Task(5, "Read a book", 5, "assets/images/read_book.jpg"),
    Task(6, "Learn C++", 3, "assets/images/learn_cpp.jpg"),
  ];

  void addTask(String name, int difficulty, String imageUrl){
    allTasks.add(Task(0, name, difficulty, imageUrl));
  }

  static InheritedTask of(BuildContext context) {
    final InheritedTask? result = context.dependOnInheritedWidgetOfExactType<InheritedTask>();
    assert(result != null, 'No InheritedTask found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedTask oldWidget) {
    return oldWidget.allTasks.length != allTasks.length;
  }
}

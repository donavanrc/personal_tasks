import 'package:flutter/material.dart';
import 'package:personal_tasks/Models/task.dart';
import 'package:personal_tasks/components/loading_widget.dart';
import 'package:personal_tasks/components/no_items_widget.dart';
import 'package:personal_tasks/components/task_widget.dart';
import 'package:personal_tasks/data/task_dao.dart';
import 'package:personal_tasks/screens/task_form.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {
  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    isLoading = true;
    final List<Task> loadedTasks = await TaskDao().findAll();
    setState(() {
      tasks = loadedTasks;
      isLoading = false;
    });
  }

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
        child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: isLoading ? const Loading() : getListView()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTaskForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void openTaskForm(Task? task) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => TaskForm(task: task)))
        .then((value) => loadTasks());
  }

  void onTaskDeleted() {
    loadTasks();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task was deleted"),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Widget getListView() {
    if (tasks.isNotEmpty) {
      return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            Task task = tasks[index];
            return InkWell(
                onLongPress: () => openTaskForm(task),
                child: TaskWidget(task: task, onTaskDeleted: onTaskDeleted));
          });
    }
    return const NoItems("tasks");
  }
}

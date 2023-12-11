import 'package:flutter/material.dart';
import 'package:personal_tasks/Models/task.dart';
import 'package:personal_tasks/data/task_dao.dart';

class TaskForm extends StatefulWidget {
  final Task? task;

  const TaskForm({super.key, this.task});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    isEditMode = widget.task != null;
    if (isEditMode) {
      nameController = TextEditingController(text: widget.task!.name);
      difficultyController =
          TextEditingController(text: widget.task!.difficultyLevel.toString());
      imageController = TextEditingController(text: widget.task!.imageUrl);
    }
  }

  bool valueValidator(String? value) {
    return value != null && value.isEmpty;
  }

  bool valueRange(int value, int min, int max) {
    return value < min || value > max;
  }

  void save() {
    if (formKey.currentState!.validate()) {
      Task task = Task(
          name: nameController.text,
          difficultyLevel: int.parse(difficultyController.text),
          imageUrl: imageController.text);

      if (isEditMode) {
        TaskDao().updateOne(widget.task!.id!, task);
      } else {
        TaskDao().save(task);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditMode ? "Task was updated" : "Task was created"),
          backgroundColor: Colors.lightGreen,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditMode ? "Edit Task" : "New Task"),
        ),
        body: Container(
          color: Colors.black12,
          width: 400,
          height: 1000,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 5),
                        blurRadius: 5)
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16),
                      child: TextFormField(
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return "Task name is required";
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Task name",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16),
                      child: TextFormField(
                        validator: (String? value) {
                          if (valueValidator(value) ||
                              valueRange(int.parse(value!), 1, 5)) {
                            return "Difficulty Level must be range from 1 to 5";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: difficultyController,
                        decoration: const InputDecoration(
                          hintText: "Difficulty Level",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16),
                      child: TextFormField(
                        onChanged: (text) {
                          setState(() {});
                        },
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return "Image URL is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        controller: imageController,
                        decoration: const InputDecoration(
                          hintText: "Image URL",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          color: Colors.black12,
                          width: 200,
                          height: 200,
                          child: Image.network(imageController.text,
                              fit: BoxFit.cover, errorBuilder:
                                  (BuildContext context, Object exception,
                                      StackTrace? trace) {
                            return Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Image.asset(
                                "assets/images/no-image.png",
                                fit: BoxFit.contain,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16),
                      child: ElevatedButton(
                          onPressed: save, child: const Text("Save")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

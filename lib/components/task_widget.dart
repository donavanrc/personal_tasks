import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_tasks/Models/task.dart';
import 'package:personal_tasks/components/difficulty_widget.dart';
import 'package:personal_tasks/data/task_dao.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  final VoidCallback onTaskDeleted;

  TaskWidget({required this.task, required this.onTaskDeleted, super.key});

  int level = 0;
  int maxLevel = 10;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  void incrementLevel() {
    setState(() {
      widget.level++;
    });
  }

  bool isNetworkImage(String source) {
    return source.contains("http");
  }

  double getLevelScale() {
    return (widget.level / max(widget.task.difficultyLevel, 1)) / widget.maxLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 5.0),
                spreadRadius: 1.0,
                blurRadius: 5.0)
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                Container(
                  color: Colors.black54,
                  width: 400,
                  height: 134,
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: 400,
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: Colors.black12,
                                width: 80,
                                height: 80,
                                child: isNetworkImage(widget.task.imageUrl)
                                    ? Image.network(widget.task.imageUrl,
                                        fit: BoxFit.cover)
                                    : Image.asset(widget.task.imageUrl,
                                        fit: BoxFit.cover),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Text(
                                      widget.task.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis),
                                    )),
                                Difficulty(
                                    difficultyValue: widget.task.difficultyLevel)
                              ],
                            ),
                            SizedBox(
                              width: 86,
                              height: 64,
                              child: ElevatedButton(
                                  onPressed: incrementLevel,
                                  child: const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.expand_less),
                                      Text("Lv. Up")
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Level ${widget.level}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                              width: 200,
                              child: LinearProgressIndicator(
                                color: Colors.black26,
                                value: getLevelScale(),
                              )),
                          InkWell(
                              onTap: () async {
                                await TaskDao().deleteOne(widget.task.id!);
                                widget.onTaskDeleted();
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}

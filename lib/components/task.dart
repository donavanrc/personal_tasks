import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_tasks/components/difficult.dart';

class Task extends StatefulWidget {
  final String name;
  final int difficult;
  final String imageUrl;

  const Task(this.name, this.difficult, this.imageUrl, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int level = 0;
  int maxLevel = 10;

  void incrementLevel() {
    setState(() {
      level++;
    });
  }

  double getLevelScale()
  {
    return (level / max(widget.difficult, 1)) / maxLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 5), blurRadius: 5)
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  color: Colors.black54,
                  width: 400,
                  height: 150,
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: 400,
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                color: Colors.black12,
                                width: 90,
                                height: 90,
                                child: Image.asset(
                                    widget.imageUrl,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 150,
                                    child: Text(
                                      widget.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          overflow: TextOverflow.ellipsis),
                                    )),
                                Difficult(difficultValue: widget.difficult)
                              ],
                            ),
                            SizedBox(
                              width: 86,
                              height: 64,
                              child: ElevatedButton(
                                  onPressed: incrementLevel,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(
                              width: 200,
                              child: LinearProgressIndicator(
                                color: Colors.black26,
                                value: getLevelScale(),
                              )),
                          Text(
                            "Level $level",
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
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
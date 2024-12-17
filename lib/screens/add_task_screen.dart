import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: "Task Description")),
            TextField(decoration: const InputDecoration(labelText: "Amount")),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}

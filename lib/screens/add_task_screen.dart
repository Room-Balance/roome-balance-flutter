import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String? selectedUser;
  String? selectedTask;
  final List<String> users = ['Alice', 'Bob', 'Charlie'];
  final List<String> tasks = ['Cleaning', 'Dishwashing', 'Cooking'];

  void addTask() {
    if (selectedUser != null && selectedTask != null) {
      final newTask = Task(
        id: DateTime.now().toString(),
        taskName: selectedTask!,
        assignedUser: selectedUser!,
      );

      setState(() {
        globalTasks.add(newTask);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task added successfully!')),
      );

      Navigator.pop(context); // Geri dön
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both user and task!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedUser,
              hint: Text('Select User'),
              items: users.map((user) {
                return DropdownMenuItem(
                  value: user,
                  child: Text(user),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedUser = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedTask,
              hint: Text('Select Task'),
              items: tasks.map((task) {
                return DropdownMenuItem(
                  value: task,
                  child: Text(task),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTask = value;
                });
              },
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: addTask,
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

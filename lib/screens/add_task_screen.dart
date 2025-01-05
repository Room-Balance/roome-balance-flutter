import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  final Function(Task) onTaskAdded;

  const AddTaskScreen({
    Key? key,
    required this.users,
    required this.onTaskAdded,
  }) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String? selectedUser;
  String? selectedTask;
  DateTime? selectedDate;
  final TextEditingController taskController = TextEditingController();

  final List<Map<String, dynamic>> predefinedTasks = [
    {'name': 'Washing', 'icon': Icons.local_laundry_service},
    {'name': 'Cooking', 'icon': Icons.kitchen},
    {'name': 'Dishwashing', 'icon': Icons.cleaning_services},
    {'name': 'Shopping', 'icon': Icons.shopping_cart},
    {'name': 'Repairing', 'icon': Icons.build},
  ];

  void addTask() {
    if (selectedUser != null &&
        (selectedTask != null || taskController.text.isNotEmpty) &&
        selectedDate != null) {
      final newTask = Task(
        id: DateTime.now().toString(),
        taskName: selectedTask ?? taskController.text,
        assignedUser: selectedUser!,
        dueDate: selectedDate!,
      );

      widget.onTaskAdded(newTask);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task added successfully!')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a user, task, and date!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: Colors.green,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedUser,
              hint: const Text('Select User'),
              items: widget.users.map((user) {
                return DropdownMenuItem<String>(
                  value: user["name"],
                  child: Text(user["name"]),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedUser = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedTask,
              hint: const Text('Select Predefined Task'),
              items: predefinedTasks.map((task) {
                return DropdownMenuItem<String>(
                  value: task['name'],
                  child: Row(
                    children: [
                      Icon(task['icon']),
                      const SizedBox(width: 10),
                      Text(task['name']),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTask = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: taskController,
              decoration: const InputDecoration(labelText: 'Or Enter Custom Task'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(
                selectedDate == null
                    ? "Select Due Date"
                    : "Due Date: ${selectedDate!.toLocal().toString().split(' ')[0]}",
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: addTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
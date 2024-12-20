import 'package:flutter/material.dart';
import '../models/task.dart';

class ListItemsScreen extends StatelessWidget {
  final List<Task> tasks;
  final List<Map<String, dynamic>> users;

  const ListItemsScreen({Key? key, required this.tasks, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks and Users'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tasks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              tasks.isEmpty
                  ? const Text(
                      "No tasks available.",
                      style: TextStyle(color: Colors.black54),
                    )
                  : Column(
                      children: tasks.map((task) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.task, color: Colors.green),
                            title: Text(task.taskName),
                            subtitle: Text(
                              task.assignedUser.isEmpty
                                  ? 'Unassigned Task'
                                  : 'Assigned to: ${task.assignedUser}',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 20),
              const Text(
                "Users",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              users.isEmpty
                  ? const Text(
                      "No users available.",
                      style: TextStyle(color: Colors.black54),
                    )
                  : Column(
                      children: users.map((user) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading:
                                const Icon(Icons.person, color: Colors.green),
                            title: Text(user["name"] ?? ""),
                            subtitle: Text(
                              "Payment: ${user["payment"]}₺ | Expense: ${user["expense"]}₺",
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

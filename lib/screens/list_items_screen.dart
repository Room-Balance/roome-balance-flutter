import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

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
                  ? const Center(
                      child: Text(
                        "No tasks available.",
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Icon(task.icon, color: Colors.green),
                            title: Text(task.taskName),
                            subtitle: Text(
                              "Assigned to: ${task.assignedUser}\nDue: ${DateFormat('yyyy-MM-dd').format(task.dueDate)}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Görev silme işlemi
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${task.taskName} deleted!',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
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
                  ? const Center(
                      child: Text(
                        "No users available.",
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: const Icon(Icons.person, color: Colors.green),
                            title: Text(user["name"] ?? ""),
                            subtitle: Text(
                              "Payment: ${user["payment"]}₺ | Expense: ${user["expense"]}₺",
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/task.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Task> tasks;

  NotificationsScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text('No notifications yet.'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text(
                      '${task.assignedUser.isNotEmpty ? task.assignedUser : "Unassigned"} - ${task.taskName}',
                    ),
                    subtitle: Text('Assigned Task ID: ${task.id}'),
                    trailing: Icon(
                      task.assignedUser.isEmpty
                          ? Icons.warning
                          : Icons.check_circle,
                      color: task.assignedUser.isEmpty ? Colors.red : Colors.green,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
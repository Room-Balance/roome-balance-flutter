// notifications_screen.dart
import 'package:flutter/material.dart';
import '../models/task.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: globalTasks.isEmpty
          ? Center(child: Text('No notifications yet.'))
          : ListView.builder(
              itemCount: globalTasks.length,
              itemBuilder: (context, index) {
                final task = globalTasks[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('${task.assignedUser.isNotEmpty ? task.assignedUser : "Unassigned"} - ${task.taskName}'),
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

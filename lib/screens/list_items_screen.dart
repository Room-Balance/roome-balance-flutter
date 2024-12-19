import 'package:flutter/material.dart';
import '../models/task.dart';

class ListItemsScreen extends StatelessWidget {
  const ListItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        backgroundColor: Colors.green,
      ),
      body: globalTasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks available.',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: globalTasks.length,
              itemBuilder: (context, index) {
                final task = globalTasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              },
            ),
    );
  }
}

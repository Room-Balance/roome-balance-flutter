import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = ModalRoute.of(context)?.settings.arguments as List<String>? ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications"), backgroundColor: Colors.green),
      body: tasks.isEmpty
          ? const Center(
              child: Text("No tasks assigned yet!",
                  style: TextStyle(fontSize: 18, color: Colors.black54)),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("Task: ${tasks[index]}"),
                  ),
                );
              },
            ),
    );
  }
}

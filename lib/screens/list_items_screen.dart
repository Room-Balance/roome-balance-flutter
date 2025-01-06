import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ListItemsScreen extends StatefulWidget {
  final List<Task> tasks;
  final List<Map<String, dynamic>> users;

  const ListItemsScreen({Key? key, required this.tasks, required this.users})
      : super(key: key);

  @override
  _ListItemsScreenState createState() => _ListItemsScreenState();
}

class _ListItemsScreenState extends State<ListItemsScreen> {
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    tasks = List.from(widget.tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks and Users'),
        backgroundColor: Colors.green,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Total Tasks: ${tasks.length}'),
            _buildTaskTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskTable() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.taskName),
          subtitle: Text('Assigned to: ${task.assignedUser}'),
        );
      },
    );
  }
}

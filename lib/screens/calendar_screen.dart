import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';

class CalendarScreen extends StatefulWidget {
  final List<Task> tasks;

  const CalendarScreen({super.key, required this.tasks});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  List<Task> _selectedTasks = [];

  @override
  void initState() {
    super.initState();
    _updateSelectedTasks();
  }

  void _updateSelectedTasks() {
    setState(() {
      _selectedTasks = widget.tasks.where((task) {
        return task.dueDate.year == _selectedDay.year &&
            task.dueDate.month == _selectedDay.month &&
            task.dueDate.day == _selectedDay.day;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        backgroundColor: Colors.green,
        leading: Container(),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _updateSelectedTasks();
              });
            },
            eventLoader: (date) {
              return widget.tasks.where((task) {
                return task.dueDate.year == date.year &&
                    task.dueDate.month == date.month &&
                    task.dueDate.day == date.day;
              }).toList();
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    if (_selectedTasks.isEmpty) {
      return const Center(
        child: Text(
          "No tasks for the selected day.",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      itemCount: _selectedTasks.length,
      itemBuilder: (context, index) {
        final task = _selectedTasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            leading: Icon(task.icon, color: Colors.green),
            title: Text(task.taskName),
            subtitle: Text("Assigned to: ${task.assignedUser}"),
            trailing: Text(
              "${task.dueDate.year}-${task.dueDate.month.toString().padLeft(2, '0')}-${task.dueDate.day.toString().padLeft(2, '0')}",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';

class CalendarScreen extends StatelessWidget {
  final List<Task> tasks;

  const CalendarScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        backgroundColor: Colors.green,
      ),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2020),
        lastDay: DateTime(2050),
        eventLoader: (date) => tasks.where((task) {
          return task.dueDate.year == date.year &&
              task.dueDate.month == date.month &&
              task.dueDate.day == date.day;
        }).toList(),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          markerDecoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

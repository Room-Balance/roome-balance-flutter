import 'package:flutter/material.dart';

class Task {
  final String id;
  final String taskName;
  final String assignedUser;
  final DateTime dueDate;
  final IconData? icon;

  Task({
    required this.id,
    required this.taskName,
    required this.assignedUser,
    required this.dueDate,
    this.icon,
  });
} 
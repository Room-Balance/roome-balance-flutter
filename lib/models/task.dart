class Task {
  final String id;
  final String taskName;
  final String assignedUser;
  final DateTime dueDate;

  Task({
    required this.id,
    required this.taskName,
    required this.assignedUser,
    required this.dueDate,
  });
}


List<Task> globalTasks = []; // all tasks keep in this list

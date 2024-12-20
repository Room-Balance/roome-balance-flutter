class Task {
  final String id;
  final String taskName;
  final String assignedUser;

  Task({
    required this.id,
    required this.taskName,
    required this.assignedUser,
  });
}

List<Task> globalTasks = []; // all tasks keep in this list

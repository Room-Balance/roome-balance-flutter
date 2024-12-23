import 'package:flutter/material.dart';
import '../models/task.dart';
import 'list_items_screen.dart';
import 'calendar_screen.dart';
import 'profile_screen.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> users = [
    {
      "name": "Alice",
      "email": "alice@example.com",
      "payment": 150.0,
      "expense": 50.0
    },
    {
      "name": "Bob",
      "email": "bob@example.com",
      "payment": 200.0,
      "expense": 100.0
    },
  ];
  final List<Task> globalTasks = [
    Task(
      id: "1",
      taskName: "Cleaning",
      assignedUser: "Alice",
      dueDate: DateTime.now(),
    ),
    Task(
      id: "2",
      taskName: "Dishes",
      assignedUser: "Bob",
      dueDate: DateTime.now().add(Duration(days: 1)),
    ),
  ];
  final Uuid uuid = Uuid();
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(),
      TaskListScreen(),
      CalendarScreen(tasks: globalTasks),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Balance"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications',
                  arguments: globalTasks);
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptions,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/calendar',
                arguments: globalTasks);
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text("Add User"),
              onTap: _addUser,
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text("Add Task"),
              onTap: _addTask,
            ),
          ],
        );
      },
    );
  }

  void _addUser() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "User Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "User Email"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  users.add({
                    "name": nameController.text,
                    "email": emailController.text,
                    "payment": 0.0,
                    "expense": 0.0,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _addTask() {
    final taskController = TextEditingController();
    String? selectedUser;
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: const InputDecoration(hintText: "Task Name"),
              ),
              DropdownButton<String>(
                hint: const Text("Assign to User"),
                value: selectedUser,
                onChanged: (value) {
                  setState(() {
                    selectedUser = value;
                  });
                },
                items: users.map<DropdownMenuItem<String>>((user) {
                  return DropdownMenuItem<String>(
                    value: user["name"],
                    child: Text(user["name"]),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  setState(() {
                    selectedDate = pickedDate;
                  });
                },
                child: const Text("Select Due Date"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (selectedUser != null &&
                    taskController.text.isNotEmpty &&
                    selectedDate != null) {
                  setState(() {
                    globalTasks.add(Task(
                      id: uuid.v4(),
                      taskName: taskController.text,
                      assignedUser: selectedUser!,
                      dueDate: selectedDate!,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Page Content',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Task List Screen',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

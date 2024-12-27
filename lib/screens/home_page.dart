import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
      "expense": 50.0,
    },
    {
      "name": "Bob",
      "email": "bob@example.com",
      "payment": 200.0,
      "expense": 100.0,
    },
  ];

  double totalRent = 5000.0; // Default rent amount
  final List<Task> globalTasks = [
    Task(
      id: "1",
      taskName: "Cleaning",
      assignedUser: "Alice",
      dueDate: DateTime.now(),
      icon: Icons.cleaning_services,
    ),
    Task(
      id: "2",
      taskName: "Dishwashing",
      assignedUser: "Bob",
      dueDate: DateTime.now().add(Duration(days: 1)),
      icon: Icons.local_laundry_service,
    ),
  ];

  final Uuid uuid = Uuid();
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeContent(), // Add the missing home content method here
      ListItemsScreen(tasks: globalTasks, users: users),
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
            icon: const Icon(Icons.edit),
            onPressed: _editTotalRent,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications',
                  arguments: globalTasks);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildRentPieChart(), // Rent pie chart
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptions,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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

  Widget _buildHomeContent() {
    return globalTasks.isEmpty
        ? const Center(child: Text("No tasks added yet!"))
        : ListView.builder(
            itemCount: globalTasks.length,
            itemBuilder: (context, index) {
              final task = globalTasks[index];
              return ListTile(
                leading: Icon(task.icon, color: Colors.green),
                title: Text(task.taskName),
                subtitle: Text(
                  "${task.assignedUser} - ${task.dueDate.toLocal()}",
                ),
              );
            },
          );
  }

  Widget _buildRentPieChart() {
    double rentPaid =
        users.fold(0, (sum, user) => sum + (user['payment'] as double));
    double rentRemaining = totalRent - rentPaid;

    if (rentRemaining <= 0) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const Text(
                "Rent is fully paid for this month! 🎉",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Rent Status",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: rentPaid,
                      color: Colors.green.shade400,
                      title: 'Paid\n${rentPaid.toStringAsFixed(2)}₺',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: rentRemaining > 0 ? rentRemaining : 0,
                      color: Colors.red.shade400,
                      title: 'Remaining\n${rentRemaining.toStringAsFixed(2)}₺',
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editTotalRent() {
    final rentController = TextEditingController(text: totalRent.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Total Rent"),
          content: TextField(
            controller: rentController,
            decoration: const InputDecoration(hintText: "Enter Total Rent (₺)"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  totalRent = double.tryParse(rentController.text) ?? totalRent;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
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
    final paymentController = TextEditingController();
    final expenseController = TextEditingController(); // Added for expense

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
                controller: paymentController,
                decoration: const InputDecoration(hintText: "Payment"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: expenseController, // Input for expense
                decoration: const InputDecoration(hintText: "Expense"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  users.add({
                    "name": nameController.text,
                    "payment": double.tryParse(paymentController.text) ?? 0.0,
                    "expense": double.tryParse(expenseController.text) ??
                        0.0, // Add expense here
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
    Navigator.pushNamed(
      context,
      '/addTask',
      arguments: {
        'users': users,
        'onTaskAdded': (Task task) {
          setState(() {
            globalTasks.add(task);
          });
        },
      },
    );
  }
}

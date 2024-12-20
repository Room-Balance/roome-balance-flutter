import 'package:flutter/material.dart';
import '../models/task.dart';
import 'notifications_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'list_items_screen.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> users = [];
  List<Task> globalTasks = [];
  List<Map<String, String>> notifications = []; // Notifications data
  final Uuid uuid = Uuid(); // Instance for generating unique IDs

  int _currentIndex = 0;

  Map<String, double> calculateIncomeExpense() {
    double totalIncome = 0;
    double totalExpense = 0;

    for (var user in users) {
      totalIncome += user["payment"] ?? 0.0;
      totalExpense += user["expense"] ?? 0.0;
    }
    return {"income": totalIncome, "expense": totalExpense};
  }

  @override
  Widget build(BuildContext context) {
    final totals = calculateIncomeExpense();

    return Scaffold(
      backgroundColor: const Color(0xFF1A3C34),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Home Balance"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsScreen(tasks: globalTasks),
                ),
              );
            },
          ),
        ],
      ),
      body: _currentIndex == 0
          ? _buildHomeScreen(totals)
          : _currentIndex == 1
              ? ListItemsScreen(tasks: globalTasks, users: users)
              : _currentIndex == 2
                  ? const Center(
                      child: Text(
                        "Calendar Feature Coming Soon",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  : _buildProfilePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddOptions();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHomeScreen(Map<String, double> totals) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Our Home",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          totals["income"] == 0 && totals["expense"] == 0
              ? const Text(
                  "No financial data available.",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                )
              : _buildPieChart(totals),
        ],
      ),
    );
  }

  Widget _buildPieChart(Map<String, double> totals) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 300,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: totals["income"]!,
                color: Colors.greenAccent,
                title: 'Income\n${totals["income"]!.toStringAsFixed(2)}₺',
              ),
              PieChartSectionData(
                value: totals["expense"]!,
                color: Colors.redAccent,
                title: 'Expense\n${totals["expense"]!.toStringAsFixed(2)}₺',
              ),
            ],
            centerSpaceRadius: 50,
            sectionsSpace: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.account_circle, size: 100, color: Colors.white),
        const SizedBox(height: 20),
        const Text(
          "User Profile",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/signIn'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Logout", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
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
            onTap: () {
              Navigator.pop(context);
              _addTask();
            },
          ),
        ],
      ),
    );
  }

  void _addUser() {
    final nameController = TextEditingController();
    final paymentController = TextEditingController();
    final expenseController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: paymentController,
              decoration: const InputDecoration(labelText: "Payment"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: expenseController,
              decoration: const InputDecoration(labelText: "Expense"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  paymentController.text.isNotEmpty &&
                  expenseController.text.isNotEmpty) {
                setState(() {
                  users.add({
                    "name": nameController.text,
                    "payment": double.tryParse(paymentController.text) ?? 0.0,
                    "expense": double.tryParse(expenseController.text) ?? 0.0,
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _addTask() {
    final taskController = TextEditingController();
    String? assignedUser;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(labelText: "Task Name"),
            ),
            DropdownButton<String>(
              hint: const Text("Assign to User"),
              value: assignedUser,
              onChanged: (value) {
                setState(() {
                  assignedUser = value;
                });
              },
              items: users.map((user) {
                return DropdownMenuItem<String>(
                  value: user["name"],
                  child: Text(user["name"]!),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (taskController.text.isNotEmpty && assignedUser != null) {
                setState(() {
                  globalTasks.add(
                    Task(
                      id: uuid.v4(),
                      taskName: taskController.text,
                      assignedUser: assignedUser!,
                    ),
                  );
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  BottomAppBar _buildBottomNavBar() {
    return BottomAppBar(
      color: Colors.green,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () => setState(() => _currentIndex = 0),
          ),
          IconButton(
            icon: const Icon(Icons.list, color: Colors.white),
            onPressed: () => setState(() => _currentIndex = 1),
          ),
          const SizedBox(width: 40),
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () => setState(() => _currentIndex = 2),
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () => setState(() => _currentIndex = 3),
          ),
        ],
      ),
    );
  }
}

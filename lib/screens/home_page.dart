import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> users = []; // Kullanıcı verileri
  List<String> tasks = []; // Task verileri

  int _currentIndex = 0;

  // Gelir ve gider hesaplama
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
              Navigator.pushNamed(context, '/notifications', arguments: tasks);
            },
          ),
        ],
      ),
      body: _currentIndex == 0 ? _buildHomeScreen(totals) : _buildOtherPages(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddOptions,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Our Home",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _buildPieChart(totals),
                const SizedBox(height: 20),
                _buildUserList(),
                const SizedBox(height: 20),
                _buildTaskList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(Map<String, double> totals) {
    return SizedBox(
      height: 200,
      child: Card(
        color: Colors.green.shade700,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Users", style: TextStyle(fontSize: 20, color: Colors.white)),
        const SizedBox(height: 10),
        ...users.map((user) {
          return Card(
            color: Colors.green.shade800,
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: Text(user["name"], style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                "Payment: ${user["payment"]}₺ | Expense: ${user["expense"]}₺",
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTaskList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tasks", style: TextStyle(fontSize: 20, color: Colors.white)),
        const SizedBox(height: 10),
        tasks.isEmpty
            ? const Text("No tasks yet!", style: TextStyle(color: Colors.white70))
            : Column(
                children: tasks.map((task) {
                  return Card(
                    color: Colors.green.shade600,
                    child: ListTile(
                      leading: const Icon(Icons.task, color: Colors.white),
                      title: Text(task, style: const TextStyle(color: Colors.white)),
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }

  Widget _buildOtherPages() {
    if (_currentIndex == 1) {
      return const Center(
          child: Text("Task List Page", style: TextStyle(fontSize: 24, color: Colors.white)));
    } else if (_currentIndex == 2) {
      return const Center(
          child: Text("Calendar Page", style: TextStyle(fontSize: 24, color: Colors.white)));
    } else {
      return _buildProfilePage();
    }
  }

  Widget _buildProfilePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.account_circle, size: 100, color: Colors.white),
        const SizedBox(height: 20),
        const Text("User Profile", style: TextStyle(fontSize: 24, color: Colors.white)),
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
            onTap: _addTask,
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
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: paymentController, decoration: const InputDecoration(labelText: "Payment")),
            TextField(controller: expenseController, decoration: const InputDecoration(labelText: "Expense")),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                users.add({
                  "name": nameController.text,
                  "payment": double.tryParse(paymentController.text) ?? 0,
                  "expense": double.tryParse(expenseController.text) ?? 0,
                });
              });
              Navigator.pop(ctx);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _addTask() {
    final taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          controller: taskController,
          decoration: const InputDecoration(labelText: "Task Description"),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks.add(taskController.text);
              });
              Navigator.pop(ctx);
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
              onPressed: () => setState(() => _currentIndex = 0)),
          IconButton(
              icon: const Icon(Icons.list, color: Colors.white),
              onPressed: () => setState(() => _currentIndex = 1)),
          const SizedBox(width: 40), // Boşluk
          IconButton(
              icon: const Icon(Icons.calendar_today, color: Colors.white),
              onPressed: () => setState(() => _currentIndex = 2)),
          IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () => setState(() => _currentIndex = 3)),
        ],
      ),
    );
  }
}

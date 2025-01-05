import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/task.dart';
import 'list_items_screen.dart';
import 'calendar_screen.dart';
import 'profile_screen.dart';
import 'package:uuid/uuid.dart';
import '../helpers/chart_helpers.dart';

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
      "payment": 150.0, // Total rent paid
      "expense": 50.0, // Total expense
      "houseExpense": 50.0, // House expense
    },
    {
      "name": "Bob",
      "email": "bob@example.com",
      "payment": 200.0,
      "expense": 100.0,
      "houseExpense": 100.0,
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
      title: Row(
        children: [
          Icon(Icons.home, size: 28), // Home icon stays here
          SizedBox(width: 8), // Space between icon and text
          Text(
            "Home Balance",
            style: TextStyle(
              fontWeight: FontWeight.bold, // Bold text for title
              fontSize: 20, // Adjusted font size
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false, // Removes the back button
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: _editTotalRent,
        ),
        IconButton(
          icon: const Icon(Icons.attach_money),
          onPressed: _showPaymentDialog,
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            Navigator.pushNamed(context, '/notifications', arguments: globalTasks);
          },
        ),
      ],
    ),
    body: Column(
      children: [
        if (_currentIndex == 0) ...[
          _buildRentPieChart(), // Rent pie chart
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildExpenseList(), // Expense table
                ],
              ),
            ),
          ),
        ] else ...[
          Expanded(child: _pages[_currentIndex]), // Other pages
        ],
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _showAddOptions,
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: const Icon(Icons.add, size: 28),
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

    return buildEnhancedRentPieChart(rentPaid, rentRemaining);
  }

  Widget _buildExpenseList() {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Other Expenses",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading:
                      const Icon(Icons.account_circle, color: Colors.green),
                  title: Text(user['name']),
                  subtitle: Text(
                    "Rent Paid: ${user['payment']}₺\n"
                    "House Expense: ${user['houseExpense']}₺",
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addPayment(String userName, double paymentAmount) {
    setState(() {
      final user = users.firstWhere((u) => u['name'] == userName);
      user['payment'] += paymentAmount;
    });
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
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.green),
              title: const Text("Add User"),
              onTap: () {
                Navigator.pop(context); // Close the modal
                _addUser();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.task, color: Colors.blue),
              title: const Text("Add Task"),
              onTap: () {
                Navigator.pop(context); // Close the modal
                _addTask();
              },
            ),
          ],
        ),
      );
    },
  );
}


  void _addUser() {
    final nameController = TextEditingController();
    final rentPaymentController = TextEditingController(); // Rent payment
    final houseExpenseController = TextEditingController(); // House expense

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
                controller: rentPaymentController,
                decoration: const InputDecoration(hintText: "Rent Payment"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: houseExpenseController,
                decoration: const InputDecoration(hintText: "House Expense"),
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
                    "payment":
                        double.tryParse(rentPaymentController.text) ?? 0.0,
                    "expense":
                        double.tryParse(houseExpenseController.text) ?? 0.0,
                    "houseExpense":
                        double.tryParse(houseExpenseController.text) ?? 0.0,
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

  void _showPaymentDialog() {
    String? selectedUser;
    final paymentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Payment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                hint: const Text("Select User"),
                value: selectedUser,
                items: users.map((user) {
                  return DropdownMenuItem<String>(
                    value: user['name'],
                    child: Text(user['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedUser = value;
                  });
                },
              ),
              TextField(
                controller: paymentController,
                decoration: const InputDecoration(hintText: "Payment Amount"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (selectedUser != null && paymentController.text.isNotEmpty) {
                  _addPayment(
                      selectedUser!, double.parse(paymentController.text));
                  Navigator.pop(context);
                }
              },
              child: const Text("Add Payment"),
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

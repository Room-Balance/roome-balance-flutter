import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ListItemsScreen extends StatefulWidget {
  final List<Task> tasks;
  final List<Map<String, dynamic>> users;

  const ListItemsScreen({Key? key, required this.tasks, required this.users})
      : super(key: key);

  @override
  _ListItemsScreenState createState() => _ListItemsScreenState();
}

class _ListItemsScreenState extends State<ListItemsScreen> {
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    tasks = List.from(widget.tasks); // Starting `tasks` list 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks and Users'),
        backgroundColor: Colors.green,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Payment Distribution",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildUserPaymentsPieChart(),
              const SizedBox(height: 20),
              const Text(
                "Assigned Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTaskTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserPaymentsPieChart() {
    double totalPayments = widget.users.fold(0, (sum, user) => sum + (user['payment'] as double));

    if (totalPayments == 0) {
      return const Center(
        child: Text(
          "No payments made yet.",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: widget.users.map((user) {
            double paymentPercentage = (user['payment'] as double) / totalPayments * 100;
            return PieChartSectionData(
              color: Colors.primaries[widget.users.indexOf(user) % Colors.primaries.length],
              value: paymentPercentage,
              title: "${user['name']} ${paymentPercentage.toStringAsFixed(1)}%",
              radius: 50,
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            );
          }).toList(),
        ),
      ),
    );
  }

Widget _buildTaskTable() {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Assigned Tasks",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          tasks.isEmpty
              ? const Center(
                  child: Text(
                    "No tasks assigned.",
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Yatay kaydırma
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Task Name")),
                      DataColumn(label: Text("User")),
                      DataColumn(label: Text("Due Date")),
                      DataColumn(label: Text("Actions")),
                    ],
                    rows: tasks.map((task) {
                      return DataRow(cells: [
                        DataCell(Text(task.taskName)),
                        DataCell(Text(task.assignedUser)),
                        DataCell(Text(DateFormat('yyyy-MM-dd').format(task.dueDate))),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteTask(task);
                            },
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
        ],
      ),
    ),
  );
}


  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task); 
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${task.taskName} deleted!'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

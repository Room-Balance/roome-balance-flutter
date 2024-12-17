import 'package:flutter/material.dart';

class ListItemsScreen extends StatelessWidget {
  const ListItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy veriler
    final items = [
      {"type": "Task", "name": "Pay Rent", "amount": 500},
      {"type": "User", "name": "Alice", "contribution": 200},
      {"type": "Task", "name": "Clean Kitchen", "amount": 0},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("List Items"), backgroundColor: Colors.green),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: Icon(item['type'] == "Task" ? Icons.task : Icons.person),
            title: Text("${item['type']}: ${item['name']}"),
            subtitle: item['amount'] != null
                ? Text("Amount: ${item['amount']}₺")
                : Text("Contribution: ${item['contribution']}₺"),
          );
        },
      ),
    );
  }
}

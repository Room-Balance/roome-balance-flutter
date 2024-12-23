import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onUserAdded;

  const AddUserScreen({Key? key, required this.onUserAdded}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController expenseController = TextEditingController();

  void addUser() {
    if (nameController.text.isNotEmpty &&
        paymentController.text.isNotEmpty &&
        expenseController.text.isNotEmpty) {
      widget.onUserAdded({
        "name": nameController.text,
        "payment": double.tryParse(paymentController.text) ?? 0.0,
        "expense": double.tryParse(expenseController.text) ?? 0.0,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully!')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Username"),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addUser,
              child: const Text("Add User"),
            ),
          ],
        ),
      ),
    );
  }
}

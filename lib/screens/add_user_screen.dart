import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onUserAdded;
  final Function(double) onRentUpdated;

  const AddUserScreen({
    Key? key,
    required this.onUserAdded,
    required this.onRentUpdated,
  }) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void addUserAndRent() {
    if (_formKey.currentState!.validate()) {
      // Add the user
      widget.onUserAdded({
        "name": nameController.text.trim(),
        "payment": double.tryParse(paymentController.text.trim()) ?? 0.0,
        "expense": double.tryParse(expenseController.text.trim()) ?? 0.0,
      });

      // Update the rent if provided
      if (rentController.text.trim().isNotEmpty) {
        widget.onRentUpdated(double.tryParse(rentController.text.trim()) ?? 0.0);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User and Rent added successfully!')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User and Rent"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "User Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a user name.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: paymentController,
                  decoration: const InputDecoration(
                    labelText: "Payment (₺)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter the payment amount.";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid number.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: expenseController,
                  decoration: const InputDecoration(
                    labelText: "Expense (₺)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter the expense amount.";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid number.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: rentController,
                  decoration: const InputDecoration(
                    labelText: "Total Rent (₺)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      if (double.tryParse(value) == null) {
                        return "Please enter a valid number.";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: addUserAndRent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                  ),
                  child: const Text(
                    "Add User and Rent",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
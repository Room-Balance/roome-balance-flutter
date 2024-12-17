import 'package:flutter/material.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: "Username")),
            TextField(decoration: const InputDecoration(labelText: "Contribution")),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Add User"),
            ),
          ],
        ),
      ),
    );
  }
}

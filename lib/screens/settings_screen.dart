import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  // Constructor no longer const to handle non-constant fields
  SettingsScreen({Key? key}) : super(key: key);

  // TextEditingController objects to manage user input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"), // Title of the screen
        backgroundColor: Colors.green, // App bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds padding around the screen
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text field for updating the name
            TextField(
              controller: nameController, // Links this field to the controller
              decoration: const InputDecoration(
                labelText: "Update Name", // Label for the field
                border: OutlineInputBorder(), // Border styling
              ),
            ),
            const SizedBox(height: 16), // Adds spacing between fields

            // Text field for updating the email
            TextField(
              controller: emailController, // Links this field to the controller
              decoration: const InputDecoration(
                labelText: "Update Email", // Label for the field
                border: OutlineInputBorder(), // Border styling
              ),
            ),
            const SizedBox(height: 24), // Adds spacing before the button

            // Save changes button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveChanges(context); // Function to save changes
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Matches app theme color
                ),
                child: const Text("Save Changes"), // Button text
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to save user changes
  void _saveChanges(BuildContext context) {
    final String name = nameController.text.trim(); // Removes extra spaces
    final String email = emailController.text.trim(); // Removes extra spaces

    // Validates if fields are empty
    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")), // Error feedback
      );
      return; // Stops execution
    }

    // Example backend integration (unimplemented in this example)
    // updateUser(name, email);

    Navigator.pop(context); // Closes the current screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")), // Success feedback
    );
  }

  // Example placeholder for updating user data to backend
  void updateUser(String name, String email) async {
    // Example Firebase or REST API integration:
    /*
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'name': name,
      'email': email,
    });
    */
  }
}

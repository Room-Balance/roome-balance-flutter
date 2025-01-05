import 'package:flutter/material.dart';
import '../main.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.green,
        leading: Container(),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Change Language"),
            onTap: () => _showLanguageSelector(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signIn');
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(title: Text("Select Language")),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("English"),
              onTap: () {
                Navigator.pop(context);
                MyApp.of(context)!.setLocale(const Locale('en')); // English için
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Language changed to English!")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Türkçe"),
              onTap: () {
                Navigator.pop(context);
                MyApp.of(context)!.setLocale(const Locale('tr')); // Türkçe için
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Dil Türkçe olarak değiştirildi!"),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

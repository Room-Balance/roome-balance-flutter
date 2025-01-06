import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profileTitle),
        backgroundColor: Colors.green,
        leading: Container(),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.changeLanguage),
            onTap: () => _showLanguageSelector(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppLocalizations.of(context)!.logout),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signIn');
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    final Map<String, Locale> languages = {
      'English': const Locale('en'),
      'Türkçe': const Locale('tr'),
    };

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.changeLanguage),
            ),
            ...languages.entries.map((entry) {
              return ListTile(
                leading: const Icon(Icons.language),
                title: Text(entry.key),
                onTap: () {
                  Navigator.pop(context);
                  _confirmLanguageChange(context, entry.key, entry.value);
                },
              );
            }),
          ],
        );
      },
    );
  }

  void _confirmLanguageChange(
      BuildContext context, String languageName, Locale locale) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.changeLanguage),
          content: Text(
              "Are you sure you want to change the language to $languageName?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // İptal
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                MyApp.of(context)?.setLocale(locale);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Language changed to $languageName!")),
                );
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}

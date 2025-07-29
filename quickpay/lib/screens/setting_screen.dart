import 'package:flutter/material.dart';
import '../theme_notifier.dart'; // Make sure path is correct

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationAccess = false;

  // Use this getter to check current theme mode
  bool get _darkMode => themeModeNotifier.value == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),

          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                themeModeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
              });
            },
            secondary: const Icon(Icons.brightness_6),
          ),

          SwitchListTile(
            title: const Text('Location Access'),
            value: _locationAccess,
            onChanged: (bool value) {
              setState(() {
                _locationAccess = value;
              });
            },
            secondary: const Icon(Icons.location_on),
          ),

          // ... rest of your ListTiles
        ],
      ),
    );
  }
}

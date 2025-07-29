import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import 'screens/login_screen.dart';
import 'theme_notifier.dart'; // <-- import the theme notifier

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );

  runApp(const QuickPayApp());
}

class QuickPayApp extends StatelessWidget {
  const QuickPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'QuickPay',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
        );
      },
    );
  }
}

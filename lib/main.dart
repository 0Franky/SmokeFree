import 'package:flutter/material.dart';
import 'package:smoke_free/screens/WelcomePage/WelcomePage.dart';

void main() {
  prepareApp();
  runApp(const MyApp());
}

void prepareApp() {
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmokeFree',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 39, 0, 107),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: WelcomePage(),
    );
  }
}

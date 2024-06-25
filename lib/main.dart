import 'package:flutter/material.dart';
import 'package:smoke_free/consts/app_consts.dart';
import 'package:smoke_free/repos/user_storage_utils.dart';
import 'package:smoke_free/screens/HomePage/HomePage.dart';
import 'package:smoke_free/screens/WelcomePage/WelcomePage.dart';
import 'package:smoke_free/style/theme.dart';
import 'package:get/get.dart';

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
    return GetMaterialApp(
      title: APP_NAME,
      theme: appTheme,
      home: FutureBuilder<bool>(
        future: isFirstOpen(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isFirstOpen = snapshot.data ?? false;
            return isFirstOpen ? WelcomePage() : const HomePage();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smoke_free/consts/app_consts.dart';
import 'package:smoke_free/repos/UserStorage.dart';
import 'package:smoke_free/repos/user_storage_utils.dart';
import 'package:smoke_free/screens/HomePage/HomePage.dart';
import 'package:smoke_free/screens/WelcomePage/WelcomePage.dart';
import 'package:smoke_free/style/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() async {
  await prepareApp();
  runApp(const MyApp());
}

Future<void> prepareApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await updateDBData();
}

Future<void> updateDBData() async {
  final mainInfo = await getMainInformation();

  if (mainInfo != null) {
    final dailyMap = await getDailyRecordsMap();

    final keysDate = dailyMap.dailyRecords.keys
        .map((e) => DateFormat('dd-MM-yyyy').parse(e))
        .toList()..sort();
    final currKey = keysDate.where((e) => e.isAfter(DateTime.now())).first;

    final daily = dailyMap.dailyRecords[getDailyRecordMapKey(currKey)]!;

    if (daily.isGoal) {
      mainInfo.currentMaxCigarettesPerDay = daily.maxAllowedCigarettes;
      UserStorage.save(MAIN_INFORMATION_ENTRY, mainInfo);
    }
  }
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

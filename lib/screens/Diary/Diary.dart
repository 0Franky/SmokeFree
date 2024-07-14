import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smoke_free/consts/app_consts.dart';
import 'package:smoke_free/repos/UserStorage.dart';
import 'package:smoke_free/repos/user_storage_utils.dart';
import 'package:smoke_free/screens/WelcomePage/utils/DateTimeProvider.dart';
import 'package:smoke_free/style/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DateTimeProvider(DateTime.now()),
      child: GetMaterialApp(
        title: APP_NAME,
        theme: appTheme,
        home: DiaryPage(),
      ),
    ),
  );
}

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late DateTime currentSelectedDate;
  TextEditingController diaryContent = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentSelectedDate = Provider.of<DateTimeProvider>(context).selectedDate;
    _loadDiaryContent();
  }

  @override
  void dispose() {
    _saveDiaryContent();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: APP_BAR(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Diario del ${getDailyRecordMapKey(currentSelectedDate)}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Scrivi il tuo diario...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 20,
                keyboardType: TextInputType.multiline,
                controller: diaryContent,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Contenuto diario salvato'),
                    ),
                  );
                  _saveDiaryContent(); // Save content when button is pressed
                },
                child: Text('Salva'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadDiaryContent() async {
    final data = await getDailyRecord(currentSelectedDate);
    if (data != null) {
      diaryContent.text = data.personalNotes;
    }
  }

  Future<void> _saveDiaryContent() async {
    final data = await getDailyRecord(currentSelectedDate);
    if (data != null) {
      data.personalNotes = diaryContent.text;
      await updateDailyRecord(data);
    }
  }
}

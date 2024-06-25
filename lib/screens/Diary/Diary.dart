import 'package:flutter/material.dart';
import 'package:smoke_free/consts/app_consts.dart';
import 'package:smoke_free/repos/UserStorage.dart';
import 'package:smoke_free/repos/user_storage_utils.dart';
import 'package:smoke_free/style/theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: APP_NAME,
      theme: appTheme,
      home: DiaryPage(),
    ),
  );
}

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  TextEditingController diaryContent = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Scrivi il tuo diario...',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: diaryContent,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // _saveDiaryContent();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Contenuto diario salvato'),
                    ),
                  );
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
    final data = await getDailyRecord();
    diaryContent.text = data.personalNotes;
  }

  Future<void> _saveDiaryContent() async {
    final data = await getDailyRecord();
    data.personalNotes = diaryContent.text;
    await UserStorage.save(DAILY_RECORD_ENTRY, data);
  }
}

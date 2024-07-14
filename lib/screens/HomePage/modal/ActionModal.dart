import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smoke_free/repos/user_storage_utils.dart';
import 'package:smoke_free/screens/Diary/Diary.dart';
import 'package:smoke_free/screens/HomePage/HomePage.dart';
import 'package:smoke_free/screens/WelcomePage/utils/DateTimeProvider.dart';
import 'package:provider/provider.dart';

class ActionModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(34.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Azione per incrementare il contatore delle sigarette
              incrementCigarettes(
                  date:   Provider.of<DateTimeProvider>(context, listen: false)
                      .selectedDate);
                Get.back(); // Chiudi la modale
                Get.off(HomePage());
            },
            child: getText(context, 'Ho fumato'),
          ),
          SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              // Azione per aprire un'altra pagina (es. DiaryPage)
              Get.to(() => DiaryPage());
            },
            child: getText(context, 'Vorrei fumare'),
          ),
        ],
      ),
    );
  }

  Widget getText(BuildContext context, String text) => Text(text, style: TextStyle(fontSize: 22));
}

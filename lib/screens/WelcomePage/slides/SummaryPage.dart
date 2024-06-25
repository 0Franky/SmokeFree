import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smoke_free/screens/HomePage/HomePage.dart';

Widget buildSummaryPage(
    final BuildContext context, final PageController pageController) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: finalize,
          child: Text('Conferma e torna alla Home'),
        ),
      ],
    ),
  );
}

void finalize() {
  Get.off(HomePage());
}

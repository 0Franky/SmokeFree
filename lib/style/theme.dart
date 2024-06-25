import 'package:flutter/material.dart';
import 'package:smoke_free/consts/app_consts.dart';
import 'package:get/get.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 5, 47, 95),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);

AppBar APP_BAR() => AppBar(
      title: Text(APP_NAME),
      centerTitle: true,
      leading: Get.context != null && Navigator.canPop(Get.context!)
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Get.back(),
            )
          : null,
    );

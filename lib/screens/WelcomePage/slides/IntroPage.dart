import 'package:flutter/material.dart';
import 'package:smoke_free/consts/values.dart';

Widget buildIntroPage(final PageController pageController) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Benvenuto in SmokeFree',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Image.asset('images/logo.jpg', height: 200),
        SizedBox(height: 20),
        Text(
          'L\'app che ti supporta nel tuo percorso per smettere di fumare. Inizia oggi stesso per migliorare la tua salute e il tuo futuro.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            pageController.nextPage(
              duration: ANIMATION_DURATION_MEDIUM,
              curve: Curves.ease,
            );
          },
          child: Text('Inizia'),
        ),
      ],
    ),
  );
}

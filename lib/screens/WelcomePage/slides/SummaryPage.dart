import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smoke_free/screens/WelcomePage/models/UserData.dart';

Widget buildSummaryPage(final BuildContext context, UserData userData, final PageController pageController) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'Hai fumato ${userData.cigarettes} sigarette negli ultimi 15 giorni.'),
          SizedBox(height: 20),
          Text('Trigger: ${userData.triggers}'),
          SizedBox(height: 20),
          Text('Supporto sociale: ${userData.hasSupport ? "Sì" : "No"}'),
          SizedBox(height: 20),
          Text(
              'Preferenze di supporto: ${userData.supportPreferences.join(', ')}'),
          SizedBox(height: 20),
          Text(
              'Notifiche abilitate: ${userData.notificationsEnabled ? "Sì" : "No"}'),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text('Conferma e torna alla Home'),
          ),
        ],
      ),
    );
  }
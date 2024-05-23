import 'package:flutter/material.dart';
import 'package:smoke_free/screens/WelcomePage/models/UserData.dart';

Widget buildInitialSetupPage(
  void Function(void Function()) setState,
  UserData userData,
  final PageController pageController,
) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Quanti sigarette hai fumato negli ultimi 15 giorni?',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                userData.cigarettes = int.tryParse(value) ?? 0;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText:
                    'Quali sono le situazioni o le emozioni che scatenano il desiderio di fumare?',
              ),
              onChanged: (value) {
                userData.triggers = value;
              },
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                  'Hai un supporto sociale o familiare nel tuo percorso per smettere di fumare?'),
              value: userData.hasSupport,
              onChanged: (bool? value) {
                setState(() {
                  userData.hasSupport = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
                'Seleziona le tue preferenze di supporto durante il percorso per smettere di fumare:'),
            SwitchListTile(
              title: Text('Consigli pratici'),
              value: userData.supportPreferences.contains('Consigli pratici'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    userData.supportPreferences.add('Consigli pratici');
                  } else {
                    userData.supportPreferences.remove('Consigli pratici');
                  }
                });
              },
            ),
            SwitchListTile(
              title: Text('Supporto emotivo'),
              value: userData.supportPreferences.contains('Supporto emotivo'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    userData.supportPreferences.add('Supporto emotivo');
                  } else {
                    userData.supportPreferences.remove('Supporto emotivo');
                  }
                });
              },
            ),
            SwitchListTile(
              title: Text('Monitoraggio del progresso'),
              value: userData.supportPreferences
                  .contains('Monitoraggio del progresso'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    userData.supportPreferences.add('Monitoraggio del progresso');
                  } else {
                    userData.supportPreferences
                        .remove('Monitoraggio del progresso');
                  }
                });
              },
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                  'Vorresti ricevere notifiche per il supporto durante il tuo percorso per smettere di fumare?'),
              value: userData.notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  userData.notificationsEnabled = value;
                });
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              child: Text('Continua'),
            ),
          ],
        ),
      ),
    ),
  );
}

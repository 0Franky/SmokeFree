import 'package:flutter/material.dart';
import 'package:smoke_free/consts/values.dart';
import 'package:smoke_free/models/store_data/MainInformation.dart';
import 'package:smoke_free/models/store_data/Preferences.dart';
import 'package:smoke_free/repos/UserStorage.dart';
import 'package:smoke_free/screens/WelcomePage/utils/data_utils.dart';
import 'package:smoke_free/screens/WelcomePage/utils/variables.dart';
import 'package:smoke_free/utils/smoke_calculator.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class InitialSetupPage extends StatefulWidget {
  final PageController pageController;

  const InitialSetupPage({
    super.key,
    required this.pageController,
  });

  @override
  State<InitialSetupPage> createState() => _InitialSetupPageState();
}

class _InitialSetupPageState extends State<InitialSetupPage> {
  final TextEditingController userAliasController = TextEditingController();
  final TextEditingController averageCigarettesController =
      TextEditingController();
  final TextEditingController desiredDaysController = TextEditingController();
  final TextEditingController customTriggerController = TextEditingController();
  final TextEditingController aliasController = TextEditingController();
  final TextEditingController supportValueController = TextEditingController();
  final TextEditingController notificationFrequencyController =
      TextEditingController(text: NOTIFICATION_FREQUENCY.toString());

  final TextEditingController typeAheadController = TextEditingController();
  final List<String> additionalSuggestions = [];

  bool socialSupportAvailable = false;
  bool notificationsEnabled = false;
  String? selectedSupportType;
  String? selectedTrigger;
  List<String> smokingTriggers = [];

  @override
  void initState() {
    super.initState();

    averageCigarettesController.addListener(() {
      int? averageCigarettesNumber =
          int.tryParse(averageCigarettesController.text);
      if (averageCigarettesNumber != null) {
        desiredDaysController.text =
            calcucateTotalTimeToQuit(averageCigarettesNumber).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                controller: userAliasController,
                decoration: InputDecoration(
                  labelText: 'Come vuoi essere chiamato?',
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: averageCigarettesController,
                decoration: InputDecoration(
                  labelText:
                      'Quante sigarette hai fumato in media al giorno negli ultimi $NUMBER_DAYS_LAST_CIGARETTES_SMOKED giorni?',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: desiredDaysController,
                decoration: InputDecoration(
                  labelText: 'In quante settimane vuoi smettere di fumare?',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: typeAheadController,
                  decoration: InputDecoration(
                    labelText:
                        'Aggiungi quali emozioni o situazioni ti fanno venire/aumentare la voglia di fumare',
                  ),
                ),
                suggestionsCallback: (pattern) {
                  final List<String> matchingSuggestions = suggestions
                      .where((item) =>
                          item.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();

                  // Aggiungi il nuovo trigger solo se non è già presente nei suggerimenti esistenti
                  if (pattern.isNotEmpty &&
                      !matchingSuggestions.contains(pattern) &&
                      !additionalSuggestions.contains(pattern)) {
                    additionalSuggestions.add(pattern);
                  }

                  return [
                    ...additionalSuggestions,
                    ...matchingSuggestions,
                  ];
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  if (!smokingTriggers.contains(suggestion)) {
                    setState(() {
                      smokingTriggers.add(suggestion);
                      typeAheadController.clear();
                      // additionalSuggestions.clear();
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: smokingTriggers.map((trigger) {
                  return Chip(
                    label: Text(trigger),
                    onDeleted: () {
                      setState(() {
                        smokingTriggers.remove(trigger);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                    'Hai un supporto sociale o familiare nel tuo percorso per smettere di fumare?'),
                value: socialSupportAvailable,
                onChanged: (bool? value) {
                  setState(() {
                    socialSupportAvailable = value ?? false;
                  });
                },
              ),
              if (socialSupportAvailable) ...[
                TextFormField(
                  controller: aliasController,
                  decoration: InputDecoration(
                    labelText: 'Alias (nome del tipo di supporto)',
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedSupportType,
                  decoration: InputDecoration(
                    labelText: 'Tipo di supporto',
                  ),
                  items: ['Numero di telefono', 'Altro']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSupportType = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: supportValueController,
                  decoration: InputDecoration(
                    labelText: 'Valore (testo libero)',
                  ),
                ),
                SizedBox(height: 20),
              ],
              SwitchListTile(
                title: Text(
                    'Vorresti ricevere notifiche per il supporto durante il tuo percorso per smettere di fumare?'),
                value: notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
              if (notificationsEnabled) ...[
                TextFormField(
                  controller: notificationFrequencyController,
                  decoration: InputDecoration(
                    labelText:
                        'Numero di giorni ogni quanto ricevere la notifica',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
              ],
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: finalize,
                child: Text('Continua'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void finalize() async {
    await saveData(
      userAlias: userAliasController.text,
      averageCigarettes: int.tryParse(averageCigarettesController.text) ?? 0,
      smokingTriggers: smokingTriggers,
      desiredDays: int.tryParse(desiredDaysController.text) ?? 0,
      socialSupportAvailable: socialSupportAvailable,
      supportAlias: aliasController.text,
      supportValue: supportValueController.text,
      notificationsEnabled: notificationsEnabled,
      notificationFrequency: int.tryParse(notificationFrequencyController.text),
    );

    widget.pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}

import 'package:smoke_free/models/store_data/DailyRecord.dart';
import 'package:smoke_free/models/store_data/MainInformation.dart';
import 'package:smoke_free/models/store_data/Preferences.dart';
import 'package:smoke_free/repos/UserStorage.dart';
import 'package:smoke_free/utils/smoke_calculator.dart';

void saveData({
  required String userAlias,
  required int averageCigarettes,
  required List<String> smokingTriggers,
  required int desiredDays,
  required bool socialSupportAvailable,
  required String supportAlias,
  required String supportValue,
  required bool notificationsEnabled,
  required int? notificationFrequency,
}) {
  final mainInformation = MainInformation(
    userAlias: userAlias,
    averageCigarettesPerDay: averageCigarettes,
    currentMaxCigarettesPerDay: 0,
    smokingTriggers: smokingTriggers,
    timeline: Timeline(
      startDateQuitting:
          DateTime.now(), // Set start date as now or get from user
      desiredDays: desiredDays,
    ),
    support: socialSupportAvailable
        ? Support(
            alias: supportAlias,
            supportContact: supportValue,
          )
        : null,
  );

  final preferences = Preferences(
    notificationsEnabled: notificationsEnabled,
    notificationFrequencyDays:
        notificationsEnabled ? notificationFrequency : null,
  );

  // save into LocalStorage
  UserStorage.save(MAIN_INFORMATION_ENTRY, mainInformation);
  UserStorage.save(PREFERENCES_ENTRY, preferences);

  // save daily goals
  saveDailyGoals(averageCigarettes, desiredDays);
}

void saveDailyGoals(int averageCigarettes, int desiredDays) {
  int week = 1;
  int maxCigarettes = averageCigarettes;
  int? calculatedDays =
      calcucateTotalTimeToQuit(averageCigarettes) != desiredDays
          ? desiredDays
          : null;
  while (desiredDays >= 0) {
    final dailyRecord = DailyRecord(
      date: getNextMonday(week),
      maxAllowedCigarettes: maxCigarettes,
    );

    maxCigarettes =
        calculateNextMaxCigarettes(maxCigarettes, desiredDays: calculatedDays);
    week++;
    desiredDays--;

    // save daily goals into LocalStorage
    UserStorage.save(DAILY_RECORD_ENTRY, dailyRecord);
  }
}

DateTime getNextMonday(int k) {
  // Get the current date
  DateTime today = DateTime.now();

  // Calculate how many days until next Monday
  int daysUntilNextMonday = (8 - today.weekday) % 7;

  // Calculate the date of the next (k-th) Monday
  DateTime nextMonday =
      today.add(Duration(days: daysUntilNextMonday + 7 * (k - 1)));

  return nextMonday;
}

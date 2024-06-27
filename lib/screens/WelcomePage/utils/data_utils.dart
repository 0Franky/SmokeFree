import 'package:smoke_free/consts/values.dart';
import 'package:smoke_free/models/store_data/DailyRecord.dart';
import 'package:smoke_free/models/store_data/MainInformation.dart';
import 'package:smoke_free/models/store_data/Preferences.dart';
import 'package:smoke_free/repos/UserStorage.dart';
import 'package:smoke_free/repos/user_storage_utils.dart';
import 'package:smoke_free/utils/smoke_calculator.dart';

Future<void> saveData({
  required String userAlias,
  required int averageCigarettesLatestDays,
  required List<String> smokingTriggers,
  required int desiredDays,
  required bool socialSupportAvailable,
  required String supportAlias,
  required String supportValue,
  required bool notificationsEnabled,
  required int? notificationFrequency,
}) async {
  final int averageCigarettes =
      (averageCigarettesLatestDays / NUMBER_DAYS_LAST_CIGARETTES_SMOKED)
          .round();

  final mainInformation = MainInformation(
    userAlias: userAlias,
    averageCigarettesPerDay: averageCigarettes,
    currentMaxCigarettesPerDay: averageCigarettes,
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
  await saveDailyGoals(averageCigarettes, desiredDays);
}

Future<void> saveDailyGoals(int averageCigarettes, int desiredDays) async {
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
      isGoal: true,
    );

    maxCigarettes =
        calculateNextMaxCigarettes(maxCigarettes, desiredDays: calculatedDays);
    week++;
    desiredDays--;

    // save daily goals into LocalStorage
    await updateDailyRecord(dailyRecord);
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

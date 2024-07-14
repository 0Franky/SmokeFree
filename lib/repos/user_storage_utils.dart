import 'package:smoke_free/models/store_data/DailyRecord.dart';
import 'package:smoke_free/models/store_data/MainInformation.dart';
import 'package:smoke_free/repos/UserStorage.dart';

String MAIN_INFORMATION_ENTRY = "mainInformation";
String PREFERENCES_ENTRY = "preferences";
String DAILY_RECORD_MAP_ENTRY = "dailyRecordMap";

Future<MainInformation?> getMainInformation() async {
  return (await UserStorage.loadUserData(
      MAIN_INFORMATION_ENTRY, MainInformation.fromJson));
}

Future<DailyRecordsMap> getDailyRecordsMap() async {
  return (await UserStorage.loadUserData<DailyRecordsMap>(
          DAILY_RECORD_MAP_ENTRY, DailyRecordsMap.fromJson)) ??
      DailyRecordsMap();
}

Future<DailyRecord?> getDailyRecord(DateTime date) async {
  DailyRecordsMap? dailyMap = await getDailyRecordsMap();
  MainInformation? mainInfo = await getMainInformation();

  if (mainInfo == null) return null;

  String dayKey = getDailyRecordMapKey(date);

  DailyRecord daily;

  if (dailyMap.dailyRecords.containsKey(dayKey)) {
    daily = dailyMap.dailyRecords[dayKey]!;
  } else {
    // Find the closest preceding date with a DailyRecord
    DateTime? closestDate;
    int maxCigarettes = mainInfo.currentMaxCigarettesPerDay;

    for (String key in dailyMap.dailyRecords.keys) {
      DateTime recordedDate = _parseDate(key) ;

      if (recordedDate.isBefore(date)) {
        if (closestDate == null || recordedDate.isAfter(closestDate)) {
          closestDate = recordedDate;
          maxCigarettes = dailyMap.dailyRecords[key]?.maxAllowedCigarettes ??
              mainInfo.currentMaxCigarettesPerDay;
        }
      }
    }

    daily = DailyRecord(
      date: date,
      maxAllowedCigarettes: maxCigarettes,
    );

    await updateDailyRecord(daily);
  }

  return daily;
}

String getDailyRecordMapKey(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
}

// Function to parse date from key (assuming key is in "DD-MM-YYYY" format)
DateTime _parseDate(String key) {
  List<String> parts = key.split('-');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  return DateTime(year, month, day);
}

Future<bool> isFirstOpen() async {
  return await getMainInformation() == null;
}

Future<void> updateDailyRecord(DailyRecord dailyRecord) async {
  DailyRecordsMap dailyMap = await getDailyRecordsMap();
  String dayKey = getDailyRecordMapKey(dailyRecord.date);
  dailyMap.dailyRecords[dayKey] = dailyRecord;
  await UserStorage.save(DAILY_RECORD_MAP_ENTRY, dailyMap);
}

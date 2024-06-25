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

Future<DailyRecord> getDailyRecord(DateTime date) async {
  DailyRecordsMap? dailyMap = await getDailyRecordsMap();
  MainInformation mainInfo = (await getMainInformation())!;

  String dayKey = getDailyRecordMapKey(date);

  DailyRecord daily;

  if (dailyMap.dailyRecords.containsKey(dayKey)) {
    daily = dailyMap.dailyRecords[dayKey]!;
  } else {
    daily = DailyRecord(
      date: date,
      maxAllowedCigarettes: mainInfo.currentMaxCigarettesPerDay,
    );

    await updateDailyRecord(daily);
  }

  return daily;
}

String getDailyRecordMapKey(DateTime date) {
  String dayKey = "${date.day}-${date.month}-${date.year}";
  return dayKey;
}

Future<bool> isFirstOpen() async {
  return await getMainInformation() == null;
}

Future<void> updateDailyRecord(DailyRecord dailyRecord) async {
  DailyRecordsMap dailyMap = (await getDailyRecordsMap()) ?? DailyRecordsMap();
  String dayKey = getDailyRecordMapKey(dailyRecord.date);
  dailyMap.dailyRecords[dayKey] = dailyRecord;
  await UserStorage.save(DAILY_RECORD_MAP_ENTRY, dailyMap);
}

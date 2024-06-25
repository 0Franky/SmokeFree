import 'package:localstore/localstore.dart';
import 'package:smoke_free/models/store_data/DailyRecord.dart';
import 'package:smoke_free/models/store_data/GenericStoreData.dart';
import 'package:smoke_free/models/store_data/MainInformation.dart';

class UserStorage {
  static final _db = Localstore.instance;

  static Future<void> save<T extends Genericstoredata>(
    String id,
    T data,
  ) async {
    await _db.collection('smoke_free_data').doc(id).set(data.toJson());
  }

  static Future<T?> loadUserData<T extends Genericstoredata>(
    String id,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final data = await _db.collection('smoke_free_data').doc(id).get();
    if (data != null) {
      return fromJson(data);
    } else {
      return null;
    }
  }
}

String MAIN_INFORMATION_ENTRY = "mainInformation";
String PREFERENCES_ENTRY = "preferences";
String DAILY_RECORD_ENTRY = "dailyRecord";

Future<DailyRecord> getDailyRecord() async {
  DailyRecord? daily =
      await UserStorage.loadUserData(DAILY_RECORD_ENTRY, DailyRecord.fromJson);

  MainInformation mainInfo = (await UserStorage.loadUserData(
      MAIN_INFORMATION_ENTRY, MainInformation.fromJson))!;

  if (daily == null) {
    daily = DailyRecord(
      maxAllowedCigarettes: mainInfo.currentMaxCigarettesPerDay,
    );

    await UserStorage.save(DAILY_RECORD_ENTRY, daily);
  }

  return daily;
}

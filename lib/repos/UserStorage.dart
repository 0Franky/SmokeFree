import 'package:localstore/localstore.dart';
import 'package:smoke_free/models/store_data/GenericStoreData.dart';

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

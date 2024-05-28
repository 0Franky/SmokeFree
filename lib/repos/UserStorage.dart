import 'package:localstore/localstore.dart';
import 'package:smoke_free/models/store_data/GenericStoreData.dart';

class UserStorage {
  final db = Localstore.instance;

  Future<void> save<T extends Genericstoredata>(
    String collection,
    String id,
    T data,
  ) async {
    await db.collection(collection).doc(id).set(data.toJson());
  }

  Future<T?> loadUserData<T extends Genericstoredata>(
    String collection,
    String id,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final data = await db.collection(collection).doc(id).get();
    if (data != null) {
      return fromJson(data);
    } else {
      return null;
    }
  }
}

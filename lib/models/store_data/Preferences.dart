import 'package:smoke_free/models/store_data/GenericStoreData.dart';

class Preferences extends Genericstoredata {
  bool notificationsEnabled;
  int?
      notificationFrequencyDays; // Frequency of notifications (e.g.: 7, 15, 30 days)

  Preferences({
    required this.notificationsEnabled,
    this.notificationFrequencyDays,
  });

  @override
  Map<String, dynamic> toJson() => {
        'notificationsEnabled': notificationsEnabled,
        'notificationFrequencyDays': notificationFrequencyDays,
      };

  @override
  static Preferences fromJson(Map<String, dynamic> data) => Preferences(
        notificationsEnabled: data['notificationsEnabled'] as bool,
        notificationFrequencyDays: data['notificationFrequencyDays'] as int?,
      );
}

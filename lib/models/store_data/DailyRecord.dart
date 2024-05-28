import 'package:smoke_free/models/store_data/GenericStoreData.dart';

class DailyRecord extends Genericstoredata {
  final DateTime date;
  final bool smoked;
  final String personalNotes;
  final SmokingDesire? smokingDesire;

  DailyRecord({
    required this.date,
    required this.smoked,
    required this.personalNotes,
    this.smokingDesire,
  });

  bool hasSmokeDesire() => smokingDesire != null;

  @override
  Map<String, dynamic> toJson() => {
        'date': date.toString(), // Convert DateTime to string for JSON
        'smoked': smoked,
        'personalNotes': personalNotes,
        'smokingDesire': smokingDesire?.toJson(), // Handle null case
      };

  @override
  static DailyRecord fromJson(Map<String, dynamic> data) => DailyRecord(
        date: DateTime.parse(
            data['date'] as String), // Parse string back to DateTime
        smoked: data['smoked'] as bool,
        personalNotes: data['personalNotes'] as String,
        smokingDesire: data['smokingDesire'] != null
            ? SmokingDesire.fromJson(
                data['smokingDesire'] as Map<String, dynamic>)
            : null,
      );
}

class SmokingDesire extends Genericstoredata {
  final int? desireScale; // Scale from 1 (green) to 5 (red)
  final List<String>? distractionActivities;

  SmokingDesire({
    required this.desireScale,
    required this.distractionActivities,
  });

  @override
  Map<String, dynamic> toJson() => {
        'desireScale': desireScale,
        'distractionActivities': distractionActivities,
      };

  @override
  static SmokingDesire fromJson(Map<String, dynamic> data) => SmokingDesire(
        desireScale: data['desireScale'] as int?,
        distractionActivities: data['distractionActivities'] as List<String>?,
      );
}

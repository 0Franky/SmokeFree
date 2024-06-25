import 'package:smoke_free/models/store_data/GenericStoreData.dart';

class DailyRecord extends Genericstoredata {
  DateTime? date;
  final int maxAllowedCigarettes;
  int numCigarettesSmoked;
  String personalNotes;
  SmokingDesire? smokingDesire;

  DailyRecord({
    this.date,
    required this.maxAllowedCigarettes,
    this.numCigarettesSmoked = 0,
    this.personalNotes = "",
    this.smokingDesire,
  }) {
    date ??= DateTime.now();
  }

  bool hasSmokeDesire() => smokingDesire != null;
  bool hasSmoked() => numCigarettesSmoked > 0;
  bool hasSmokedMoreThenAllowed() => numCigarettesSmoked > maxAllowedCigarettes;

  @override
  Map<String, dynamic> toJson() => {
        'date': date.toString(), // Convert DateTime to string for JSON
        'maxAllowedCigarettes': maxAllowedCigarettes,
        'numCigarettesSmoked': numCigarettesSmoked,
        'personalNotes': personalNotes,
        'smokingDesire': smokingDesire?.toJson(), // Handle null case
      };

  @override
  static DailyRecord fromJson(Map<String, dynamic> data) => DailyRecord(
        date: DateTime.parse(
            data['date'] as String), // Parse string back to DateTime
        maxAllowedCigarettes: data['maxAllowedCigarettes'] as int,
        numCigarettesSmoked: data['numCigarettesSmoked'] as int,
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

class DailyRecord {
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
}

class SmokingDesire {
  final int? desireScale; // Scale from 1 (green) to 5 (red)
  final List<String>? distractionActivities;

  SmokingDesire({
    required this.desireScale,
    required this.distractionActivities,
  });
}

import 'package:smoke_free/models/store_data/GenericStoreData.dart';

class MainInformation extends Genericstoredata {
  final String userAlias;
  final int averageCigarettesPerDay;
  int currentMaxCigarettesPerDay;

  final List<String>
      smokingTriggers; // List of triggers (e.g.: stress, boredom, anxiety)

  final Timeline timeline;
  final Support? support;

  MainInformation({
    required this.userAlias,
    required this.averageCigarettesPerDay,
    required this.currentMaxCigarettesPerDay,
    required this.smokingTriggers,
    required this.timeline,
    required this.support,
  });

  bool hasSupport() => support != null;

  @override
  Map<String, dynamic> toJson() => {
        'userAlias': userAlias,
        'averageCigarettesPerDay': averageCigarettesPerDay,
        'currentMaxCigarettesPerDay': currentMaxCigarettesPerDay,
        'smokingTriggers': smokingTriggers,
        'timeline': timeline.toJson(),
        'support': support?.toJson(), // Handle null case for support
      };

  @override
  static MainInformation fromJson(Map<String, dynamic> data) => MainInformation(
        userAlias: data['userAlias'] as String,
        averageCigarettesPerDay: data['averageCigarettesPerDay'] as int,
        currentMaxCigarettesPerDay: data['currentMaxCigarettesPerDay'] as int,
        smokingTriggers: List<String>.from(data['smokingTriggers']),
        timeline: Timeline.fromJson(data['timeline'] as Map<String, dynamic>),
        support: data['support'] != null
            ? Support.fromJson(data['support'] as Map<String, dynamic>)
            : null,
      );
}

class Support extends Genericstoredata {
  final String alias;
  final String
      supportContact; // List of support types (e.g.: friend's phone number, therapist)

  Support({
    required this.alias,
    required this.supportContact,
  });

  Map<String, dynamic> toJson() => {
        'alias': alias,
        'supportContact': supportContact,
      };

  static Support fromJson(Map<String, dynamic> data) => Support(
        alias: data['alias'] as String,
        supportContact: data['supportContact'] as String,
      );
}

class Timeline extends Genericstoredata {
  final DateTime startDateQuitting;
  final int desiredDays; // Desired time in days to quit smoking

  Timeline({
    required this.startDateQuitting,
    required this.desiredDays,
  });

  Map<String, dynamic> toJson() => {
        'startDateQuitting':
            startDateQuitting.toString(), // Convert DateTime to string for JSON
        'desiredDays': desiredDays,
      };

  static Timeline fromJson(Map<String, dynamic> data) => Timeline(
        startDateQuitting: DateTime.parse(data['startDateQuitting']
            as String), // Parse string back to DateTime
        desiredDays: data['desiredDays'] as int,
      );
}

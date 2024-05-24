class MainInformation {
  final int averageCigarettesPerDay;
  final int currentMaxCigarettesPerDay;

  final List<String>
      smokingTriggers; // List of triggers (e.g.: stress, boredom, anxiety)

  final Timeline timeline;
  final Support support;

  MainInformation({
    required this.averageCigarettesPerDay,
    required this.currentMaxCigarettesPerDay,
    required this.smokingTriggers,
    required this.timeline,
    required this.support,
  });
}

class Support {
  final bool socialSupportAvailable;
  final List<String>
      supportTypes; // List of support types (e.g.: friend's phone number, therapist)

  Support({
    required this.socialSupportAvailable,
    required this.supportTypes,
  });
}

class Timeline {
  final DateTime startDateQuitting;
  final int desiredDays; // Desired time in days to quit smoking

  Timeline({
    required this.startDateQuitting,
    required this.desiredDays,
  });
}

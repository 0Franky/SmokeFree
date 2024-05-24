class Preferences {
  final bool notificationsEnabled;
  final int? notificationFrequencyDays; // Frequency of notifications (e.g.: 7, 15, 30 days)

  Preferences({
    required this.notificationsEnabled,
    this.notificationFrequencyDays,
  });
}

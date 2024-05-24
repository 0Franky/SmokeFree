class Goal {
  final String description; // Description of the goal (e.g.: "Remain smoke-free for 24 hours")
  final DateTime startDate;
  final DateTime attainmentDate;
  final bool? achieved; // Indicator if the goal has been achieved

  Goal({
    required this.description,
    required this.startDate,
    required this.attainmentDate,
    this.achieved,
  });
}

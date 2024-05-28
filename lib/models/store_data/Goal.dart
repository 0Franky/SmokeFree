import 'package:smoke_free/models/store_data/GenericStoreData.dart';

class Goal extends Genericstoredata {
  final String
      description; // Description of the goal (e.g.: "Remain smoke-free for 24 hours")
  final DateTime startDate;
  final DateTime attainmentDate;
  final bool? achieved; // Indicator if the goal has been achieved

  Goal({
    required this.description,
    required this.startDate,
    required this.attainmentDate,
    this.achieved,
  });

  @override
  Map<String, dynamic> toJson() => {
        'description': description,
        'startDate':
            startDate.toString(), // Convert DateTime to string for JSON
        'attainmentDate':
            attainmentDate.toString(), // Convert DateTime to string for JSON
        'achieved': achieved,
      };

  @override
  static Goal fromJson(Map<String, dynamic> data) => Goal(
        description: data['description'] as String,
        startDate: DateTime.parse(
            data['startDate'] as String), // Parse string back to DateTime
        attainmentDate: DateTime.parse(
            data['attainmentDate'] as String), // Parse string back to DateTime
        achieved: data['achieved'] as bool?,
      );
}

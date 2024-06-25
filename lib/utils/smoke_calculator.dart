import 'dart:math';

import 'package:smoke_free/consts/values.dart';
import 'package:smoke_free/utils/num_utils.dart';

int calcucateTotalTimeToQuit(int averageCigarettes) {
  int weeks = 0;

  if (averageCigarettes == 0) return weeks;

  do {
    averageCigarettes = calculateNextMaxCigarettes(averageCigarettes);
    weeks++;
  } while (averageCigarettes != 0);

  return weeks;
}

int calculateNextMaxCigarettes(int maxCigarettes, {int? desiredDays}) {
  if (maxCigarettes == 1) return 0;

  double percentage;
  if (desiredDays != null) {
    percentage = calculateWeeklyReductionPercentage(maxCigarettes, desiredDays);
  } else {
    percentage = WEEKLY_REDUCTION_PERCENTAGE;
  }

  return (maxCigarettes * (1 - percentage)).round();
}

double calculateWeeklyReductionPercentage(int maxCigarettes, int weeksToQuit) {
  if (weeksToQuit <= 0 || maxCigarettes <= 0) {
    throw ArgumentError(
        "Weeks to quit and max cigarettes must be greater than 0.");
  }
  return (1 -
      roundToOneDecimalPlace(
          pow((1 / maxCigarettes), (1 / weeksToQuit)).toDouble()));
}

bool calculateSmokingRatio(int numSmoked, int maxSmokable) {
  if (numSmoked == 1) return false;

  // Get the current time
  DateTime now = DateTime.now();

  var smokeRatio = (DAY_HOURS / maxSmokable);

  double minTime = (smokeRatio * numSmoked) - (smokeRatio / 2);

  return minTime > now.hour + (now.minute / 60);
}

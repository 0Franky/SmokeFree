import 'package:smoke_free/consts/values.dart';

int calcucateTotalTimeToQuit(int averageCigarettes) {
  int weeks = 0;

  if (averageCigarettes == 0) return weeks;

  do {
    averageCigarettes = calculateNextMaxCigarettes(averageCigarettes);
    weeks++;
  } while (averageCigarettes != 0);

  return weeks;
}

int calculateNextMaxCigarettes(int maxCigarettes) {
  if (maxCigarettes == 1) return 0;

  return (maxCigarettes * (1 - WEEKLY_REDUCTION_PERCENTAGE)).round();
}

bool calculateSmokingRatio(int numSmoked, int maxSmokable) {
  if (numSmoked == 1) return false;

  // Get the current time
  DateTime now = DateTime.now();

  var smokeRatio = (DAY_HOURS / maxSmokable);
  
  double minTime = (smokeRatio * numSmoked) - (smokeRatio / 2);

  return minTime > now.hour + (now.minute / 60);
}

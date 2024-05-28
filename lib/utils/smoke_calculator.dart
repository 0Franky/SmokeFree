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

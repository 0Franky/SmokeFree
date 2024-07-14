import 'package:flutter/widgets.dart';

class DateTimeProvider with ChangeNotifier {
  DateTime _selectedDate;
  
  DateTimeProvider(this._selectedDate);

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}

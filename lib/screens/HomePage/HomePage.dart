import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:smoke_free/consts/app_consts.dart';
import 'package:smoke_free/style/theme.dart';

void main() {
  runApp(
    MaterialApp(
      title: APP_NAME,
      theme: appTheme,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 500, child: _buildCalendar(context)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Come ti senti oggi?",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CalendarCarousel<Event> _buildCalendar(BuildContext context) {
    return CalendarCarousel<Event>(
      // headerTextStyle: Theme.of(context).textTheme.headlineLarge,
      todayBorderColor: Colors.transparent,
      dayButtonColor: Colors.transparent,
      todayButtonColor: Colors.transparent,
      daysHaveCircularBorder: false,
      todayTextStyle: Theme.of(context).textTheme.labelLarge,
      daysTextStyle: Theme.of(context).textTheme.labelLarge,
      weekendTextStyle: Theme.of(context).textTheme.labelLarge,
      showWeekDays: false,
      firstDayOfWeek: 1,
      customDayBuilder: (
        /// you can provide your own build function to make custom day containers
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
      ) {
        final bg = isSelectedDay
            ? Color.fromARGB(255, 0, 83, 119)
            : Color.fromRGBO(5, 47, 95, 0.1);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: bg,
            border: isToday ? Border.all(color: Colors.grey.shade200) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text(day.day.toString())),
            ],
          ),
        );
      },
    );
  }
}

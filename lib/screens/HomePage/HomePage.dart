import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smoke_free/consts/app_consts.dart';
import 'package:smoke_free/consts/values.dart';
import 'package:smoke_free/models/store_data/DailyRecord.dart';
import 'package:smoke_free/repos/UserStorage.dart';
import 'package:smoke_free/repos/user_storage_utils.dart';
import 'package:smoke_free/screens/Diary/Diary.dart';
import 'package:smoke_free/style/style.dart';
import 'package:smoke_free/style/theme.dart';
import 'package:smoke_free/utils/smoke_calculator.dart';
import 'package:smoke_free/widgets/card_button.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
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
      appBar: APP_BAR(),
      body: ListView(
        children: [
          SizedBox(height: 500, child: _buildCalendar(context)),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                QuickTodayStats(),
                Text(
                  "Come ti senti oggi?",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Wrap(
                  children: [
                    CardButton(
                      icon: FontAwesomeIcons.plus,
                      text: "Aggiungi azione",
                    ),
                    CardButton(
                      icon: FontAwesomeIcons.penToSquare,
                      text: "Il mio diario",
                      onTap: () => Get.to(() => DiaryPage(
                          date: DateTime
                              .now())), // TODO da camiare con data attuale
                    ),
                    CardButton(
                      icon: FontAwesomeIcons.crown,
                      text: "Aggiungi obbiettivo",
                    ),
                  ],
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
        return CalendarDayWidget(
          isSelectedDay: isSelectedDay,
          isToday: isToday,
          day: day,
        );
      },
    );
  }
}

class CalendarDayWidget extends StatefulWidget {
  final bool isSelectedDay;
  final bool isToday;
  final DateTime day;

  const CalendarDayWidget({
    super.key,
    required this.isSelectedDay,
    required this.isToday,
    required this.day,
  });

  @override
  State<CalendarDayWidget> createState() => _CalendarDayWidgetState();
}

class _CalendarDayWidgetState extends State<CalendarDayWidget> {
  late final Color bg;
  bool hasGoal = false;

  @override
  void initState() {
    super.initState();

    bg = widget.isSelectedDay
        ? const Color.fromARGB(255, 0, 83, 119)
        : const Color.fromRGBO(5, 47, 95, 0.1);

    checkHasGoal();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DEFAULT_RADIUS),
        color: bg,
        border: widget.isToday ? Border.all(color: Colors.grey.shade200) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasGoal)
            Center(
                child: FaIcon(
              FontAwesomeIcons.crown,
              size: 16,
            )),
          Center(child: Text(widget.day.day.toString())),
        ],
      ),
    );
  }

  Future<void> checkHasGoal() async {
    hasGoal = (await getDailyRecord(widget.day)).isGoal;
    setState(() {});
  }
}

class QuickTodayStats extends StatefulWidget {
  const QuickTodayStats({
    super.key,
  });

  @override
  State<QuickTodayStats> createState() => _QuickTodayStatsState();
}

class _QuickTodayStatsState extends State<QuickTodayStats> {
  bool loading = true;

  int numSmoked = 0;
  int maxSmokable = 0;
  Color textColor = Colors.transparent;
  bool showWarning = false;
  String warningText = "";

  @override
  void initState() {
    super.initState();
    fetchData();

    getTextColor();

    buildWarning();
  }

  void fetchData() async {
    DailyRecord data = await getDailyRecord(DateTime.now());

    numSmoked = data.maxAllowedCigarettes;
    maxSmokable = data.numCigarettesSmoked;
    setState(() {
      loading = false;
    });
  }

  void buildWarning() {
    if (numSmoked == maxSmokable) {
      warningText = "Hai raggiunto il limite di sigarette giornaliere";
      showWarning = true;
    } else if (numSmoked > maxSmokable) {
      warningText = "Hai fumando troppo, limite superato";
      showWarning = true;
    } else {
      warningText = "Stai fumando troppo velocemente, potresti sforare";
      showWarning = calculateSmokingRatio(numSmoked, maxSmokable);
    }
  }

  void getTextColor() {
    if (numSmoked < maxSmokable - 1) {
      textColor = Colors.green;
    } else if (numSmoked <= maxSmokable) {
      textColor = Colors.orange;
    } else {
      textColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return SizedBox();

    return Column(
      children: [
        Text(
          "Ecco le tue statistiche di oggi",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "●  Hai fumato $numSmoked sigarette",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: textColor),
            ),
            Text(
              "●  Oggi ne puoi fumare massimo $maxSmokable sigarette",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        if (showWarning) ...[
          SizedBox(height: 10),
          Text(
            warningText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
          ),
        ],
        SizedBox(height: 30),
      ],
    );
  }
}

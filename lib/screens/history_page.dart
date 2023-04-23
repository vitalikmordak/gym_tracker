import 'package:flutter/material.dart';
import 'package:gym_tracker/components/swipable_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gym_tracker/constants.dart' as constants;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History'),
        foregroundColor: constants.appBarForegroundColor,
        backgroundColor: constants.appBarBackgroundColor,
        elevation: constants.appBarElevation,),
      body: Column(
        children: [
          //todo: change Calendar style
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomRight: (Radius.circular(15)),
                  bottomLeft: (Radius.circular(15))),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2060, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  headerStyle: HeaderStyle(
                      headerMargin: EdgeInsets.only(left: 15),
                      titleTextStyle:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      formatButtonVisible: false,
                      leftChevronVisible: false,
                      rightChevronVisible: false),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      _selectedDay = selectedDay;
                    });
                  },
                ),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() {
                      if (details.delta.dy > 0) {
                        _calendarFormat = CalendarFormat.month;
                      } else {
                        _calendarFormat = CalendarFormat.week;
                      }
                    });
                  },
                  onTap: () {
                    setState(() {
                      if (_calendarFormat == CalendarFormat.month) {
                        _calendarFormat = CalendarFormat.week;
                      } else {
                        _calendarFormat = CalendarFormat.month;
                      }
                    });
                  },
                  child: const SwipeableIndicator(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

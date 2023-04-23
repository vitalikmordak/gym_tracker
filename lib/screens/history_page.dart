import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gym_tracker/components/swipable_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gym_tracker/constants.dart' as constants;

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<WorkoutEvent>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => WorkoutEvent('Workout $item | ${index + 1}')))
  ..addAll({
    kToday: [
      WorkoutEvent('Today\'s Workout 1'),
      WorkoutEvent('Today\'s Workout 2'),
    ],
  });

class WorkoutEvent {
  final String title;

  const WorkoutEvent(this.title);

  @override
  String toString() => title;
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  List<WorkoutEvent> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  ValueNotifier<List<WorkoutEvent>> _selectedEvents = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        foregroundColor: constants.appBarForegroundColor,
        backgroundColor: constants.appBarBackgroundColor,
        elevation: constants.appBarElevation,
      ),
      body: Column(
        children: [
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
                TableCalendar<WorkoutEvent>(
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
                      _selectedEvents.value = _getEventsForDay(_selectedDay);
                    });
                  },
                  eventLoader: _getEventsForDay,
                  calendarStyle: CalendarStyle(
                      markerSize: 5,
                      markerMargin:
                          EdgeInsets.symmetric(horizontal: 0.7, vertical: 5),
                      todayDecoration: BoxDecoration(
                          color: Colors.grey.shade400, shape: BoxShape.circle),
                      todayTextStyle:
                          TextStyle(color: Colors.white, fontSize: 16.0),
                      selectedDecoration: BoxDecoration(
                          color: Colors.black87, shape: BoxShape.circle)),
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
          ),

          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<WorkoutEvent>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

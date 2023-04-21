import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/screens/exercises_page.dart';
import 'package:gym_tracker/screens/history_page.dart';
import 'package:gym_tracker/screens/start_workout_page.dart';

void main() {
  runApp(GymTracker());
}

class GymTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BottomNavigatorBar(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class BottomNavigatorBar extends StatefulWidget {
  const BottomNavigatorBar({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int _selectedIndex = 1; // default is page in center

  static const List<Widget> _pages = <Widget>[
    HistoryPage(),
    StartWorkoutPage(),
    ExercisesPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_rounded),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_rounded),
            label: 'Start Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_rounded),
            label: 'Exercises',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}


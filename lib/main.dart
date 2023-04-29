import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/screens/exercise_categories_page.dart';
import 'package:gym_tracker/screens/history_page.dart';
import 'package:gym_tracker/screens/start_workout_page.dart';
import 'package:gym_tracker/services/exercise_model.dart';
import 'package:gym_tracker/services/networking_client.dart';
import 'package:gym_tracker/storage/in_memory_storage.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    //todo: refactoring it
    var uri = Uri.http("localhost:8080", "/api/v1/exercises");
    NetworkClient client = NetworkClient(uri);
    String response = await client.getData();

    List parsed = jsonDecode(response);
    List<ExerciseModel> exercises =
        parsed.map((e) => ExerciseModel.fromJson(e)).toList();
    setState(() {
        InMemoryStorage.exercisesByGroup =
            groupBy(exercises, (ExerciseModel em) => ExerciseModel.capitalize(em.groupName));
    });
    var uriSetTypes = Uri.http("localhost:8080", "/api/v1/exercises/sets/type");
    String responseSetTypes = await NetworkClient(uriSetTypes).getData();
    List parsedSetTypes = jsonDecode(responseSetTypes);

    setState(() {
      InMemoryStorage.setTypes = parsedSetTypes.map((e) => e.toString()).toList();
    });

  }

  static const List<Widget> _pages = <Widget>[
    HistoryPage(),
    StartWorkoutPage(),
    ExerciseCategoriesPage()
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/screens/current_workout_page.dart';
import 'package:intl/intl.dart';

class StartWorkoutPage extends StatefulWidget {
  const StartWorkoutPage({Key? key}) : super(key: key);

  @override
  State<StartWorkoutPage> createState() => _StartWorkoutPageState();
}

class _StartWorkoutPageState extends State<StartWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEEE, d MMMM yyyy').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Workout'),
        foregroundColor: Colors.black87,
        backgroundColor: CupertinoColors.systemBackground,
        elevation: 0.8,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              formattedDate,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700,
                  fontSize: 15),
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              child: Text('Start Workout'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CurrentWorkoutPage()));
              },
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}

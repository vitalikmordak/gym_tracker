import 'package:flutter/material.dart';
import 'package:gym_tracker/components/close_alert_dialog.dart';

class CurrentWorkoutBootomSheetPage {
  bool _workoutRunning = true;

  showCurrentWorkoutPage(BuildContext context) {
    //showBottomSheet
    showModalBottomSheet(
        useSafeArea: true,
        // make it bigger, being able to fill the whole screen
        isScrollControlled: true,
        enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0)),
                      child: Text('Finish'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CloseAlertDialog(
                                title: 'Cancel Workout?',
                                content:
                                    'Are you sure you want to cancel this workout? \nAll progress will be lost.',
                                cancelButtonText: 'Cancel Workout',
                                resumeButtonText: 'Resume',
                                cancelAction: () => _workoutRunning = false,
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
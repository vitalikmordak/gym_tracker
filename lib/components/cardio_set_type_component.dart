import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/components/sized_set_type_text_field.dart';
import 'package:gym_tracker/services/dto/cardio_set_model.dart';
import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'package:intl/intl.dart';

class CardioSetTypeComponent extends StatefulWidget {
  const CardioSetTypeComponent(
      {Key? key, required this.setNumber, required this.sets})
      : super(key: key);

  final int setNumber;
  final List<ExerciseSetModel> sets;

  @override
  State<CardioSetTypeComponent> createState() => _CardioSetTypeComponentState();
}

class _CardioSetTypeComponentState extends State<CardioSetTypeComponent> {
  TextEditingController durationController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  Duration initialDuration = const Duration(hours: 0, minutes: 0, seconds: 0);
  late CardioSetModel cardioSetModel;

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts
  // a CupertinoTimerPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  void initState() {
    super.initState();

    /// Creates single CardioSetModel and set value later
    cardioSetModel =
        CardioSetModel(setNumber: widget.setNumber, duration: initialDuration);

    /// Use insert in list to avoid duplication
    widget.sets.insert(widget.setNumber - 1, cardioSetModel);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              widget.setNumber.toString(),
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
          ),
          SizedSetTypeTextField(
            controller: distanceController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onTextFieldChanged: (_) {
              setState(() {
                (widget.sets[widget.sets.indexOf(cardioSetModel)]
                        as CardioSetModel)
                    .distanceInKm = double.parse(distanceController.text);
              });
            },
          ),
          SizedSetTypeTextField(
            keyboardType: TextInputType.none,
            controller: durationController,
            onTextFieldTap: () async {
              _showDialog(
                CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: initialDuration,
                  // This is called when the user changes the timer's
                  // duration.
                  onTimerDurationChanged: (Duration newDuration) {
                    setState(() {
                      initialDuration = newDuration;
                      // return in format HH:mm:ss
                      durationController.text = initialDuration
                          .toString()
                          .split('.')
                          .first
                          .padLeft(8, "0");

                      /// Save specified duration as set to workout object
                      (widget.sets[widget.sets.indexOf(cardioSetModel)]
                              as CardioSetModel)
                          .duration = parse(durationController.text);
                    });
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Duration parse(String duration) {
    final ts = DateFormat('HH:mm:ss').parse(duration);
    return Duration(hours: ts.hour, minutes: ts.minute, seconds: ts.second);
  }
}

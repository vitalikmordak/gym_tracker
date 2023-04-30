import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/components/sized_set_type_text_field.dart';

class DurationSetTypeComponent extends StatefulWidget {
  const DurationSetTypeComponent(
      {Key? key, required this.setNumber, this.onDurationChanged})
      : super(key: key);

  final int setNumber;
  final Function(String)? onDurationChanged;

  @override
  State<DurationSetTypeComponent> createState() =>
      _DurationSetTypeComponentState();
}

class _DurationSetTypeComponentState extends State<DurationSetTypeComponent> {
  TextEditingController timeinput = TextEditingController();
  Duration duration = const Duration(hours: 0, minutes: 0, seconds: 0);

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
            keyboardType: TextInputType.none,
            controller: timeinput,
            onTextFieldChanged: widget.onDurationChanged,
            onTextFieldTap: () async {
              _showDialog(
                CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: duration,
                  // This is called when the user changes the timer's
                  // duration.
                  onTimerDurationChanged: (Duration newDuration) {
                    setState(() {
                      duration = newDuration;
                      // return in format HH:mm:ss
                      timeinput.text =
                          duration.toString().split('.').first.padLeft(8, "0");
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchedChoiceWithTooltip extends StatefulWidget {
  final String leadingText;
  final bool switchValue;
  final ValueChanged onChangeSwitchState;
  final String? tooltipMessage;

  const SwitchedChoiceWithTooltip(
      {Key? key,
      required this.leadingText,
      required this.switchValue,
      required this.onChangeSwitchState,
      this.tooltipMessage})
      : super(key: key);

  @override
  State<SwitchedChoiceWithTooltip> createState() =>
      _SwitchedChoiceWithTooltipState();
}

class _SwitchedChoiceWithTooltipState extends State<SwitchedChoiceWithTooltip> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.leadingText,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            Tooltip(
                showDuration: Duration(seconds: 5),
                margin: EdgeInsets.all(15),
                message: widget.tooltipMessage,
                textStyle: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700.withOpacity(0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                triggerMode: TooltipTriggerMode.tap,
                child: Icon(
                  Icons.info_rounded,
                  color: Colors.grey.shade400,
                )),
          ],
        ),
        CupertinoSwitch(
          value: widget.switchValue,
          onChanged: widget.onChangeSwitchState,
        )
      ],
    );
  }
}

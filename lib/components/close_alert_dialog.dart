import 'package:flutter/material.dart';

const defaultResumeButtonBackgroundColor = Color(0xFF9E9E9E); //grey.shade500

class CloseAlertDialog extends StatelessWidget {
  const CloseAlertDialog(
      {super.key,
      required this.title,
      this.content = '',
      required this.actionButtonText,
      required this.resumeButtonText,
      this.actionButtonOnPressed,
      this.actionButtonStyle,
      this.resumeButtonStyle});

  final String title;
  final String content;
  final String actionButtonText;
  final String resumeButtonText;
  final Function? actionButtonOnPressed;
  final ButtonStyle? actionButtonStyle;
  final ButtonStyle? resumeButtonStyle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      actionsAlignment: MainAxisAlignment.spaceAround,
      content: SizedBox(
        width: double.infinity,
        child: Text(
          content,
          textAlign: TextAlign.center,
        ),
      ),
      actionsPadding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: actionButtonStyle,
            onPressed: () {
              actionButtonOnPressed;
              // Close firstly alert dialog, then bottom modal sheet
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(actionButtonText),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: resumeButtonStyle ?? ElevatedButton.styleFrom(backgroundColor: defaultResumeButtonBackgroundColor),
            onPressed: () =>
                // close only alert dialog
                Navigator.pop(context),
            child: Text(resumeButtonText),
          ),
        ),
      ],
    );
  }
}

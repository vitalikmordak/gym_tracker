import 'package:flutter/material.dart';

class CloseAlertDialog extends StatelessWidget {
  const CloseAlertDialog(
      {super.key,
      required this.title,
      this.content = '',
      required this.cancelButtonText,
      required this.resumeButtonText,
      this.cancelAction});

  final String title;
  final String content;
  final String cancelButtonText;
  final String resumeButtonText;
  final Function? cancelAction;

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
      actionsPadding: EdgeInsets.all(30.0),
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {
              // Close firstly alert dialog, then bottom modal sheet
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(cancelButtonText),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400),
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

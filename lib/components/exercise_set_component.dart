import 'package:flutter/material.dart';

const TextStyle textFieldTextStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 20);

class ExerciseSetComponent extends StatelessWidget {
  const ExerciseSetComponent(
      {Key? key,
      required this.setNumber,
      this.onWeightChanged,
      this.onRepsChanged})
      : super(key: key);

  final int setNumber;
  final Function(String)? onWeightChanged;
  final Function(String)? onRepsChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 20,
            child: Text(
              setNumber.toString(),
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            width: 150,
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              style: textFieldTextStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none),
              ),
              onChanged: onWeightChanged,
            ),
          ),
          SizedBox(
            width: 150,
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              style: textFieldTextStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none),
              ),
              onChanged: onRepsChanged,
            ),
          )
        ],
      ),
    );
  }
}

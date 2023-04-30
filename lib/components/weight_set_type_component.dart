import 'package:flutter/material.dart';
import 'package:gym_tracker/components/sized_set_type_text_field.dart';


class WeightSetTypeComponent extends StatelessWidget {
  const WeightSetTypeComponent(
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
          SizedSetTypeTextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onTextFieldChanged: onWeightChanged,
          ),
          SizedSetTypeTextField(
            keyboardType: TextInputType.number,
            onTextFieldChanged: onRepsChanged,
          )
        ],
      ),
    );
  }
}

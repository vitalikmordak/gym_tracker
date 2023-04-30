import 'package:flutter/material.dart';
import 'package:gym_tracker/components/sized_set_type_text_field.dart';

class RepsOnlySetTypeComponent extends StatelessWidget {
  const RepsOnlySetTypeComponent(
      {Key? key, required this.setNumber, this.onRepsChanged})
      : super(key: key);

  final int setNumber;
  final Function(String)? onRepsChanged;

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
              setNumber.toString(),
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
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

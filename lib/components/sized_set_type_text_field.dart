import 'package:flutter/material.dart';

const TextStyle textFieldTextStyle =
TextStyle(fontWeight: FontWeight.w700, fontSize: 20);

class SizedSetTypeTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Function(String)? onTextFieldChanged;
  final Function()? onTextFieldTap;

  const SizedSetTypeTextField({Key? key,
    required this.keyboardType,
    this.controller,
    this.onTextFieldChanged,
    this.onTextFieldTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: textFieldTextStyle,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          filled: true,
          fillColor: Colors.grey.shade300,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide.none),
        ),
        onChanged: onTextFieldChanged,
        onTap: onTextFieldTap,
      ),
    );
  }
}

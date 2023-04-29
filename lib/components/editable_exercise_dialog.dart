import 'package:flutter/material.dart';
import 'package:gym_tracker/storage/in_memory_storage.dart';

const inputFieldContentPadding =
    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10);

class EditableExerciseDialog extends StatefulWidget {
  final String titleText;
  final String? initialCategory;
  final String? initialSetType;

  const EditableExerciseDialog(
      {Key? key,
      required this.titleText,
      this.initialCategory,
      this.initialSetType})
      : super(key: key);

  @override
  State<EditableExerciseDialog> createState() => _EditableExerciseDialogState();
}

class _EditableExerciseDialogState extends State<EditableExerciseDialog> {
  String? _enteredName;
  String? _selectedCategory;
  String? _selectedSetType;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var exerciseCategories = InMemoryStorage.getExerciseCategories();

    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      splashRadius: 20,
                      style: OutlinedButton.styleFrom(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close_rounded)),
                  Text(
                    widget.titleText,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //form is valid, proceed further
                        _formKey.currentState?.save();
                      }
                      //todo: add logic to save on backend new/updated exercise
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
              TextFormField(
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
                onSaved: (value) => _enteredName = value,
                decoration: InputDecoration(
                  hintText: 'Add Name',
                  contentPadding: inputFieldContentPadding,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide.none),
                ),
              ),
              DropdownButtonFormField(
                value: widget.initialCategory,
                items: exerciseCategories.map((category) {
                  return DropdownMenuItem(
                      value: category, child: Text(category));
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _selectedCategory = newVal;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Choose Category',
                    contentPadding: inputFieldContentPadding,
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    fillColor: Colors.white),
                validator: (value) =>
                    value == null ? 'Category is required' : null,
              ),
              DropdownButtonFormField(
                value: widget.initialSetType,
                items: InMemoryStorage.setTypes.map((setType) {
                  return DropdownMenuItem(value: setType, child: Text(setType));
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _selectedSetType = newVal;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Choose Exercise Type',
                    contentPadding: inputFieldContentPadding,
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    fillColor: Colors.white),
                validator: (value) =>
                    value == null ? 'Exercise type is required' : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

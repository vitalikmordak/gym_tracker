import 'package:flutter/material.dart';
import 'package:gym_tracker/components/switched_choice.dart';
import 'package:gym_tracker/services/exercise_client.dart';
import 'package:gym_tracker/services/exercise_model.dart';
import 'package:gym_tracker/storage/in_memory_storage.dart';

const inputFieldContentPadding =
    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10);

class EditableExerciseDialog extends StatefulWidget {
  final String titleText;
  final String? initialCategory;
  final String? initialSetType;
  final Future<void> Function() applyOnSuccess;

  const EditableExerciseDialog(this.applyOnSuccess,
      {Key? key,
      required this.titleText,
      this.initialCategory,
      this.initialSetType})
      : super(key: key);

  @override
  State<EditableExerciseDialog> createState() => _EditableExerciseDialogState();
}

class _EditableExerciseDialogState extends State<EditableExerciseDialog> {
  late String _enteredName;
  late String _selectedCategory;
  late String _selectedSetType;
  bool _isDoubleWeights = false;
  bool _isBodyWeight = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var exerciseCategories = InMemoryStorage.categories;

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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //form is valid, proceed further
                        _formKey.currentState?.save();
                        ExerciseClient().createExercise(
                          ExerciseModel(
                              name: _enteredName,
                              doubleWeights: _isDoubleWeights,
                              bodyWeight: _isBodyWeight,
                              groupName: _selectedCategory,
                              setCategoryType: _selectedSetType,
                              createdBy:
                                  'unknown' //todo: change when auth will be implemented
                              ),
                        );
                      }
                      await widget.applyOnSuccess.call();
                      Navigator.pop(context);
                      //todo: update logic to save on backend updated exercise
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
              TextFormField(
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
                onSaved: (value) => _enteredName = value!,
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
                    _selectedCategory = newVal!;
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
                    _selectedSetType = newVal!;
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
              ),
              SwitchedChoiceWithTooltip(
                leadingText: 'Double Weights',
                tooltipMessage:
                    'For exercises with double weights (e.g. two dumbbells) specify the weight of just one, while tonnage statistics will be doubled.',
                switchValue: _isDoubleWeights,
                onChangeSwitchState: (value) {
                  setState(() {
                    _isDoubleWeights = value;
                    if (_isBodyWeight) {
                      _isBodyWeight = false;
                    }
                  });
                },
              ),
              SwitchedChoiceWithTooltip(
                  leadingText: 'Body Weight',
                  tooltipMessage:
                      'For bodyweight exercises(e.g. push-ups) repetition statistics will be displayed instead of tonnage.\n\nIf necessary, you can log any additional weight or leave the field blank.',
                  switchValue: _isBodyWeight,
                  onChangeSwitchState: (value) {
                    setState(() {
                      _isBodyWeight = value;
                      if (_isDoubleWeights) {
                        _isDoubleWeights = false;
                      }
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

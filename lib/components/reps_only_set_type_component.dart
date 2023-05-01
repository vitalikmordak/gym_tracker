import 'package:flutter/material.dart';
import 'package:gym_tracker/components/sized_set_type_text_field.dart';
import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'package:gym_tracker/services/dto/reps_only_set_model.dart';

class RepsOnlySetTypeComponent extends StatelessWidget {
  const RepsOnlySetTypeComponent({
    Key? key,
    required this.setNumber,
    required this.sets,
  }) : super(key: key);

  final int setNumber;
final List<ExerciseSetModel> sets;

  @override
  Widget build(BuildContext context) {
    TextEditingController repsController = TextEditingController();
    /// Creates RepsOnlySetModel and set value later
    RepsOnlySetModel repsOnlySetModel = RepsOnlySetModel(setNumber: setNumber);
    /// Use insert in list to avoid duplication
    sets.insert(setNumber - 1, repsOnlySetModel);

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
            controller: repsController,
            keyboardType: TextInputType.number,
            onTextFieldChanged: (newValue) {
              (sets[sets.indexOf(repsOnlySetModel)] as RepsOnlySetModel).reps =
                  int.parse(repsController.text);
            },
          )
        ],
      ),
    );
  }
}

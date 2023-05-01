import 'package:flutter/material.dart';
import 'package:gym_tracker/components/sized_set_type_text_field.dart';
import 'package:gym_tracker/services/dto/exercise_set_model.dart';
import 'package:gym_tracker/services/dto/weighted_set_model.dart';

class WeightSetTypeComponent extends StatelessWidget {
  const WeightSetTypeComponent(
      {Key? key,
      required this.setNumber,
      required this.sets,
      })
      : super(key: key);

  final int setNumber;
  final List<ExerciseSetModel> sets;

  @override
  Widget build(BuildContext context) {
    TextEditingController weightController = TextEditingController();
    TextEditingController repsController = TextEditingController();
    /// Creates WeightedSetModel and set value later
    WeightedSetModel weightedSetModel =
        WeightedSetModel(setNumber: setNumber);
    /// Use insert in list to avoid duplication
    sets.insert(setNumber - 1, weightedSetModel);
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
            controller: weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onTextFieldChanged: (newValue) {
              (sets[sets.indexOf(weightedSetModel)] as WeightedSetModel)
                  .weight = double.parse(weightController.text);
            },
          ),
          SizedSetTypeTextField(
            controller: repsController,
            keyboardType: TextInputType.number,
            onTextFieldChanged: (newValue) {
              (sets[sets.indexOf(weightedSetModel)] as WeightedSetModel).reps =
                  int.parse(repsController.text);
            },
          )
        ],
      ),
    );
  }
}

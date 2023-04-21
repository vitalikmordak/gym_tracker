import 'package:flutter/material.dart';

class ExerciseCategoryPage extends StatefulWidget {
  const ExerciseCategoryPage(
      {Key? key,
      required this.selectExercise,
      required this.categoryExercises,
      required this.categoryIcon})
      : super(key: key);

  final bool selectExercise;
  final List<String> categoryExercises;
  final AssetImage categoryIcon;

  @override
  State<ExerciseCategoryPage> createState() => _ExerciseCategoryPageState();
}

class _ExerciseCategoryPageState extends State<ExerciseCategoryPage> {
  Map<int, String> _selectedExercise = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: !widget.selectExercise),
      floatingActionButton: Visibility(
        visible: widget.selectExercise,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0)),
            icon: Icon(Icons.keyboard_backspace_rounded),
            label: Text('Select: ${_selectedExercise.length}'),
            onPressed: () {
              Navigator.pop(context, _selectedExercise.values.toList());
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: ListView.builder(
        itemCount: widget.categoryExercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            title: Text(widget.categoryExercises[index],
                style: TextStyle(fontSize: 20.0)),
            leading: Image(
              height: 100,
              image: widget.categoryIcon,
            ),
            onTap: () {
              setState(() {
                if (widget.selectExercise) {
                  if (_selectedExercise.containsKey(index)) {
                    _selectedExercise.remove(index);
                  } else {
                    _selectedExercise.putIfAbsent(
                      index,
                      () => widget.categoryExercises[index],
                    );
                  }
                }
              });
            },
            trailing: Visibility(
              visible:
                  widget.selectExercise && _selectedExercise.containsKey(index),
              child: Icon(
                Icons.check,
                size: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
          );
        },
      ),
    );
  }
}
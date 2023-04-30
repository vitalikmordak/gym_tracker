

import 'dart:convert';

class ExerciseModel {
  final String? id;
  final String name;
  final bool createdBySystem;
  final bool doubleWeights;
  final bool bodyWeight;
  final String setCategoryType;
  final dynamic createdBy;
  final String groupName;

  ExerciseModel({
    this.id,
    required this.name,
    this.createdBySystem = false,
    required this.doubleWeights,
    required this.bodyWeight,
    required this.setCategoryType,
    required this.createdBy,
    required this.groupName,
  });

  factory ExerciseModel.fromRawJson(String str) => ExerciseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
    id: json["id"],
    name: json["name"],
    createdBySystem: json["createdBySystem"],
    doubleWeights: json["doubleWeights"],
    bodyWeight: json["bodyWeight"],
    setCategoryType: json["setCategoryType"],
    createdBy: json["createdBy"],
    groupName: json["groupName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "doubleWeights": doubleWeights,
    "bodyWeight": bodyWeight,
    "setCategoryType": setCategoryType.toUpperCase().replaceAll(" ", "_"),
    "createdBy": createdBy,
    "groupName": groupName.toUpperCase().replaceAll(" ", "_"),
  };

  static String capitalize(String s) {
    List<String> words = s.replaceAll("_", " ").split(" ");
    return words.map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase()).join(" ");
  }
}
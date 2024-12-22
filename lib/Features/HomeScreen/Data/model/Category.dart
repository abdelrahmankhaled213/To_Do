import 'package:flutter/material.dart';

class TaskCategory extends Object {
  final int? id;
  final int color1;
  final int color2;
  final String name;

  const TaskCategory({
     this.id,
    required this.color2,
    required this.color1,
    required this.name,
  });

  TaskCategory copyWith({
    int? id,
    int? color1,
    int? color2,
    String? name,
  })=>
      TaskCategory(
        id: id ?? this.id,
        color1: color1 ?? this.color1,
        color2: color2 ?? this.color2,
        name: name ?? this.name,
      );

  factory TaskCategory.fromJson(Map<String, dynamic> json) {
    return TaskCategory(
      id: json['id'],
      color1: json['color1'],
      color2: json['color2'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'color1': color1,
      'color2': color2,
      'name': name,

    };
  }

@override
  bool operator == (  Object other) {
    // TODO: implement ==
  print(other is TaskCategory && name == other.name && color1 == other.color1 && color2==other.color2);
    return other is TaskCategory && name == other.name && color1==other.color1 && color2==other.color2;
  }

@override
  // TODO: implement hashCode
  int get hashCode => name.hashCode ^ color1.hashCode ^ color2.hashCode;
}


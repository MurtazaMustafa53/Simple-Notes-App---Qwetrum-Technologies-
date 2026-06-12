import 'dart:math';

import 'package:flutter/material.dart';

class Note {
  final String title;
  final String id;
  final String body;
  final DateTime date;
  final int color;

  Note({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    int? color,
  }) : this.color = color ?? _getRandomColor();

  static int _getRandomColor() {
    final List colors = [
      0xFFFFF9C4, // Soft Yellow
      0xFFFFCCBC, // Soft Orange/Coral
      0xFFE1BEE7, // Soft Purple
      0xFFC8E6C9, // Soft Green
      0xFFB3E5FC, // Soft Blue
      0xFFF8BBD0, // Soft Pink
    ];

    final random = Random();
    return colors[random.nextInt(colors.length)];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'date': date.toIso8601String(),
      'color': color,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      date: DateTime.parse(map['date']),
      color: map['color'],
    );
  }
}

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:staticnotes/Model/noteModel.dart';

class NoteController extends ChangeNotifier {
  final List notes = [];

  void addNote(String title, String content) {
    final newnote = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
      date: DateTime.now(),
    );

    notes.add(newnote);

    notifyListeners();
  }
}

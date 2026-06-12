import 'dart:core';

import 'package:flutter/material.dart';
import 'package:staticnotes/Model/noteModel.dart';
import 'package:staticnotes/Services/db_Helper.dart';

class NoteController extends ChangeNotifier {
  List<Note> notes = [];
  String searchQuery = '';
  bool isgridview = false;

  void toggleviewmode() {
    isgridview = !isgridview;
    notifyListeners();
  }

  Future<void> addNote(String title, String body) async {
    final newnote = Note(
      id: DateTime.now().toString(),
      title: title,
      body: body,
      date: DateTime.now(),
    );

    await DbHelper.instance.createNote(newnote);

    notes.insert(0, newnote);

    notifyListeners();
  }

  Future<void> fetchNotes() async {
    notes = await DbHelper.instance.readAllNote();
    notifyListeners();
  }

  Future<void> editNote(Note updatedNote) async {
    await DbHelper.instance.updateNote(updatedNote);

    int index = notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      notes[index] = updatedNote;
      notifyListeners();
    }
  }

  Future<void> removeNote(String id) async {
    await DbHelper.instance.deleteNote(id);

    notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  List<Note> get filteredNote {
    if (searchQuery.isEmpty) {
      return notes;
    }
    return notes
        .where(
          (notes) =>
              notes.title.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }
}

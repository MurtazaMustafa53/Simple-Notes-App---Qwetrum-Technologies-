import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staticnotes/Controller/note_Controller.dart';
import 'package:staticnotes/Model/noteModel.dart';

class ViewNoteDetailScreen extends StatelessWidget {
  final Note note;

  const ViewNoteDetailScreen({super.key, required this.note});

  void _showDeleteConfirmMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Note"),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            //confirm button
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Provider.of<NoteController>(
                  context,
                  listen: false,
                ).removeNote(note.id);
                Navigator.pop(context);
              },
              child: Text("Confirm"),
            ),
            //cancel button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              _showDeleteConfirmMessage(context);
            },
            icon: Icon(Icons.delete),
            tooltip: 'Delete Note',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Display the date clearly at the top
            Text(
              'Created on: ${note.date.day}/${note.date.month}/${note.date.year}',
              style: const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),

            // Display the full content body text
            Text(note.body, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

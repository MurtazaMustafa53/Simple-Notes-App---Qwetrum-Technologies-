import 'package:flutter/material.dart';
import 'package:staticnotes/Model/noteModel.dart';

class ViewNoteDetailScreen extends StatelessWidget {
  final Note note;

  const ViewNoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
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
            Text(
              note.content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

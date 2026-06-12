import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staticnotes/Controller/note_Controller.dart';
import 'package:staticnotes/Veiw/Screens/VeiwNote.dart';
import 'package:staticnotes/Veiw/Screens/addNoteScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      Provider.of<NoteController>(context, listen: false).fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteControllerWatch = Provider.of<NoteController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              noteControllerWatch.toggleviewmode();
            },
            icon: Icon(
              noteControllerWatch.isgridview
                  ? Icons.view_list
                  : Icons.grid_view,
            ),
            tooltip: noteControllerWatch.isgridview
                ? 'Switch to List'
                : 'Switch to Grid',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                Provider.of<NoteController>(
                  context,
                  listen: false,
                ).updateSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: "Search notes by title ....",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: Consumer<NoteController>(
              builder: (context, noteController, child) {
                final displayNote = noteController.filteredNote;
                if (displayNote.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notes added yet.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                if (noteControllerWatch.isgridview) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: displayNote.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns for notes grid
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.9,
                        ),
                    itemBuilder: (context, index) {
                      final note = displayNote[index];
                      return _buildNoteCard(
                        context,
                        note,
                      ); // Extracted building widget
                    },
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: displayNote.length,
                  itemBuilder: (context, index) {
                    final note = displayNote[index];
                    return _buildNoteCard(context, note);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, dynamic note) {
    return Card(
      color: Color(note.color),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              note.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '${note.date.day}/${note.date.month}/${note.date.year}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          // Navigate to detail view view screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewNoteDetailScreen(note: note),
            ),
          );
        },
      ),
    );
  }
}

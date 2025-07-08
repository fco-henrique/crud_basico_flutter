import 'package:flutter/material.dart';
import '../../AddEditNoteScreen.dart';
import '../../../data_base/DatabaseHelper.dart';
import '../../../model/note_model.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final int userId;
  final VoidCallback onRefresh;

  const NoteList({
    super.key,
    required this.notes,
    required this.userId,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Dismissible(
          key: Key(note.id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            await DatabaseHelper.instance.deleteNote(note.id!);

            onRefresh();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Anotação removida!')),
            );
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditNoteScreen(
                      note: note,
                      userId: userId, // Usa o userId recebido
                    ),
                  ),
                );

                onRefresh();
              },
            ),
          ),
        );
      },
    );
  }
}
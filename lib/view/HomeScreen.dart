import 'package:crud_basico/view/commun/components/NoteList.dart';
import 'package:flutter/material.dart';
import 'AddEditNoteScreen.dart';
import '../data_base/DatabaseHelper.dart';
import '../model/note_model.dart';

class HomeScreen extends StatefulWidget {
  final int userId;
  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _refreshNotes() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Anotações'),
      ),
      body: FutureBuilder<List<Note>>(
        future: DatabaseHelper.instance.readAllNotes(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma anotação ainda.\nClique em "+" para adicionar uma!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final notes = snapshot.data!;

          return NoteList(notes: notes, userId: widget.userId, onRefresh: _refreshNotes);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditNoteScreen(
                userId: widget.userId,
              ),
            ),
          );
          _refreshNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
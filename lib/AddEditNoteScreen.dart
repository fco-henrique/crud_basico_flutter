import 'package:flutter/material.dart';
import 'data_base/DatabaseHelper.dart';
import 'model/note_model.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;
  final int userId;

  const AddEditNoteScreen({super.key, this.note, required this.userId});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário

  @override
  void initState() {
    super.initState();
    // Se estamos editando, preenchemos os campos com os dados da anotação
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        content: _contentController.text,
        createdAt: widget.note?.createdAt ?? DateTime.now(),
        userId: widget.userId, // <<< ASSOCIA A NOTA AO USUÁRIO
      );

      if (widget.note == null) {
        await DatabaseHelper.instance.createNote(note);
      } else {
        await DatabaseHelper.instance.updateNote(note);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Nova Anotação' : 'Editar Anotação'),
        actions: [
          // Botão para salvar
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo de Título
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo de Conteúdo
              TextFormField(
                controller: _contentController,
                maxLines: 10, // Permite múltiplas linhas
                decoration: const InputDecoration(
                  labelText: 'Conteúdo',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o conteúdo.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
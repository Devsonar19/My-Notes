import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';
import '../../services/crud/notes_service.dart';
import '../../utilities/generics/get_arguments.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {

  DatabaseNote? _notes;
  late final NotesService _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService= NotesService();
    _textController= TextEditingController();
    super.initState();
  }

  void _textControllerListener() async{
    final note= _notes;
    if(note==null){
     return;
    }
    final text= _textController.text;
    await _notesService.updateNote(
        note: note,
        text: text
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<DatabaseNote> createOrGetExistingNote(BuildContext context)async{

    final widgetNote= context.getArgument<DatabaseNote>();
    if(widgetNote!=null){
      _notes=widgetNote;
      _textController.text=widgetNote.text;
      return widgetNote;
    }



    final existingNote = _notes;
    if(existingNote!=null){
      return existingNote;
    }
    final currentUser= AuthService.firebase().currentUser!;
    final email= currentUser.email;
    final owner= await _notesService.getOrCreateUser(email: email);
    final newNote= await _notesService.createNote(owner: owner);
    _notes=newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note= _notes;
    if(_textController.text.isEmpty && note!=null){
      _notesService.deleteNote(id: note.id);
    }
  }

  void _saveNoteIfTextIsNotEmpty() async{
    final note= _notes;
    final text= _textController.text;
    if(note!=null && text.isNotEmpty){
      await _notesService.updateNote(
        note: note,
        text: text,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextIsNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),
      body: FutureBuilder(
          future: createOrGetExistingNote(context),
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.done:
                _setupTextControllerListener();
                return TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Lets write something...',
                  ),
                );
                default:
                return const CircularProgressIndicator();
            }
          },
      ),
    );
  }
}

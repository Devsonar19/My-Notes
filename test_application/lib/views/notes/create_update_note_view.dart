import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';
import '../../services/crud/notes_service.dart';
import '../../utilities/generics/get_arguments.dart';

import 'package:test_application/services/cloud/cloud_note.dart';
import 'package:test_application/services/cloud/cloud_storage_exceptions.dart';
import 'package:test_application/services/cloud/firebase_cloud_storage.dart';


class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {

  CloudNote? _notes;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService= FirebaseCloudStorage();
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
        documentId: note.documentId,
        text: text
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context)async{

    final widgetNote= context.getArgument<CloudNote>();
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
    // final owner= await _notesService.getOrCreateUser(email: email);
    final userId= currentUser.id;
    final newNote= await _notesService.createNewNote(ownerUserId: userId);
    _notes=newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note= _notes;
    if(_textController.text.isEmpty && note!=null){
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextIsNotEmpty() async{
    final note= _notes;
    final text= _textController.text;
    if(note!=null && text.isNotEmpty){
      await _notesService.updateNote(
          documentId: note.documentId,
          text: text
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

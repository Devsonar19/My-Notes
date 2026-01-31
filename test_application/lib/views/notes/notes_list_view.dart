import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../services/cloud/cloud_note.dart';
// import '../../services/crud/notes_service.dart';
import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallBack = void Function(CloudNote note);


class NotesListView extends StatelessWidget {

  final Iterable<CloudNote> notes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTap;

  const NotesListView ({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index){
          final note=notes.elementAt(index);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ListTile(
              tileColor: HexColor('22223b'),
              contentPadding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: (){
                onTap(note);
              },
              onLongPress: () async{
                    final shouldDelete= showDeleteDialog(context);
                    if(await shouldDelete){
                      onDeleteNote(note);
                      }
              },
              title: Text(
                note.text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: HexColor('edede9'),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
    );
  }
}

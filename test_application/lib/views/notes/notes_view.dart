import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_application/services/cloud/cloud_note.dart';
import 'package:test_application/services/cloud/firebase_cloud_storage.dart';
import 'package:test_application/services/crud/notes_service.dart';
import 'package:test_application/utilities/dialogs/basic_info.dart';
import 'package:test_application/views/notes/notes_list_view.dart';

import '../../constants/routes.dart';
import '../../enums/menu_action.dart';
import '../../services/auth/auth_service.dart';
import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_event.dart';
import '../../utilities/dialogs/logout_dialog.dart';

//NOTES VIEW
class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;

  String get userId =>
      AuthService
          .firebase()
          .currentUser!
          .id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('f2e9e4'),
      appBar: AppBar(
        backgroundColor: HexColor('f2e9e4'),
        actions: [
          IconButton(
              onPressed: ()async{
                await basicInfoForDelete(context);
              },
              icon: Icon(
                Icons.info_outline_rounded,
                color: Colors.black,
                size: 30,
              )
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: HexColor('F3E8DF'),
        child: Container(
          color: Colors.transparent,
          child: ListView(
              children: [
                Center(
                  child: Container(
                      height: 150,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide.none,
                        ),
                      ),
                      child: Text(
                          'My Notes',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: GoogleFonts.ooohBaby().fontFamily,
                        )
                      ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                        leading: Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                            size: 25,
                        ),
                        title: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                        ),
                        tileColor: HexColor('22223b'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () async {
                          final shouldLogout = await showLogOutDialog(context);
                          if (shouldLogout) {
                            context.read<AuthBloc>().add(
                              const AuthEventLogOut(),
                            );
                          }
                        }
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                        leading: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 25,
                        ),
                        title: const Text(
                            'About Developer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                        ),
                        tileColor: HexColor('22223b'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(aboutDevRoute);
                        }
                    ),
                  ),
                ),

              ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
        backgroundColor: HexColor('ddbea9'),
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot){
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if(snapshot.hasData){
                final allNotes= snapshot.data as Iterable<CloudNote>;
                return NotesListView(
                  notes: allNotes,
                  onDeleteNote: (note) async{
                    await _notesService.deleteNote(documentId: note.documentId);
                  },
                  onTap: (note){
                    Navigator.of(context).pushNamed(
                      createOrUpdateNoteRoute,
                      arguments: note,
                    );
                  },
                );
              }else{
                return const Center(child: CircularProgressIndicator());
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/notes_database.dart';
import '../../model/note.dart';
import '../../utils/my_colors.dart';
import '../login/login_view.dart';
import '../widgets/note_card_widget.dart';
import 'edit_note_page.dart';
import 'note_detail_page.dart';


class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      if (userId == null) {
        throw Exception('User ID not found in SharedPreferences.');
      }

      notes = await NotesDatabase.instance.readAllNotes(userId);
    } catch (e) {
      print('Error while loading notes: $e');
      notes = []; // Jjesli blad, pusta linia notatek
    }

    setState(() => isLoading = false);
  }


  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
          (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) => SafeArea(
      child: Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: MyColors.extraLightPurpleColor,
      title: Text(
        'My Notes',
        style: TextStyle(fontSize: 24,
            color: MyColors.purpleColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
      TextButton(
      onPressed: _logout,
      child: Text(
        'Log Out',
        style: TextStyle(
          color: MyColors.purpleColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    ],
    ),
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : notes.isEmpty
          ? const Text(
        'No Notes',
        style: TextStyle(color: Colors.black, fontSize: 24),
      )
          : buildNotes(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: MyColors.extraLightPurpleColor,
      child: const Icon(Icons.add),
      onPressed: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditNotePage()),
        );
        if (result == true) {
          refreshNotes(); // odswiez po oddaniu notatki
        }
      },
    ),
  ),
  );
  Widget buildNotes() => Column(
  children: [
    const SizedBox(height: 16),
      Expanded(
      child: MasonryGridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemCount: notes.length,
    itemBuilder: (context, index) {
      final note = notes[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(noteId: note.id!),
          ));

          refreshNotes();
        },
        child: NoteCardWidget(note: note, index: index),
      );
    },
  ),
      ),
  ],
          );
}

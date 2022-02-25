import 'package:flutter/material.dart';
import 'package:notes_flutter/src/core/model/note.dart';

class NoteModel extends ChangeNotifier {
  final List<Note> _notes = [];
  final List<Note> _filteredNotes = [];

  NoteModel({List<Note> notes = const []}) {
    _notes.addAll(notes);
    _filteredNotes.addAll(notes);
  }

  List<Note> get notes => List.unmodifiable(_notes);
  List<Note> get filteredMenu => List.unmodifiable(_filteredNotes);

  void filterMenu(String noteBody) {
    if (noteBody.trim() == "") {
      _filteredNotes
        ..clear()
        ..addAll(_notes);
    } else {
      _filteredNotes
        ..clear()
        ..addAll(_notes.where((note) =>
            note.body.toLowerCase().contains(noteBody.toLowerCase())));
    }
    notifyListeners();
  }

  void addNote(Note note) {
    _notes.add(note);
    _filteredNotes.add(note);
    notifyListeners();
  }

  void addAllNotes(List<Note> notes) {
    _notes.addAll(notes);
    _filteredNotes.addAll(notes);
    notifyListeners();
  }

  void clearAll() {
    _notes.clear();
    _filteredNotes.clear();
    notifyListeners();
  }
}
// import 'dart:convert';
// # VOU ARRISCANDO SEM TEMER O FRACOSSO O PASSO FOI DADO VERGONHA É RETROCEDER
import 'package:flutter/material.dart';
import 'package:notes_flutter/src/core/model/note_model.dart';
import 'package:notes_flutter/src/notes_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => NoteModel(),
    child: const NotesApp(),
  ));
}

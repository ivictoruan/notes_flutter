import 'package:flutter/material.dart';
import 'package:notes_flutter/src/screens/home/home_screen.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anotações Pessoais',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Anotações Pessoais'),
    );
  }
}

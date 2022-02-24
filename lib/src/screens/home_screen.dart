import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes_flutter/src/model/note.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client(); // client provider by http package

  List<Note> notes = [];

  @override
  void initState() {
    // _retrieveNotes();
    super.initState();
  }

  void _addNote() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton(
          onPressed: _addNote, child: const Icon(Icons.add)),
    );
  }
}

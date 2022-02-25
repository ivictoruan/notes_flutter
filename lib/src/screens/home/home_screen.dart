import 'package:dio/dio.dart';


import 'package:flutter/material.dart';
import 'package:notes_flutter/src/core/model/note_model.dart';
import 'package:provider/provider.dart';

import '../../core/model/note.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = true;
  String error = "";

  @override
  void initState() {
    super.initState();
    final NoteModel _noteModel = Provider.of<NoteModel>(context, listen: false);

    Dio()
        .get("http://personal-simple-notes.herokuapp.com/notes/",
            options: Options(contentType: Headers.jsonContentType))
        .then((value) {
      final List<dynamic> data = value.data;
      // print("this before${data}");
      final List<Note> notes = data
          .map((n) => Note(
              id: n["id"],
              body: n["body"]))
          .toList();
            debugPrint("\nthis after $notes}");
      setState(() {
        _noteModel.addAllNotes(notes);
        loading = false;        
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  addNote() {
    // final NoteModel noteModel = Provider.of<NoteModel>(context, listen: false);

    // debugPrint(noteModel.menu.toString());
  }

  @override
  Widget build(BuildContext context) {
    double _maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<NoteModel>(builder: (context, noteModel, child) {
          final List<Note> _filteredNotes = noteModel.filteredMenu;

          // if (_filteredNotes.isEmpty) {
          //   return const Center(child: Text("No dishes found"));
          // }
          if (error.isNotEmpty) {
            return Center(child: Text(error));
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: _maxHeight * 0.02),
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.none,
            itemBuilder: (_, item) {
              return ListTile(
                leading: Text(_filteredNotes[item].body.toString()),
                // title: _filteredNotes[item].dishPrice,
                onTap: () {},
                // debugPrint(
                //     "Clicked dish: ${_filteredNotes[item].id.toString()}"),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              width: 20,
            ),
            itemCount: _filteredNotes.length, //_filteredNotes.length
          );
        },),        
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes_flutter/src/core/model/note_model.dart';
import 'package:notes_flutter/src/screens/home/home_screen_controller.dart';
import 'package:notes_flutter/utils/colors.dart';
import 'package:notes_flutter/utils/note_card_widget.dart';
import 'package:provider/provider.dart';

import '../../core/model/note.dart';
import '../create/create_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = true;
  String error = "";
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    final NoteModel _noteModel = Provider.of<NoteModel>(context, listen: false);
    final HomeScreenController _controller = HomeScreenController();

    _controller.getNotesList().then((List<Note> notes) {
      setState(() {
        _noteModel
          ..clearAll()
          ..addAllNotes(notes);
        error = "";
        loading = false;
      });
    }).catchError((e) {
      setState(() {
        debugPrint(e.toString());
      });

      setState(() {
        error = e.toString();
        loading = false;
      });
    });
  }

  void createNote() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CreateScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double _maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.44),
      appBar: AppBar(
        title: Text(widget.title),
        // centerTitle: true,
        elevation: 2,
      ),
      body: loading
          ? LinearProgressIndicator(color: secondaryColor)
          : Column(
              children: [
                // Container(
                //   color: Colors.black,
                //   height: _maxHeight * 0.08,
                //   child: Row(
                //     children: [
                //       // Padding(
                //       //   padding: const EdgeInsets.only(left: 25),
                //       //   child: Icon(
                //       //     Icons.sync_alt_rounded,
                //       //     color: deepOrange,
                //       //   ),
                //       // ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 25),
                //         child: Text(
                //           "Anotações",
                //           style: TextStyle(
                //               color: deepOrange,
                //               fontSize: 20,
                //               fontWeight: FontWeight.w700),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Consumer<NoteModel>(
                    builder: (context, noteModel, child) {
                      final List<Note> _filteredNotes = noteModel.filteredMenu;

                      // if (_filteredNotes.isEmpty) {
                      //   return const Center(child: Text("No notes found"));
                      // }
                      if (error.isNotEmpty) {
                        return Center(child: Text(error));
                      }
                      return ListView.separated(
                        padding:
                            EdgeInsets.symmetric(vertical: _maxHeight * 0.02),
                        scrollDirection: Axis.vertical,
                        clipBehavior: Clip.none,
                        itemBuilder: (_, item) {
                          return NoteCardWidget(
                            id: _filteredNotes[item].id,
                            body: _filteredNotes[item].body.toString(),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 20,
                        ),
                        itemCount:
                            _filteredNotes.length, //_filteredNotes.length
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton( // ADD TEXT SAYING "ADD NOTE"
          backgroundColor: Colors.deepOrange[500],
          onPressed: createNote,
          child: const Icon(
            Icons.add,
            color: mobileBackgroundColor,
          )),
    );
  }
}


// Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: _maxHeight * 0.03,
//                             ),
//                             child: ListTile(
//                               subtitle: Text(
//                                 " ${_filteredNotes[item].id.toString()} ª anotação",
//                                 style: TextStyle(
//                                     fontSize: _maxHeight * 0.024,
//                                     backgroundColor: Colors.blueGrey[200],
//                                     color: Colors.white),
//                               ),
//                               title: Text(
//                                 _filteredNotes[item].body.toString(),
//                                 style: TextStyle(
//                                   fontSize: _maxHeight * 0.042,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               trailing: Container(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: _maxHeight * 0.02,
//                                 ),
//                                 margin: const EdgeInsets.all(8),
//                                 color: secondaryColor,
//                                 child: IconButton(
//                                   icon: const Icon(Icons.delete),
//                                   onPressed: () {},
//                                   color: Colors.black.withOpacity(0.8),
//                                 ),
//                               ),
//                               onTap: () {},
//                             ),
//                           );
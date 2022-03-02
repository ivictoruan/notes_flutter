import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:notes_flutter/src/core/model/note_model.dart';
import 'package:notes_flutter/src/screens/home/home_screen_controller.dart';
import 'package:notes_flutter/utils/colors.dart';
import 'package:notes_flutter/utils/note_card_widget.dart';
import 'package:provider/provider.dart';

import '../../core/model/note.dart';
import '../create_note/create_note_screen.dart';

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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CreateNoteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double _maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.44),
      // APP BAR
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.deepOrangeAccent,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.power_settings_new_rounded,
            color: Colors.deepOrangeAccent,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_pin_circle_outlined,
              color: Colors.deepOrangeAccent,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.pending_outlined,
              color: Colors.deepOrangeAccent,
            ),
            onPressed: () {},
          ),
        ],
        elevation: 2,
      ),
      body: loading
          ? LinearProgressIndicator(color: secondaryColor)
          : Column(
              children: [
                // SEARCH BAR
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    // color: Colors.white70.withOpacity(0.44),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      // Icon(
                      //   Icons.search,
                      //   color: Colors.deepOrangeAccent,
                      // ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Encontre uma anotação",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<NoteModel>(
                    builder: (context, noteModel, child) {
                      final List<Note> _filteredNotes = noteModel.filteredMenu;
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
      // FLOATING ACTION BUTTON
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: addAnotationButton(createNote),
      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        // color: Colors.redAccent,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.align_horizontal_left_sharp),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.notes_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget addAnotationButton(Function()? onPressed) =>
    FloatingActionButton.extended(
      backgroundColor: Colors.deepOrange[500],
      onPressed: onPressed,
      icon: const Icon(
        Icons.plus_one,
        size: 24,
      ), 
      label: const Text(
        'Anotação',
        style: TextStyle(
          color: mobileBackgroundColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

Widget customBottomBar() => BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      // backgroundColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.align_horizontal_left_sharp,
            color: Colors.white,
          ),
          label: "Anotações",
          backgroundColor: Colors.deepOrange[500],
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.notes_outlined),
          label: "Outras categorias",
        ),
      ],
      onTap: (int index) {},
    );

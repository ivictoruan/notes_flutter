import 'package:flutter/material.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextFormField(
          decoration: const InputDecoration(
            hintText: "Nova nota",
            border: InputBorder.none,
          ),
        ),
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: TextFormField(
              decoration: const InputDecoration(
                  // isDense: true,
                  labelText: 'Digite seu texto aqui...',
                  // filled: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintMaxLines: 50),
            ),
          ),
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            margin: const EdgeInsets.all(20),
            color: Colors.deepOrange,
            child: TextButton(
              // "Salvar",
              child:
                  const Text("Salvar", style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SizedBox(
            height: _maxHeight * .02,
          ),
        ],
      ),
    );
  }
}

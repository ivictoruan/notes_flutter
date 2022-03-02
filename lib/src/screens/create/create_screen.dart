import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Nova nota'),
      ),
      body: Container(
        // margin: const EdgeInsets.symmetric(vertical:20, horizontal: 20),
        // color: Colors.black,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Digite seu texto aqui...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amberAccent, width: 2),
                  ),
                ),
              ),
            ),

            // Padding(
            //   // color: Colors.deepOrange,
            //   padding: EdgeInsets.only(top: _maxHeight * .60),
            //   child: ElevatedButton(
            //     child: const Text('Salvar'),
            //     onPressed: () => Navigator.of(context).pop(),
            //   ),
            // ),
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
                child: const Text("Salvar", style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.of(context).pop(),
              ),              
            ),
            SizedBox(
              height: _maxHeight * .02,
            ),
          ],
        ),
      ),
    );
  }
}

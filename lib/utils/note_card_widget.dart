import 'package:flutter/material.dart';

class NoteCardWidget extends StatelessWidget {
  final int id;
  final String body;
  const NoteCardWidget({Key? key, required this.id, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _maxHeight = MediaQuery.of(context).size.height;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.favorite_border_outlined),
              onPressed: () {},
              color: Colors.deepOrange[500],
            ),
            // title: const Text('Nota 1'),
            title: Text(
              '${id.toString()} ª anotação',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              body,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  // Perform some action
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      '  Compartilhar no Whatsapp',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: _maxHeight * 0.02),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Text(
                      'Apagar  ',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

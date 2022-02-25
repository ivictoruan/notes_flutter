// import 'package:dio/dio.dart';

// class HomeScreenController{
  

// }

import 'package:dio/dio.dart';

import '../../core/model/note.dart';

class HomeScreenController {
  // replace by dependency injection
  final Dio _dio = Dio();

  final _endpointNotes = const String.fromEnvironment("endpointNotes",
      defaultValue: "http://personal-simple-notes.herokuapp.com/notes/");

  Future<List<Note>> getNotesList() async {
    try {
      final Response<List<dynamic>> response = await _dio.get<List<dynamic>>(
          _endpointNotes,
          options: Options(contentType: Headers.jsonContentType));

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data ?? [];

        return data.map((note) => Note(
              id: note["id"],
              body: note["body"])).toList();
      } else {
        return [];
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }
}
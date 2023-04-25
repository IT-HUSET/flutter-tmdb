import 'dart:async';
import 'package:http/http.dart' as http;

class MovieDBApi {
  static const String _apiKey = ''; /// TODO: Enter your API key here

  MovieDBApi() {
    assert(_apiKey.isNotEmpty, 'Please enter your API key!');
  }

  Future<String> get(String path) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3$path?api_key=$_apiKey'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, return the body string
      return response.body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movie');
    }
  }
}

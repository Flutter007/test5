import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> requestGet(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Sorry, something went wrong!');
  }
}

Future<dynamic> requestPost(String uri, String message) async {
  if (message.isNotEmpty) {
    final response = await http.post(
      Uri.parse(uri),
      body: {'message': message},
    );
  }
}

import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> toJson(HttpClientResponse response) async {
  final resultResponseBody = await response.transform(utf8.decoder).join();
  return jsonDecode(resultResponseBody) as Map<String, dynamic>;
}
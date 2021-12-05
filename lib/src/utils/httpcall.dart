import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class RestAPI {
  static Future<dynamic> post({@required String url, Object body}) async {
    var link = Uri.parse(url);
    var response = await http.post(link, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      return [];
    }

    return json.decode(response.body);
  }

  static Future<dynamic> get({@required String url, String query}) async {
    var link = Uri.parse('$url$query');

    var response = await http.get('$link');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode != 200) {
      return [];
    }
    return json.decode(response.body);
  }
}

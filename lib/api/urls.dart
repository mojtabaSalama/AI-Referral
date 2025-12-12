
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Api {
  static Future allRecords() async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        
      };

      final url = Uri.parse("https://aireferral-uv4n.onrender.com/records");

      http.Response response = await http.get(url, headers: configHeaders);

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }
  static Future predict(data) async {
    try {
      Map<String, String> configHeaders = {
        "Content-Type": "application/json",
        
      };

      final url = Uri.parse("https://aireferral-uv4n.onrender.com/insert");

      http.Response response = await http.post(url, headers: configHeaders,body: jsonEncode(data));

      return response;
    } on SocketException {
      return http.Response("No Internet connection", 500);
    } catch (e) {
      return http.Response("Internal error , try again later ", 500);
    }
  }


}
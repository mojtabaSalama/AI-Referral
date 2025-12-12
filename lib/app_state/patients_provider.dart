import 'dart:convert';

import 'package:ai_referral/models/records.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:ai_referral/api/urls.dart";
class PatientsProvider extends ChangeNotifier {


    Future<dynamic> getAllRecords() async {


  final http.Response response = await Api.allRecords();

  if (response.statusCode == 200) {
    final List<dynamic> body = json.decode(response.body);
   List<PatientRecord> records = body.map((e) => PatientRecord.fromJson(e)).toList();

  
    notifyListeners();
    return true;
  } else {
   
    return json.decode(response.body);
  }
}
 Future<dynamic> create(data) async {

    http.Response response = await Api.predict(data);

    if (response.statusCode == 201) {

      notifyListeners();


      return true;
    } else {

      return json.decode(response.body);
    }
  }

}
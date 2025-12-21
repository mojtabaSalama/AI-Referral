import 'dart:convert';

import 'package:ai_referral/models/records.dart';
import 'package:ai_referral/models/summary.dart';
import 'package:flutter/material.dart';
import "package:ai_referral/api/urls.dart";
class PatientsProvider extends ChangeNotifier {


  RecordsSummary _summary = RecordsSummary(); 
  RecordsSummary get summary => _summary;
  PatientRecord? _record;
  PatientRecord? get record => _record; 
List<PatientRecord> get records => _summary.records ?? [];

 bool isLoading = false;
void setLoading(bool value) {
  isLoading = value;
  notifyListeners();
}
  /* ----------  fetch ----------- */
Future<bool> fetchSummary() async {
setLoading(true);
  try {
    final res = await Api.allRecords();
    
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      _summary = RecordsSummary.fromJson(json);
      notifyListeners();
     
      return true;
    } else {
      return false;
    }
  } catch (e) {
    _summary = RecordsSummary();
    notifyListeners(); // Reset to defaults on error
    return false;
  } finally {
  setLoading(false); 
  }
}

Future<bool> getByID(id) async {
  setLoading(true);  // ✅ Explicit true
  try {
    final response = await Api.getByID(id);
    if (response.statusCode == 200) {
      _record = PatientRecord.fromJson(json.decode(response.body));
      notifyListeners();
      return true;
    }
    return false;
  } catch (e) {
    return false;
  } finally {
    setLoading(false); // ✅ Guaranteed to turn off
  }
}

Future<dynamic> predict( data) async {
 setLoading(true);
  final response = await Api.predict(data);

  if (response.statusCode == 201) {
    setLoading(false); 
    final newRecord = PatientRecord.fromJson(json.decode(response.body));
    
  _record=newRecord;
    return true;
  }
   setLoading(false); 
  return json.decode(response.body);
}

}
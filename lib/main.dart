import 'package:ai_referral/app_state/patients_provider.dart';
import 'package:ai_referral/screens/dashboard.dart';
import 'package:ai_referral/screens/patient_form_screen.dart';
import 'package:ai_referral/screens/patients_list.dart';
import 'package:ai_referral/screens/prediction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PatientsProvider(),
      child: MaterialApp(
        title: 'Patient Registration',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFF2563EB),
          scaffoldBackgroundColor: Color(0xFFF8FAFC),
          fontFamily: 'Cairo',
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xFF2563EB),
            
            centerTitle: true,
            
            
            titleTextStyle: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF2563EB), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        home: PatientFormScreen(),
         routes: {
         '/prediction': (context) => PredictionScreen(), 
         '/form': (context) => PatientFormScreen(),
        '/dashboard': (context) => PatientDashboard(),
         '/list': (context) => PatientList(),
         },
      ),
    );
  }
}
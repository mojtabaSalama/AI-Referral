import 'package:ai_referral/app_state/patients_provider.dart';
import 'package:ai_referral/screens/patient_form_screen.dart';
import 'package:ai_referral/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PatientsProvider(),
      child: MaterialApp(
        title: 'Vital Signs Entry',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: PatientFormScreen(),
      ),
    );
  }
}
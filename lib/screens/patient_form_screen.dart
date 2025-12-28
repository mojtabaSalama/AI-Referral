import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_state/patients_provider.dart';
import '../../../components/loading.dart';
import 'sections/basic_info_section.dart';
import 'sections/complaint_section.dart';
import 'sections/pain_scale_section.dart';
import 'sections/vital_signs_section.dart';
import 'sections/action_buttons.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();

  /* ----------  form state  ---------- */
  String _selectedGender = '';
  final _ageController = TextEditingController();
  final _mainComplaintController = TextEditingController();
  double _painLevel = 1;
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();
  final _respiratoryRateController = TextEditingController();
  final _oxygenSaturationController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    _mainComplaintController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseController.dispose();
    _respiratoryRateController.dispose();
    _oxygenSaturationController.dispose();
    super.dispose();
  }

  /* ---------------------------------------------------------- */
  /* UI                                                         */
  /* ---------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientsProvider>(builder: (_, provider, __) {
      if (provider.isLoading) return const Loading(text: 'Predicting');

      return Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicInfoSection(
                  selectedGender: _selectedGender,
                  onGenderChanged: (v) => setState(() => _selectedGender = v),
                  ageController: _ageController,
                ),
                const SizedBox(height: 20),
                ComplaintSection(controller: _mainComplaintController),
                const SizedBox(height: 20),
                PainScaleSection(painLevel: _painLevel, onChanged: (v) => setState(() => _painLevel = v)),
                const SizedBox(height: 20),
                VitalSignsSection(
                  systolicController: _systolicController,
                  diastolicController: _diastolicController,
                  pulseController: _pulseController,
                  respiratoryController: _respiratoryRateController,
                  oxygenController: _oxygenSaturationController,
                ),
                const SizedBox(height: 20),
                ActionButtons(onSubmit: _predict),
              ],
            ),
          ),
        ),
      );
    });
  }

  AppBar _appBar() => AppBar(
        centerTitle: true,
        title: const Row(children: [
          SizedBox(width: 8),
          Text('Patient Assessment'),
        ]),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              tooltip: 'Dashboard',
              icon: const Icon(Icons.dashboard, color: Colors.white, size: 30),
              onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
            ),
          ),
        ],
      );

  /* ---------------------------------------------------------- */
  /* submission                                                 */
  /* ---------------------------------------------------------- */
  Future<void> _predict() async {
    if (!_formKey.currentState!.validate()) return;

    final systolic = int.parse(_systolicController.text);
    final diastolic = int.parse(_diastolicController.text);

    if (systolic <= diastolic) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Systolic must be greater than diastolic'), backgroundColor: Colors.red),
      );
      return;
    }

    final patient = PatientRecord(
      gender: _selectedGender,
      age: int.parse(_ageController.text),
      chiefComplaint: _mainComplaintController.text,
      painGrade: _painLevel.toInt(),
      blooddpressurSystol: systolic,
      blooddpressurDiastol: diastolic,
      pulseRate: int.parse(_pulseController.text),
      respiratoryRate: int.parse(_respiratoryRateController.text),
      o2Saturation: int.parse(_oxygenSaturationController.text),
    );

    final result = await Provider.of<PatientsProvider>(context, listen: false).predict(patient);

    if (result == true) {
      Navigator.pushReplacementNamed(context, '/prediction');
    } else {
      final msg = (result as Map)['error'] ?? 'Unknown error';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
    }
  }
}
import 'package:ai_referral/app_state/patients_provider.dart';
import 'package:ai_referral/components/loading.dart';
import 'package:ai_referral/models/records.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
    State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
 
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

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientsProvider>(
        builder: (context, patientProvider, child) {
   if ( patientProvider.isLoading) {
    return Loading(text: "Predicting");
  }
    return Scaffold(
      appBar: AppBar( actions: [    Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
        icon: const Icon(Icons.dashboard ,color: Colors.white,size: 30,),   // or any icon
        tooltip: 'Dashboard',
        onPressed: () {
           Navigator.pushReplacementNamed(context, '/dashboard');
        },
            ),
      ),],
        
        centerTitle: true,
        title: Row(
          children: [
            
            SizedBox(width: 8),
            Text('Patient Assesment'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBasicInfoSection(),
              SizedBox(height: 20),
              _buildComplaintSection(),
              SizedBox(height: 20),
              _buildPainScaleSection(),
              SizedBox(height: 20),
              _buildVitalSignsSection(),
              SizedBox(height: 20),
              _buildActionButtons(),
          
            ],
          ),
        ),
      ),
    );
  }
);}
  Widget _buildBasicInfoSection() {
  return Container(                                    // ← instead of Card
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [                             // remove if you want flat
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* ----------  header  ---------- */
          Row(
            children: [
              FaIcon(FontAwesomeIcons.idCard,
                  color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                'Basic Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /* ----------  responsive row / column  ---------- */
          LayoutBuilder(
            builder: (_, constraints) {
              final wide = constraints.maxWidth > 450; // breakpoint
              return wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _genderDropdown()),
                        const SizedBox(width: 16),
                        Expanded(child: _ageField()),
                      ],
                    )
                  : Column(
                      children: [
                        _genderDropdown(),
                        const SizedBox(height: 16),
                        _ageField(),
                      ],
                    );
            },
          ),
        ],
      ),
    ),
  );
}

/* ---------------------------------------------------------- */
/* widgets reused above to keep build-method readable         */
/* ---------------------------------------------------------- */
Widget _genderDropdown() {
  return DropdownButtonFormField<String>(
    initialValue: _selectedGender.isEmpty ? null : _selectedGender,
    decoration: const InputDecoration(
      hintText: 'Gender *',
      prefixIcon: Icon(Icons.people),
    ),
    items: ['Male', 'Female']
        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
        .toList(),
    onChanged: (v) => setState(() => _selectedGender = v!),
    validator: (v) => (v == null || v.isEmpty) ? 'Please select gender' : null,
  );
}

Widget _ageField() {
  return TextFormField(
    controller: _ageController,
    decoration: const InputDecoration(
      hintText: 'Age *',
      prefixIcon: Icon(Icons.calendar_today),
      suffixText: 'years',
    ),
    keyboardType: TextInputType.number,
    validator: (v) {
      if (v == null || v.isEmpty) return 'Please enter age';
      final age = int.tryParse(v);
      if (age == null || age < 0 || age > 120) return 'Age must be 0-120';
      return null;
    },
  );
}

  Widget _buildComplaintSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(FontAwesomeIcons.notesMedical, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
                Text(
                  'Patient Complaint',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _mainComplaintController,
              decoration: InputDecoration(
                hintText: 'Main Complaint *',
                prefixIcon: Icon(Icons.description),
                
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please describe the main complaint';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPainScaleSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(FontAwesomeIcons.heartPulse, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
                Text(
                  'Pain Scale',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Pain Level: ${_painLevel.toInt()}/6',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: _getPainColor(),
                inactiveTrackColor: Colors.grey[300],
                thumbColor: _getPainColor(),
                overlayColor:_getPainColor().withValues(alpha: 0.2),
                valueIndicatorColor: _getPainColor(),
              ),
              
              child: Slider(
                value: _painLevel,
                min: 1,
                max: 6,
                divisions: 5,
                label: _painLevel.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    _painLevel = value;
                  });
                },
              ),
              
            ),
            
          ],
        ),
      ),
    );
  }

  Color _getPainColor() {
    if (_painLevel <= 2) return Colors.green;
    if (_painLevel <= 4) return Colors.orange;
    return Colors.red;
  }

   Widget _buildVitalSignsSection() {
  /* ----------  outer surface (ex-Card)  ---------- */
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor, // same white/grey surface
      borderRadius: BorderRadius.circular(20),
      /* drop the boxShadow list if you want a flat look */
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* ----------  header row  ---------- */
          Row(
            children: [
              FaIcon(FontAwesomeIcons.stethoscope,
                  color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                'Vital Signs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /* ----------  responsive grid  ---------- */
          LayoutBuilder(
            builder: (_, constraints) {
              final crossCount = constraints.maxWidth > 500 ? 2 : 1;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 4,
                children: [
                  /* 1  Systolic */
                  _buildVitalSignField(
                    controller: _systolicController,
                    hintText: 'Systolic Pressure *',
                    icon: Icons.monitor_heart,
                    suffix: 'mmHg',
                    validator: (v) => _rangeValidator(v, 60, 250, '60-250'),
                  ),
                  /* 2  Diastolic */
                  _buildVitalSignField(
                    controller: _diastolicController,
                    hintText: 'Diastolic Pressure *',
                    icon: Icons.monitor_heart,
                    suffix: 'mmHg',
                    validator: (v) => _rangeValidator(v, 40, 150, '40-150'),
                  ),
                  /* 3  Heart rate */
                  _buildVitalSignField(
                    controller: _pulseController,
                    hintText: 'Heart Rate *',
                    icon: Icons.favorite,
                    suffix: 'bpm',
                    validator: (v) => _rangeValidator(v, 30, 200, '30-200'),
                  ),
                  /* 4  Respiratory rate */
                  _buildVitalSignField(
                    controller: _respiratoryRateController,
                    hintText: 'Respiratory Rate *',
                    icon: Icons.air,
                    suffix: '/min',
                    validator: (v) => _rangeValidator(v, 5, 60, '5-60'),
                  ),
                  /* 5  Oxygen saturation */
                  _buildVitalSignField(
                    controller: _oxygenSaturationController,
                    hintText: 'Oxygen Saturation *',
                    icon: Icons.local_hospital,
                    suffix: '%',
                    validator: (v) => _rangeValidator(v, 40, 100, '40-100%'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}

/* ---------------------------------------------------------- */
/* helper to keep validators concise                          */
/* ---------------------------------------------------------- */
String? _rangeValidator(String? value, int min, int max, String msg) {
  if (value == null || value.isEmpty) return 'Required';
  final n = int.tryParse(value);
  return (n == null || n < min || n > max) ? msg : null;
}
  Widget _buildVitalSignField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required String suffix,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixText: suffix,
      ),
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }
  Widget _buildActionButtons() {
    return Center(
      child: SizedBox(width: double.infinity,
        child:
         ElevatedButton.icon(
          onPressed: _predict,
          iconAlignment: IconAlignment.end,
          
          label: Text('Submit for Prediction ',style: TextStyle(color: Colors.white, fontSize: 18,),),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            iconColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            
          ),
          icon: Icon(Icons.medical_services),
          
        ),
    
    ));
  }

  Future<void> _predict() async {
    if (_formKey.currentState!.validate()) {
      // Additional validation for blood pressure
      final systolic = int.parse(_systolicController.text);
      final diastolic = int.parse(_diastolicController.text);
      
      if (systolic <= diastolic) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Systolic pressure must be greater than diastolic'),
            backgroundColor: Colors.red,
          ),
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

// inside _predict()
final result = await Provider.of<PatientsProvider>(context, listen: false)
               .predict(patient);
             

if (result == true) {  
         // provider returns true on 201
  // success

  Navigator.pushReplacementNamed(context, '/prediction');
} else {          
                  // provider returns the error map
  final msg = result['error'] ?? 'Unknown error';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: Colors.red),
  );
    }}
  


}}
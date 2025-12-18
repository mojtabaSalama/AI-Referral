import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  _PatientFormScreenState createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _fullNameController = TextEditingController();
  String _selectedGender = '';
  final _ageController = TextEditingController();
  final _mainComplaintController = TextEditingController();
  double _painLevel = 1;
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();
  final _respiratoryRateController = TextEditingController();
  final _oxygenSaturationController = TextEditingController();
  final int _selectedTriage = 0;

  @override
  void dispose() {
    _fullNameController.dispose();
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
    return Scaffold(
      appBar: AppBar(
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

  Widget _buildBasicInfoSection() {
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
                FaIcon(FontAwesomeIcons.idCard, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
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
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name *',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter full name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedGender.isEmpty ? null : _selectedGender,
                    decoration: InputDecoration(
                      labelText: 'Gender *',
                      prefixIcon: Icon(Icons.people),
                    ),
                    items: ['Male', 'Female', 'Other']
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age *',
                      prefixIcon: Icon(Icons.calendar_today),
                      suffixText: 'years',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter age';
                      }
                      final age = int.tryParse(value);
                      if (age == null || age < 0 || age > 120) {
                        return 'Age must be 0-120';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
                labelText: 'Main Complaint *',
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
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
                overlayColor: _getPainColor().withOpacity(0.2),
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
return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(FontAwesomeIcons.stethoscope, color: Theme.of(context).primaryColor),
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
            LayoutBuilder(
              builder: (context, constraints) {
                final fieldWidth = (constraints.maxWidth - 16) / 2;

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: fieldWidth,
                      child: _buildVitalSignField(
                        controller: _systolicController,
                        label: 'Systolic Pressure *',
                        icon: Icons.monitor_heart,
                        suffix: 'mmHg',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Required';
                          final systolic = int.tryParse(value);
                          if (systolic == null || systolic < 60 || systolic > 250) return '60-250';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: fieldWidth,
                      child: _buildVitalSignField(
                        controller: _diastolicController,
                        label: 'Diastolic Pressure *',
                        icon: Icons.monitor_heart,
                        suffix: 'mmHg',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Required';
                          final diastolic = int.tryParse(value);
                          if (diastolic == null || diastolic < 40 || diastolic > 150) return '40-150';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: fieldWidth,
                      child: _buildVitalSignField(
                        controller: _pulseController,
                        label: 'Heart Rate *',
                        icon: Icons.favorite,
                        suffix: 'bpm',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Required';
                          final pulse = int.tryParse(value);
                          if (pulse == null || pulse < 30 || pulse > 200) return '30-200';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: fieldWidth,
                      child: _buildVitalSignField(
                        controller: _respiratoryRateController,
                        label: 'Respiratory Rate *',
                        icon: Icons.air,
                        suffix: '/min',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Required';
                          final rate = int.tryParse(value);
                          if (rate == null || rate < 5 || rate > 60) return '5-60';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: fieldWidth,
                      child: _buildVitalSignField(
                        controller: _oxygenSaturationController,
                        label: 'Oxygen Saturation *',
                        icon: Icons.local_hospital,
                        suffix: '%',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Required';
                          final oxygen = int.tryParse(value);
                          if (oxygen == null || oxygen < 40 || oxygen > 100) return '40-100%';
                          return null;
                        },
                      ),
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
  Widget _buildActionButtons() {
    return Center(
      child: SizedBox(width: double.infinity,
        child:
         ElevatedButton.icon(
          onPressed: (){},
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

  Widget _buildVitalSignField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String suffix,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixText: suffix,
      ),
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }





}
import 'package:ai_referral/models/records.dart';
import 'package:ai_referral/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}
class _PatientFormScreen extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _patientNameController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = '';
  
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
 
  
  final _pulseRateController = TextEditingController();
  final _oxygenSaturationController = TextEditingController();
  double _respiratoryRate = 16;
  double _painGrade = 0;
  final _clinicalNotesController = TextEditingController();

  @override
  void dispose() {
    _patientNameController.dispose();
    _ageController.dispose();

    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseRateController.dispose();
    _oxygenSaturationController.dispose();
    _clinicalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.close, color: isDark ? Colors.white70 : Colors.black54),
            Spacer(),
            Text(
              'Record Vitals',
              style: TextStyle(
                fontFamily: 'SplineSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                'History',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPatientCard(isDark),
            Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPatientDetailsSection(isDark),
                    SizedBox(height: 24),
                    _buildHeartRateSection(isDark),
                    SizedBox(height: 24),
                    _buildBloodPressureSection(isDark),
                    SizedBox(height: 24),
                    _buildBodyTemperatureSection(isDark),
                    SizedBox(height: 24),
                    _buildPulseAndOxygenSection(isDark),
                    SizedBox(height: 24),
                    _buildRespiratoryRateSection(isDark),
                    SizedBox(height: 24),
                    _buildPainGradeSection(isDark),
                    SizedBox(height: 24),
                    _buildClinicalNotesSection(isDark),
                    SizedBox(height: 100), // Space for bottom button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildBottomSaveButton(isDark),
    );
  }

  Widget _buildPatientCard(bool isDark) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: AppTheme.primary.withOpacity(0.3), width: 2),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 32,
                    color: AppTheme.primary,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sarah Jenkins',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                            ),
                            child: Text(
                              'Inpatient',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ID: #8921',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade500,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Last check: 4 hours ago',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Background blur effect
          Positioned(
            right: -24,
            bottom: -24,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(48),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color, bool isDark) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPatientDetailsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Patient Details', Icons.person, Colors.purple, isDark),
        SizedBox(height: 16),
        Row(
          children: [
           
            SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _ageController,
                label: 'Age',
                hint: 'Age',
                icon: Icons.calendar_today,
                isRequired: true,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age < 0 || age > 120) {
                    return '0-120';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildGenderSelector(isDark),
      ],
    );
  }

  Widget _buildGenderSelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppTheme.inputBorderDark : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedGender.isEmpty ? null : _selectedGender,
            decoration: InputDecoration(border: InputBorder.none),
            items: ['Male', 'Female', 'Non-binary', 'Other']
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
      ],
    );
  }

 

  Widget _buildBloodPressureSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Blood Pressure', Icons.water_drop, Colors.blue, isDark),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _systolicController,
                label: 'Systolic',
                hint: '120',
                icon: Icons.arrow_upward,
                isRequired: true,
                keyboardType: TextInputType.number,
                suffix: 'mmHg',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final systolic = int.tryParse(value);
                  if (systolic == null || systolic < 60 || systolic > 250) {
                    return '60-250';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _diastolicController,
                label: 'Diastolic',
                hint: '80',
                icon: Icons.arrow_downward,
                isRequired: true,
                keyboardType: TextInputType.number,
                suffix: 'mmHg',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final diastolic = int.tryParse(value);
                  if (diastolic == null || diastolic < 40 || diastolic > 150) {
                    return '40-150';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  
  Widget _buildPulseAndOxygenSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Pulse & O2 Saturation', Icons.waves, Colors.cyan, isDark),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _pulseRateController,
                label: 'Pulse Rate',
                hint: 'Enter pulse rate',
                icon: Icons.favorite,
                isRequired: true,
                keyboardType: TextInputType.number,
                suffix: 'BPM',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final pulseRate = int.tryParse(value);
                  if (pulseRate == null || pulseRate < 30 || pulseRate > 200) {
                    return '30-200';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _oxygenSaturationController,
                label: 'SpO2',
                hint: 'Enter O2 saturation',
                icon: Icons.air,
                isRequired: true,
                keyboardType: TextInputType.number,
                suffix: '%',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final oxygen = int.tryParse(value);
                  if (oxygen == null || oxygen < 40 || oxygen > 100) {
                    return '40-100%';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRespiratoryRateSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Respiratory Rate', Icons.air, AppTheme.primary, isDark),
        SizedBox(height: 16),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppTheme.inputBorderDark : Colors.grey.shade200,
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppTheme.primary,
                        inactiveTrackColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        thumbColor: AppTheme.primary,
                        overlayColor: AppTheme.primary.withOpacity(0.2),
                        valueIndicatorColor: AppTheme.primary,
                      ),
                      child: Slider(
                        value: _respiratoryRate,
                        min: 8,
                        max: 40,
                        divisions: 32,
                        label: _respiratoryRate.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            _respiratoryRate = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('8', style: TextStyle(fontSize: 12, color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600)),
                        Text('Normal (12-20)', style: TextStyle(fontSize: 12, color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600)),
                        Text('40+', style: TextStyle(fontSize: 12, color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _respiratoryRate.toInt().toString(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    'breaths/min',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPainGradeSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Pain Grade', Icons.sentiment_dissatisfied, Colors.red, isDark),
        SizedBox(height: 16),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppTheme.inputBorderDark : Colors.grey.shade200,
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.red,
                        inactiveTrackColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                        thumbColor: Colors.red,
                        overlayColor: Colors.red.withOpacity(0.2),
                        valueIndicatorColor: Colors.red,
                      ),
                      child: Slider(
                        value: _painGrade,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: _painGrade.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            _painGrade = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0', style: TextStyle(fontSize: 12, color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600)),
                        Text('Moderate', style: TextStyle(fontSize: 12, color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600)),
                        Text('10', style: TextStyle(fontSize: 12, color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _painGrade.toInt().toString(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    'Scale',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClinicalNotesSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clinical Notes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppTheme.inputBorderDark : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: _clinicalNotesController,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
              hintText: 'Add any additional observations about patient condition...',
              hintStyle: TextStyle(
                color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade500,
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 4,
            minLines: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = false,
    TextInputType? keyboardType,
    String? suffix,
    required String? Function(String?) validator,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600,
              ),
            ),
          ),
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppTheme.inputBorderDark : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              hintText: hint,
              hintStyle: TextStyle(
                color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade500,
              ),
              prefixIcon: Icon(icon, size: 20, color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600),
              suffixText: suffix,
              suffixStyle: TextStyle(
                color: isDark ? AppTheme.textSecondaryDark : Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            keyboardType: keyboardType,
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSaveButton(bool isDark) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            isDark ? AppTheme.backgroundDark.withOpacity(0) : AppTheme.backgroundLight.withOpacity(0),
            isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _saveVitalSigns,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: AppTheme.backgroundDark,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save, size: 20),
              SizedBox(width: 8),
              Text(
                'Save Record',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveVitalSigns() {
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

      final record = PatientRecord(
      
        age: int.parse(_ageController.text),
        gender: _selectedGender,
       
        blooddpressurSystol: systolic,
        blooddpressurDiastol: diastolic,
       
        pulseRate: int.parse(_pulseRateController.text),
        o2Saturation: int.parse(_oxygenSaturationController.text),
        respiratoryRate: _respiratoryRate.toInt(),
        painGrade: _painGrade.toInt(),
        chiefComplaint: _clinicalNotesController.text,
       
      );

   }
}}
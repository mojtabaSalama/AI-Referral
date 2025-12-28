
import 'package:ai_referral/app_state/patients_provider.dart';
import 'package:ai_referral/components/floating_button.dart';
import 'package:ai_referral/components/loading.dart';
import 'package:ai_referral/components/stat_card.dart';
import 'package:ai_referral/models/records.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Assessment extends StatefulWidget {
   final int id; 
  const Assessment({super.key ,required this.id});

  @override
  State<Assessment> createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<PatientsProvider>(context, listen: false).getByID(widget.id);
  });
}
  @override
  Widget build(BuildContext context) {
    
     

  return Consumer<PatientsProvider>(
        builder: (context, patientProvider, child) {
          
  
         if (patientProvider.isLoading || patientProvider.record == null) {
        return Loading(text: "loading");
      }
       var record = patientProvider.record!;
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
    leading: BackButton(
    color: Colors.white,          // colour
    onPressed: () => Navigator.of(context).pop(),
  ),
        title: const Text('Result'),
    

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
          StatCard(context: context, label: "Triage level", value: record.triageLevel==1?"Urgent":"Non Urgent",
          icon: record.triageLevel==1?Icons.warning:Icons.check, color: record.triageLevel==1?Colors.red:Colors.green, backgroundcolor: record.triageLevel==1?Color(0xFFF87171): Colors.white),
            const SizedBox(height: 24),
            _buildPatientInfo(record),
            const SizedBox(height: 24),
            _buildChiefComplaint(record),
            const SizedBox(height: 24),
            _buildVitalSigns(record),
            
            const SizedBox(height: 180),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingButton(),
    );});
  }

 

  Widget _buildPatientInfo(PatientRecord last) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 235, 229, 233),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'AGE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B7280),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                   Text(
                   last.age.toString() ,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(width: 1, height: 60, color: const Color(0xFFE5E7EB)),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'GENDER',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B7280),
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                   Text(
                      last.gender,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChiefComplaint(PatientRecord last) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Chief Complaint',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color:Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child:  Text(
            last.chiefComplaint,
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
      ],
    );
  }

  /*  NEW: every vital sign gets its own card  */
  Widget _buildVitalSigns(PatientRecord last) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Vital Signs',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),

        _buildVitalCard(
          icon: Icons.monitor_heart,
          iconColor: Colors.blue,
          label: 'Systolic Pressure',
          value: last.blooddpressurSystol.toString(),
          unit: 'mmHg',
        ),
        const SizedBox(height: 10),

        _buildVitalCard(
          icon: Icons.monitor_heart,
          iconColor: Colors.blue,
          label: 'Diastolic Pressure',
          value:  last.blooddpressurDiastol.toString(),
          unit: 'mmHg',
        ),
        const SizedBox(height: 10),

        _buildVitalCard(
          icon: Icons.favorite,
          iconColor: Colors.red,
          label:  "Pulse Rate",
          value: last.pulseRate.toString(),
          unit: 'bpm',
        ),
        const SizedBox(height: 10),

        _buildVitalCard(
          icon: Icons.air,
          iconColor: Colors.teal,
          label: 'Resp Rate',
          value: last.respiratoryRate.toString(),
          unit: '/min',
        ),
        const SizedBox(height: 10),

        _buildVitalCard(
          icon: Icons.water_drop,
          iconColor: Colors.cyan,
          label: 'O₂ Saturation',
          value:last.o2Saturation.toString(),
          unit: '%',
        ),
        const SizedBox(height: 12),

        _buildPainGrade(last),
      ],
    );
  }

  Widget _buildVitalCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String unit,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            right: 12,
            child: Icon(icon, size: 32, color: iconColor.withValues(alpha: 0.1)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPainGrade(PatientRecord last) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PAIN GRADE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children:  [
                  Text(
                      last.painGrade.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '/5',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.2,
                child: Container(
                  decoration: BoxDecoration(
                    color:
                  
                     const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildFloatingButton() {
    // 1.  Add this line to Scaffold
return
FloatingButton(bgColor:  const Color(0xFF2563EB), function: () {Navigator.pushNamedAndRemoveUntil
(context, '/form',(Route<dynamic> route) => false,
);}, 
icon: Icons.medication, text: 'Make New Prediction', textColor: Colors.white);

  
}
}
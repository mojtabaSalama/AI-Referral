import 'package:ai_referral/app_state/patients_provider.dart';
import 'package:ai_referral/components/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key });

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<PatientsProvider>(context, listen: false).fetchSummary(); 
  });
}
  
  @override
  Widget build(BuildContext context) {

     return Consumer<PatientsProvider>(
        builder: (context, patientProvider, child) {
           final summary = patientProvider.summary;
  //  if ( patientProvider.isLoading) {
  //   return Loading(text: "loading");
  // }
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Dashboard'), elevation: 0, centerTitle: false),
      body: Column( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
 padding: EdgeInsets.all(30),       
     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ Text(
          'Total Assessments',
style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 24),        ),
        const SizedBox(height: 4),
        // SUB-HEAD
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'All the assements made by the app to predict triage level',
            style:TextStyle(color: Colors.grey.shade600,fontSize: 12)
          ),
        ),],),),
          Column(
           
            
            children: [
              /* ----------  stats  ---------- */
              Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                     
                        _statCard(context, label: 'Total Patients', value: summary.total.toString(),  icon: Icons.groups, color: Colors.blue),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: _statCard(context, label: 'Urgent Cases', value: summary.totalUrgent.toString(), icon: Icons.warning, color: Colors.red)),
                            const SizedBox(width: 12),
                            Expanded(child: _statCard(context, label: 'Normal Status', value: summary.totalNonUrgent.toString(), icon: Icons.check_circle, color: Colors.green)),
                          ],
                        ),
                        SizedBox(height: 15,),
                        
                  Column(
                    children: [
                      FloatingButton(bgColor:  const Color(0xFF2563EB), function: () {Navigator.pushReplacementNamed(context, '/form');}, 
                      icon: Icons.medication, text: 'Make New Prediction', textColor: Colors.white),
                      SizedBox(height: 2,),
                      
                  FloatingButton(bgColor:   Colors.grey, function: () {Navigator.pushNamed(context, '/list');}, 
                  icon: Icons.history, text: 'Previous Assessments', textColor: Colors.black)
                    ],
                  )
                  
                      ],
                    ),
                  ),
                ],
              ),
          
              ],
          ),
        ],
      ),
    );});
  }

  /* ----------------  stat card  ---------------- */
  Widget _statCard(BuildContext context, {required String label, required String value, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(padding: const EdgeInsets.all(8),
             decoration: BoxDecoration(color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle), child: Icon(icon, color: color, size: 20)),
            ]),
          const SizedBox(height: 20 ),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
      ),
    );
  }
}
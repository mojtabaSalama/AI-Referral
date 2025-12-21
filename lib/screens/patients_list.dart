import 'package:ai_referral/app_state/patients_provider.dart';
import 'package:ai_referral/components/loading.dart';
import 'package:ai_referral/models/records.dart';
import 'package:ai_referral/screens/assment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* ==========================================================
   2.  WIDGET  (completely stateless)
========================================================== */
class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
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
    
         if (patientProvider.isLoading || patientProvider.records.isEmpty ) {
        return Loading(text: "loading");
      }
       final records = patientProvider.records;
    return Scaffold(
      
      /* ----------------  HEADER  ---------------- */
      appBar: AppBar(
        title: const Text('Patient List'),
        elevation: 0,
        centerTitle: false,
        leading: BackButton(
    color: Colors.white,          // colour
    onPressed: () => Navigator.of(context).pop(),
  ),),

      /* ----------------  BODY  ---------------- */
      body: Column(
        children: [
          /* ----------  filter chips  ---------- */
          Padding(
            padding: const EdgeInsets.fromLTRB(8,30,5,30),
            child: Center(
              child: SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: ['All', 'Urgent', 'Normal']
                      .map((label) => _chip(label,context, selected: label == 'All'))
                      .toList(),
                ),
              ),
            ),
          ),

          /* ----------  patient cards  ---------- */
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: records.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) => _card(context, records[i]),
            ),
          ),
        ],
      ),
    );});
  }

  /* ---------------------------------------------------------- */
  Widget _chip(String label,context, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? Theme.of(context).primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

Widget _card(BuildContext context, PatientRecord record) {
 final urgent=record.triageLevel==1;
  final borderColor = urgent ? Colors.red : Colors.green;

  return InkWell(
    onTap: () {
    
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Assessment(id:record.id!)));},
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,          // ← keep original surface colour
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),      // ← only border changes
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("#${record.id}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor),
                      ),
                      child: Text(
                        urgent ? 'Urgent' : 'Normal',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: borderColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(record.chiefComplaint,
                    style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: borderColor),
        ],
      ),
    ),
  );
}}
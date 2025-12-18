import 'package:flutter/material.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Patient #8834'),
        centerTitle: true,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Column(
        children: [
          /* -------------- 1. Patient banner -------------- */
          _PatientBanner(),

          /* -------------- 2. Vitals grid -------------- */
          const SizedBox(height: 16),
          _VitalsGrid(),

          /* -------------- 3. Next-steps card -------------- */
          const SizedBox(height: 16),
          _NextStepsCard(),

          const Spacer(),

          /* -------------- 4. Footer button -------------- */
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('File Assessment'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ----------------------------------------------------------
   1. Patient banner
---------------------------------------------------------- */
class _PatientBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 28),
              const SizedBox(width: 8),
              Text(
                'Routine Status',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Assessment indicates patient condition is stable and within normal limits',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          _infoRow('AGE', '45 Years'),
          _infoRow('GENDER', 'Male'),
          const SizedBox(height: 8),
          const Text(
            'Chief Complaint',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '"Mild headache, recurring for 2 days. Patient describes pain as dull and throbbing in the frontal region."',
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(label,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          Text(value),
        ],
      ),
    );
  }
}

/* ----------------------------------------------------------
   2. Vitals grid
---------------------------------------------------------- */
class _VitalsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const vitals = [
      {'title': 'BLOOD PRESSURE', 'value': '120/80', 'unit': 'mmHg'},
      {'title': 'PULSE RATE', 'value': '72', 'unit': 'bpm'},
      {'title': 'RESP RATE', 'value': '16', 'unit': '/min'},
      {'title': 'O2 SATURATION', 'value': '98', 'unit': '%'},
      {'title': 'PAIN GRADE', 'value': '2', 'unit': '/10'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Vital Signs – Just now',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: vitals.length,
            itemBuilder: (_, i) {
              final v = vitals[i];
              return _VitalCard(
                title: v['title']!,
                value: v['value']!,
                unit: v['unit']!,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VitalCard extends StatelessWidget {
  final String title, value, unit;
  const _VitalCard(
      {required this.title, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(unit, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

/* ----------------------------------------------------------
   3. Next-steps card
---------------------------------------------------------- */
class _NextStepsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Next Steps',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vitals are within normal limits. Suggested routine observation with next check-in 4 hours.',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
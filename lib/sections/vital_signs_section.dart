import 'package:ai_referral/components/vital_sign_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class VitalSignsSection extends StatelessWidget {
  final TextEditingController systolicController;
  final TextEditingController diastolicController;
  final TextEditingController pulseController;
  final TextEditingController respiratoryController;
  final TextEditingController oxygenController;

  const VitalSignsSection({
    required this.systolicController,
    required this.diastolicController,
    required this.pulseController,
    required this.respiratoryController,
    required this.oxygenController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              FaIcon(FontAwesomeIcons.stethoscope, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text('Vital Signs', style: _titleStyle(context)),
            ]),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (_, c) {
                final cross = c.maxWidth > 500 ? 2 : 1;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: cross,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 4,
                  children: [
                    VitalSignField(
                      controller: systolicController,
                      hint: 'Systolic Pressure *',
                      icon: Icons.monitor_heart,
                      suffix: 'mmHg',
                      validator: (v) => _range(v, 60, 250, '60-250'),
                    ),
                    VitalSignField(
                      controller: diastolicController,
                      hint: 'Diastolic Pressure *',
                      icon: Icons.monitor_heart,
                      suffix: 'mmHg',
                      validator: (v) => _range(v, 40, 150, '40-150'),
                    ),
                    VitalSignField(
                      controller: pulseController,
                      hint: 'Pulse Rate *',
                      icon: Icons.favorite,
                      suffix: 'bpm',
                      validator: (v) => _range(v, 30, 200, '30-200'),
                    ),
                    VitalSignField(
                      controller: respiratoryController,
                      hint: 'Respiratory Rate *',
                      icon: Icons.air,
                      suffix: '/min',
                      validator: (v) => _range(v, 5, 60, '5-60'),
                    ),
                    VitalSignField(
                      controller: oxygenController,
                      hint: 'Oxygen Saturation *',
                      icon: Icons.local_hospital,
                      suffix: '%',
                      validator: (v) => _range(v, 40, 100, '40-100%'),
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

  TextStyle _titleStyle(BuildContext c) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(c).primaryColor,
      );

  String? _range(String? v, int min, int max, String msg) {
    if (v == null || v.isEmpty) return 'Required';
    final n = int.tryParse(v);
    return (n == null || n < min || n > max) ? msg : null;
  }
}
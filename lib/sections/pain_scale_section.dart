import 'package:ai_referral/components/pain_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PainScaleSection extends StatelessWidget {
  final double painLevel;
  final ValueChanged<double> onChanged;
  const PainScaleSection({required this.painLevel, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    final painColor = painColorFor(painLevel);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              FaIcon(FontAwesomeIcons.heartPulse, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text('Pain Scale', style: _titleStyle(context)),
            ]),
            const SizedBox(height: 16),
            Text('Pain Level: ${painLevel.toInt()}/5', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: painColor,
                inactiveTrackColor: Colors.grey[300],
                thumbColor: painColor,
                overlayColor: painColor.withValues(alpha: 0.2),
                valueIndicatorColor: painColor,
              ),
              child: Slider(
                value: painLevel,
                min: 1,
                max: 5,
                divisions: 4,
                label: painLevel.toInt().toString(),
                onChanged: onChanged,
              ),
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
}
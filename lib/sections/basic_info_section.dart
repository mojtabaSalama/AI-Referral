import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/gender_dropdown.dart';
import '../widgets/age_field.dart';

class BasicInfoSection extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onGenderChanged;
  final TextEditingController ageController;

  const BasicInfoSection({
    required this.selectedGender,
    required this.onGenderChanged,
    required this.ageController,
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
              FaIcon(FontAwesomeIcons.idCard, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text('Basic Information', style: _titleStyle(context)),
            ]),
            const SizedBox(height: 16),
            LayoutBuilder(builder: (_, c) {
              final wide = c.maxWidth > 450;
              return wide
                  ? Row(children: [
                      Expanded(child: GenderDropdown(value: selectedGender, onChanged: onGenderChanged)),
                      const SizedBox(width: 16),
                      Expanded(child: AgeField(controller: ageController)),
                    ])
                  : Column(children: [
                      GenderDropdown(value: selectedGender, onChanged: onGenderChanged),
                      const SizedBox(height: 16),
                      AgeField(controller: ageController),
                    ]);
            }),
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
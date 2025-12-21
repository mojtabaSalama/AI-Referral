import 'package:ai_referral/models/records.dart';

class RecordsSummary {
  final int total;
  final int totalUrgent;
  final int totalNonUrgent;
  final List<PatientRecord>? records; // ← new

  RecordsSummary({
    this.total = 0,
    this.totalUrgent = 0,
    this.totalNonUrgent = 0,
    this.records,
  });

factory RecordsSummary.fromJson(Map<String, dynamic> json) => RecordsSummary(
      total           : json['total_records'] ?? 0,   // ← plural
      totalUrgent     : json['total_urgent']  ?? 0,
      totalNonUrgent  : json['total_non_urgent'] ?? 0,
      records         : json['records'] == null
          ? null
          : (json['records'] as List)
              .map((e) => PatientRecord.fromJson(e))
              .toList(),
    );
  /* ----------  toJson  ---------- */
  Map<String, dynamic> toJson() => {
        "total_record": total,
        "total_urgent": totalUrgent,
        "total_non_urgent": totalNonUrgent,
        "records": records?.map((e) => e.toJson()).toList(),
      };
}
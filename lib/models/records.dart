class PatientRecord {
  final int? id;
  final String? gender;
  final int? age;
  final String? chiefComplaint;
  final int? painGrade;
  final int? blooddpressurSystol;
  final int? blooddpressurDiastol;
  final int? pulseRate;
  final int? respiratoryRate;
  final int? o2Saturation;
  final int triageLevel;
  final DateTime? createdAt;

  PatientRecord({
    this.id,
    this.gender,
    this.age,
    this.chiefComplaint,
    this.painGrade,
    this.blooddpressurSystol,
    this.blooddpressurDiastol,
    this.pulseRate,
    this.respiratoryRate,
    this.o2Saturation,
    this.triageLevel = 0,
    this.createdAt,
  });

  factory PatientRecord.fromJson(Map<String, dynamic> json) => PatientRecord(
        id: json["id"],
        gender: json["gender"],
        age: json["age"],
        chiefComplaint: json["ChiefComplaint"],
        painGrade: json["PainGrade"],
        blooddpressurSystol: json["BlooddpressurSystol"],
        blooddpressurDiastol: json["BlooddpressurDiastol"],
        pulseRate: json["PulseRate"],
        respiratoryRate: json["RespiratoryRate"],
        o2Saturation: json["O2Saturation"],
        triageLevel: json["TriageLevel"] ,
      
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "age": age,
        "ChiefComplaint": chiefComplaint,
        "PainGrade": painGrade,
        "BlooddpressurSystol": blooddpressurSystol,
        "BlooddpressurDiastol": blooddpressurDiastol,
        "PulseRate": pulseRate,
        "RespiratoryRate": respiratoryRate,
        "O2Saturation": o2Saturation,
        "TriageLevel": triageLevel,
        
      };
}
class PatientRecord {
  final int? id;
  final String gender;
  final int age;
  final String chiefComplaint;
  final int painGrade;
  final int blooddpressurSystol;
  final int blooddpressurDiastol;
  final int pulseRate;
  final int respiratoryRate;
  final int o2Saturation;
  final int triageLevel;
  
  

  PatientRecord({
    this.id,
   required this.gender,
   required this.age,
   required this.chiefComplaint,
    required  this.painGrade,
    required  this.blooddpressurSystol,
    required  this.blooddpressurDiastol,
    required  this.pulseRate,
    required  this.respiratoryRate,
    required  this.o2Saturation,
    this.triageLevel = 0,
    
  });

factory PatientRecord.fromJson(Map<String, dynamic> json) => PatientRecord(
  id: json['id'] as int?,
  gender: json['gender'] as String,
  age: json['age'] as int,
  chiefComplaint: json['ChiefComplaint'] as String,
  painGrade: json['PainGrade'] as int,
  blooddpressurSystol: json['BlooddpressurSystol'] as int,
  blooddpressurDiastol: json['BlooddpressurDiastol'] as int,
  pulseRate: json['PulseRate'] as int,
  respiratoryRate: json['RespiratoryRate'] as int,
  o2Saturation: json['O2Saturation'] as int,
  triageLevel: json['TriageLevel'] as int? ?? 0,
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

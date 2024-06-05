class Employee {
  String? uid;
  String? employeename;
  String? position;
  String? contactno;
  String? experience;
  String? district;

  Employee({
    this.uid,
    this.employeename,
    this.position,
    this.contactno,
    this.experience,
    this.district,
  });

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      uid: map['uid'],
      employeename: map['employee_name'],
      position: map['position'],
      contactno: map['contact_no'],
      experience: map['experience'],
      district: map['district'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'employee_name': employeename,
      'position': position,
      'contact_no': contactno,
      'experience': experience,
      'district': district,
    };
  }
}

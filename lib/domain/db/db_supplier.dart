class DbSupplier {
  int id;
  String name;
  String address;
  String phone;
  String mobile;
  String fax;
  String email;
  int acCode;
  int opBal;
  int supplierType;
  int cCode;
  String contactPerson;
  String designation;
  String code;
  String remarks;
  int creditDays;
  String chequeName;
  String trEmirates;

  DbSupplier({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.mobile,
    required this.fax,
    required this.email,
    required this.acCode,
    required this.opBal,
    required this.supplierType,
    required this.cCode,
    required this.contactPerson,
    required this.designation,
    required this.code,
    required this.remarks,
    required this.creditDays,
    required this.chequeName,
    required this.trEmirates,
  });

  factory DbSupplier.fromJson(Map<String, dynamic> json) {
    return DbSupplier(
      id: json['Id'] as int,
      name: json['Name'] as String,
      address: json['Address'] as String,
      phone: json['Phone'] as String,
      mobile: json['Mobile'] as String,
      fax: json['Fax'] as String,
      email: json['Email'] as String,
      acCode: json['AcCode'] as int,
      opBal: json['OpBal'] as int,
      supplierType: json['SupplierType'] as int,
      cCode: json['CCode'] as int,
      contactPerson: json['ContactPerson'] as String,
      designation: json['Designation'] as String,
      code: json['code'] as String,
      remarks: json['remarks'] as String,
      creditDays: json['CreditDays'] as int,
      chequeName: json['ChequeName'] as String,
      trEmirates: json['TrEmirates'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Address': address,
      'Phone': phone,
      'Mobile': mobile,
      'Fax': fax,
      'Email': email,
      'AcCode': acCode,
      'OpBal': opBal,
      'SupplierType': supplierType,
      'CCode': cCode,
      'ContactPerson': contactPerson,
      'Designation': designation,
      'code': code,
      'remarks': remarks,
      'CreditDays': creditDays,
      'ChequeName': chequeName,
      'TrEmirates': trEmirates,
    };
  }
}

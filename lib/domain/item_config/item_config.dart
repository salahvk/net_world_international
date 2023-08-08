class ItemGetConfig {
  List<ENABLEREVERSECALCULATION>? eNABLEREVERSECALCULATION;
  List<AcCompanyData>? acCompanyData;
  List<BarcodeConfig>? barcodeConfig;
  List<CategoryList>? categoryList;
  List<DepartmentList>? departmentList;
  List<UnitList>? unitList;
  List<TaxList>? taxList;
  List<CategoryList>? secondCategoryList;
  List<SupplierMasterList>? supplierMasterList;

  ItemGetConfig(
      {this.eNABLEREVERSECALCULATION,
      this.acCompanyData,
      this.barcodeConfig,
      this.categoryList,
      this.departmentList,
      this.unitList,
      this.taxList,
      this.secondCategoryList,
      this.supplierMasterList});

  ItemGetConfig.fromJson(Map<String, dynamic> json) {
    if (json['ENABLEREVERSECALCULATION'] != null) {
      eNABLEREVERSECALCULATION = <ENABLEREVERSECALCULATION>[];
      json['ENABLEREVERSECALCULATION'].forEach((v) {
        eNABLEREVERSECALCULATION!.add(ENABLEREVERSECALCULATION.fromJson(v));
      });
    }
    if (json['AcCompanyData'] != null) {
      acCompanyData = <AcCompanyData>[];
      json['AcCompanyData'].forEach((v) {
        acCompanyData!.add(AcCompanyData.fromJson(v));
      });
    }
    if (json['BarcodeConfig'] != null) {
      barcodeConfig = <BarcodeConfig>[];
      json['BarcodeConfig'].forEach((v) {
        barcodeConfig!.add(BarcodeConfig.fromJson(v));
      });
    }
    if (json['CategoryList'] != null) {
      categoryList = <CategoryList>[];
      json['CategoryList'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
    if (json['DepartmentList'] != null) {
      departmentList = <DepartmentList>[];
      json['DepartmentList'].forEach((v) {
        departmentList!.add(DepartmentList.fromJson(v));
      });
    }
    if (json['UnitList'] != null) {
      unitList = <UnitList>[];
      json['UnitList'].forEach((v) {
        unitList!.add(UnitList.fromJson(v));
      });
    }
    if (json['TaxList'] != null) {
      taxList = <TaxList>[];
      json['TaxList'].forEach((v) {
        taxList!.add(TaxList.fromJson(v));
      });
    }
    if (json['SecondCategoryList'] != null) {
      secondCategoryList = <CategoryList>[];
      json['SecondCategoryList'].forEach((v) {
        secondCategoryList!.add(CategoryList.fromJson(v));
      });
    }
    if (json['SupplierMasterList'] != null) {
      supplierMasterList = <SupplierMasterList>[];
      json['SupplierMasterList'].forEach((v) {
        supplierMasterList!.add(SupplierMasterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eNABLEREVERSECALCULATION != null) {
      data['ENABLEREVERSECALCULATION'] =
          eNABLEREVERSECALCULATION!.map((v) => v.toJson()).toList();
    }
    if (acCompanyData != null) {
      data['AcCompanyData'] = acCompanyData!.map((v) => v.toJson()).toList();
    }
    if (barcodeConfig != null) {
      data['BarcodeConfig'] = barcodeConfig!.map((v) => v.toJson()).toList();
    }
    if (categoryList != null) {
      data['CategoryList'] = categoryList!.map((v) => v.toJson()).toList();
    }
    if (departmentList != null) {
      data['DepartmentList'] = departmentList!.map((v) => v.toJson()).toList();
    }
    if (unitList != null) {
      data['UnitList'] = unitList!.map((v) => v.toJson()).toList();
    }
    if (taxList != null) {
      data['TaxList'] = taxList!.map((v) => v.toJson()).toList();
    }
    if (secondCategoryList != null) {
      data['SecondCategoryList'] =
          secondCategoryList!.map((v) => v.toJson()).toList();
    }
    if (supplierMasterList != null) {
      data['SupplierMasterList'] =
          supplierMasterList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ENABLEREVERSECALCULATION {
  String? paramSubId;
  String? paramVal;

  ENABLEREVERSECALCULATION({this.paramSubId, this.paramVal});

  ENABLEREVERSECALCULATION.fromJson(Map<String, dynamic> json) {
    paramSubId = json['paramSubId'];
    paramVal = json['paramVal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paramSubId'] = paramSubId;
    data['paramVal'] = paramVal;
    return data;
  }
}

class AcCompanyData {
  String? barcodeStartChar;
  dynamic altBarcodeStartChar;

  AcCompanyData({this.barcodeStartChar, this.altBarcodeStartChar});

  AcCompanyData.fromJson(Map<String, dynamic> json) {
    barcodeStartChar = json['barcodeStartChar'];
    altBarcodeStartChar = json['altBarcodeStartChar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barcodeStartChar'] = barcodeStartChar;
    data['altBarcodeStartChar'] = altBarcodeStartChar;
    return data;
  }
}

class BarcodeConfig {
  String? paramID;
  String? paramText;
  String? paramSubId;
  String? paramVal;

  BarcodeConfig({this.paramID, this.paramText, this.paramSubId, this.paramVal});

  BarcodeConfig.fromJson(Map<String, dynamic> json) {
    paramID = json['paramID'];
    paramText = json['paramText'];
    paramSubId = json['paramSubId'];
    paramVal = json['paramVal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paramID'] = paramID;
    data['paramText'] = paramText;
    data['paramSubId'] = paramSubId;
    data['paramVal'] = paramVal;
    return data;
  }
}

class CategoryList {
  int? id;
  String? name;
  String? code;
  dynamic cKeys;
  int? departmentID;

  CategoryList({this.id, this.name, this.code, this.cKeys, this.departmentID});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    cKeys = json['cKeys'];
    departmentID = json['departmentID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['cKeys'] = cKeys;
    data['departmentID'] = departmentID;
    return data;
  }
}

class DepartmentList {
  int? id;
  String? name;
  int? purchaseAcCode;
  int? salesAcCode;
  String? code;
  String? arabicName;
  int? defaultmargin;
  int? showInCounterClose;
  int? taxId;

  DepartmentList(
      {this.id,
      this.name,
      this.purchaseAcCode,
      this.salesAcCode,
      this.code,
      this.arabicName,
      this.defaultmargin,
      this.showInCounterClose,
      this.taxId});

  DepartmentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    purchaseAcCode = json['purchaseAcCode'];
    salesAcCode = json['salesAcCode'];
    code = json['code'];
    arabicName = json['arabicName'];
    defaultmargin = json['defaultmargin'];
    showInCounterClose = json['showInCounterClose'];
    taxId = json['taxId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['purchaseAcCode'] = purchaseAcCode;
    data['salesAcCode'] = salesAcCode;
    data['code'] = code;
    data['arabicName'] = arabicName;
    data['defaultmargin'] = defaultmargin;
    data['showInCounterClose'] = showInCounterClose;
    data['taxId'] = taxId;
    return data;
  }
}

class UnitList {
  int? id;
  String? name;

  UnitList({this.id, this.name});

  UnitList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class TaxList {
  int? taxId;
  String? taxName;
  dynamic taxRate;
  bool? defaltTax;

  TaxList({this.taxId, this.taxName, this.taxRate, this.defaltTax});

  TaxList.fromJson(Map<String, dynamic> json) {
    taxId = json['taxId'];
    taxName = json['taxName'];
    taxRate = json['taxRate'];
    defaltTax = json['defaltTax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taxId'] = taxId;
    data['taxName'] = taxName;
    data['taxRate'] = taxRate;
    data['defaltTax'] = defaltTax;
    return data;
  }
}

class SupplierMasterList {
  int? id;
  String? name;
  String? address;
  String? phone;
  String? mobile;
  String? fax;
  String? email;
  int? acCode;
  int? opBal;
  int? supplierType;
  int? cCode;
  String? contactPerson;
  String? designation;
  String? code;
  String? remarks;
  int? creditDays;
  String? chequeName;
  String? trEmirates;
  dynamic moreDet;
  bool? inactive;
  bool? exlVAT;

  SupplierMasterList(
      {this.id,
      this.name,
      this.address,
      this.phone,
      this.mobile,
      this.fax,
      this.email,
      this.acCode,
      this.opBal,
      this.supplierType,
      this.cCode,
      this.contactPerson,
      this.designation,
      this.code,
      this.remarks,
      this.creditDays,
      this.chequeName,
      this.trEmirates,
      this.moreDet,
      this.inactive,
      this.exlVAT});

  SupplierMasterList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    mobile = json['mobile'];
    fax = json['fax'];
    email = json['email'];
    acCode = json['acCode'];
    opBal = json['opBal'];
    supplierType = json['supplierType'];
    cCode = json['cCode'];
    contactPerson = json['contactPerson'];
    designation = json['designation'];
    code = json['code'];
    remarks = json['remarks'];
    creditDays = json['creditDays'];
    chequeName = json['chequeName'];
    trEmirates = json['trEmirates'];
    moreDet = json['moreDet'];
    inactive = json['inactive'];
    exlVAT = json['exlVAT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['fax'] = fax;
    data['email'] = email;
    data['acCode'] = acCode;
    data['opBal'] = opBal;
    data['supplierType'] = supplierType;
    data['cCode'] = cCode;
    data['contactPerson'] = contactPerson;
    data['designation'] = designation;
    data['code'] = code;
    data['remarks'] = remarks;
    data['creditDays'] = creditDays;
    data['chequeName'] = chequeName;
    data['trEmirates'] = trEmirates;
    data['moreDet'] = moreDet;
    data['inactive'] = inactive;
    data['exlVAT'] = exlVAT;
    return data;
  }
}

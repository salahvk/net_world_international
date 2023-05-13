class GetitemsModel {
  int? id;
  String? itemMasterCode;
  String? name;
  String? shortName;
  int? categoryId;
  int? unitId;
  int? sellingPrice;
  int? costPrice;
  String? barcode;
  int? reorderLevel;
  int? reorderQty;
  String? supplierItemCode;
  int? departmentId;
  int? firstcategoryId;
  int? secondCategoryid;
  int? colorId;
  int? sizeid;
  int? nonStockItem;
  int? weighingScaleItem;
  String? shelfNo;
  String? rackNo;
  int? fOCitem;
  int? sellingUnitId;
  int? leadtime;
  int? sellingpricePackingUnit;
  String? suppliercode;
  int? discount;
  bool? active;
  bool? weighingwCount;
  int? delFlag;
  String? itemGroup;
  int? loadItems;
  String? createDate;
  String? createUser;
  String? modDate;
  String? modUser;
  String? arabicname;
  String? remarks;
  int? taxId;
  int? basePrice;
  int? counterStock;
  String? arabicBarcodeName;
  int? weighingItemType;

  GetitemsModel(
      {this.id,
      this.itemMasterCode,
      this.name,
      this.shortName,
      this.categoryId,
      this.unitId,
      this.sellingPrice,
      this.costPrice,
      this.barcode,
      this.reorderLevel,
      this.reorderQty,
      this.supplierItemCode,
      this.departmentId,
      this.firstcategoryId,
      this.secondCategoryid,
      this.colorId,
      this.sizeid,
      this.nonStockItem,
      this.weighingScaleItem,
      this.shelfNo,
      this.rackNo,
      this.fOCitem,
      this.sellingUnitId,
      this.leadtime,
      this.sellingpricePackingUnit,
      this.suppliercode,
      this.discount,
      this.active,
      this.weighingwCount,
      this.delFlag,
      this.itemGroup,
      this.loadItems,
      this.createDate,
      this.createUser,
      this.modDate,
      this.modUser,
      this.arabicname,
      this.remarks,
      this.taxId,
      this.basePrice,
      this.counterStock,
      this.arabicBarcodeName,
      this.weighingItemType});

  GetitemsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    itemMasterCode = json['ItemMasterCode'];
    name = json['Name'];
    shortName = json['ShortName'];
    categoryId = json['CategoryId'];
    unitId = json['UnitId'];
    sellingPrice = json['SellingPrice'];
    costPrice = json['CostPrice'];
    barcode = json['Barcode'];
    reorderLevel = json['ReorderLevel'];
    reorderQty = json['ReorderQty'];
    supplierItemCode = json['SupplierItemCode'];
    departmentId = json['DepartmentId'];
    firstcategoryId = json['FirstcategoryId'];
    secondCategoryid = json['SecondCategoryid'];
    colorId = json['ColorId'];
    sizeid = json['Sizeid'];
    nonStockItem = json['NonStockItem'];
    weighingScaleItem = json['WeighingScaleItem'];
    shelfNo = json['ShelfNo'];
    rackNo = json['RackNo'];
    fOCitem = json['FOCitem'];
    sellingUnitId = json['SellingUnitId'];
    leadtime = json['Leadtime'];
    sellingpricePackingUnit = json['SellingpricePackingUnit'];
    suppliercode = json['suppliercode'];
    discount = json['Discount'];
    active = json['Active'];
    weighingwCount = json['WeighingwCount'];
    delFlag = json['DelFlag'];
    itemGroup = json['ItemGroup'];
    loadItems = json['LoadItems'];
    createDate = json['CreateDate'];
    createUser = json['CreateUser'];
    modDate = json['ModDate'];
    modUser = json['ModUser'];
    arabicname = json['Arabicname'];
    remarks = json['Remarks'];
    taxId = json['TaxId'];
    basePrice = json['BasePrice'];
    counterStock = json['CounterStock'];
    arabicBarcodeName = json['ArabicBarcodeName'];
    weighingItemType = json['WeighingItemType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ItemMasterCode'] = itemMasterCode;
    data['Name'] = name;
    data['ShortName'] = shortName;
    data['CategoryId'] = categoryId;
    data['UnitId'] = unitId;
    data['SellingPrice'] = sellingPrice;
    data['CostPrice'] = costPrice;
    data['Barcode'] = barcode;
    data['ReorderLevel'] = reorderLevel;
    data['ReorderQty'] = reorderQty;
    data['SupplierItemCode'] = supplierItemCode;
    data['DepartmentId'] = departmentId;
    data['FirstcategoryId'] = firstcategoryId;
    data['SecondCategoryid'] = secondCategoryid;
    data['ColorId'] = colorId;
    data['Sizeid'] = sizeid;
    data['NonStockItem'] = nonStockItem;
    data['WeighingScaleItem'] = weighingScaleItem;
    data['ShelfNo'] = shelfNo;
    data['RackNo'] = rackNo;
    data['FOCitem'] = fOCitem;
    data['SellingUnitId'] = sellingUnitId;
    data['Leadtime'] = leadtime;
    data['SellingpricePackingUnit'] = sellingpricePackingUnit;
    data['suppliercode'] = suppliercode;
    data['Discount'] = discount;
    data['Active'] = active;
    data['WeighingwCount'] = weighingwCount;
    data['DelFlag'] = delFlag;
    data['ItemGroup'] = itemGroup;
    data['LoadItems'] = loadItems;
    data['CreateDate'] = createDate;
    data['CreateUser'] = createUser;
    data['ModDate'] = modDate;
    data['ModUser'] = modUser;
    data['Arabicname'] = arabicname;
    data['Remarks'] = remarks;
    data['TaxId'] = taxId;
    data['BasePrice'] = basePrice;
    data['CounterStock'] = counterStock;
    data['ArabicBarcodeName'] = arabicBarcodeName;
    data['WeighingItemType'] = weighingItemType;
    return data;
  }
}

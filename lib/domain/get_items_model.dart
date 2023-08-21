class GetitemsModel {
  List<Items>? items;

  GetitemsModel({this.items});

  GetitemsModel.fromJson(Map<String?, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }
}

// class Items {
//   dynamic itemmasterid;
//   // String? itemMasterCode;
//   String? itemName;
//   String? shortName;
//   dynamic categoryId;
//   dynamic unitId;
//   double? sellingPrice;
//   double? costPrice;
//   String? barcode;
//   dynamic reorderLevel;
//   dynamic reorderQty;
//   String? supplierItemCode;
//   dynamic departmentId;
//   dynamic firstCategoryId;
//   dynamic secondCategoryId;
//   dynamic colorId;
//   dynamic sizeId;
//   dynamic nonStockItem;
//   dynamic weighingScaleItem;
//   String? shelfNo;
//   String? rackNo;
//   dynamic focItem;
//   // String? sellingUnitId;
//   // String? leadTime;
//   // String? sellingPricePackingUnit;
//   String? supplierCode;
//   dynamic discount;
//   bool? active;
//   bool? weighingwCount;
//   dynamic delFlag;
//   String? itemGroup;
//   dynamic loadItems;
//   String? createDate;
//   String? createUser;
//   String? modDate;
//   String? modUser;
//   String? arabicName;
//   String? remarks;
//   dynamic taxId;
//   // dynamic basePrice;
//   // dynamic counterStock;
//   // String? arabicBarcodeName;
//   // String? weighingItemType;

//   Items({
//     this.itemmasterid,
//     //  this.itemMasterCode,
//     this.itemName,
//     this.shortName,
//     this.categoryId,
//     this.unitId,
//     this.sellingPrice,
//     this.costPrice,
//     this.barcode,
//     this.reorderLevel,
//     this.reorderQty,
//     this.supplierItemCode,
//     this.departmentId,
//     this.firstCategoryId,
//     this.secondCategoryId,
//     this.colorId,
//     this.sizeId,
//     this.nonStockItem,
//     this.weighingScaleItem,
//     this.shelfNo,
//     this.rackNo,
//     this.focItem,
//     //  this.sellingUnitId,
//     //  this.leadTime,
//     //  this.sellingPricePackingUnit,
//     this.supplierCode,
//     this.discount,
//     this.active,
//     this.weighingwCount,
//     this.delFlag,
//     this.itemGroup,
//     this.loadItems,
//     this.createDate,
//     this.createUser,
//     this.modDate,
//     this.modUser,
//     this.arabicName,
//     this.remarks,
//     this.taxId,
//     //  this.basePrice,
//     //  this.counterStock,
//     //  this.arabicBarcodeName,
//     //  this.weighingItemType,
//   });

//   factory Items.fromJson(Map<String?, dynamic> json) {
//     return Items(
//       itemmasterid: json['itemmasterid'],
//       // itemMasterCode: json['ItemMasterCode'],
//       itemName: json['ItemName'],
//       shortName: json['ShortName'],
//       categoryId: json['CategoryId'],
//       unitId: json['UnitId'],
//       sellingPrice: json['SellingPrice'],
//       costPrice: json['CostPrice'],
//       barcode: json['Barcode'],
//       reorderLevel: json['ReorderLevel'],
//       reorderQty: json['ReorderQty'],
//       supplierItemCode: json['SupplierItemCode'],
//       departmentId: json['DepartmentId'],
//       firstCategoryId: json['FirstcategoryId'],
//       secondCategoryId: json['SecondCategoryid'],
//       colorId: json['ColorId'],
//       sizeId: json['Sizeid'],
//       nonStockItem: json['NonStockItem'],
//       weighingScaleItem: json['WeighingScaleItem'],
//       shelfNo: json['ShelfNo'],
//       rackNo: json['RackNo'],
//       focItem: json['FOCitem'],
//       // sellingUnitId: json['SellingUnitId'],
//       // leadTime: json['Leadtime'],
//       // sellingPricePackingUnit: json['SellingpricePackingUnit'],
//       supplierCode: json['suppliercode'],
//       discount: json['Discount'],
//       active: json['Active'],
//       weighingwCount: json['WeighingwCount'],
//       delFlag: json['DelFlag'],
//       itemGroup: json['ItemGroup'],
//       loadItems: json['LoadItems'],
//       createDate: json['CreateDate'],
//       createUser: json['CreateUser'],
//       modDate: json['ModDate'],
//       modUser: json['ModUser'],
//       arabicName: json['Arabicname'],
//       remarks: json['Remarks'],
//       taxId: json['TaxId'],
//       // basePrice: json['BasePrice'],
//       // counterStock: json['CounterStock'],
//       // arabicBarcodeName: json['ArabicBarcodeName'],
//       // weighingItemType: json['WeighingItemType'],
//     );
//   }
// }

class Items {
  String? itemMasterCode;
  String? itemName;
  String? shortName;
  dynamic categoryId;
  dynamic sellingPrice;
  dynamic costPrice;
  String? barcode;
  dynamic reorderLevel;
  dynamic reorderQty;
  String? supplierItemCode;
  dynamic departmentId;
  dynamic firstcategoryId;
  dynamic secondCategoryid;
  dynamic colorId;
  dynamic sizeid;
  bool? nonStockItem;
  bool? weighingScaleItem;
  String? shelfNo;
  String? rackNo;
  bool? foCitem;
  dynamic sellingUnitId;
  dynamic leadtime;
  dynamic sellingpricePackingUnit;
  String? supplierCode;
  dynamic discount;
  bool? active;
  dynamic weighingwCount;
  bool? delFlag;
  String? itemGroup;
  bool? loadItems;
  String? createDate;
  String? createUser;
  String? modDate;
  String? modUser;
  String? arabicname;
  String? remarks;
  dynamic taxId;
  dynamic basePrice;
  bool? counterStock;
  String? arabicBarcodeName;
  dynamic weighingItemType;
  dynamic itemMasterId;
  dynamic unitId;
  String? deviceName;
  String? userId;

  Items(
      {this.itemMasterCode,
      this.itemName,
      this.shortName,
      this.categoryId,
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
      this.foCitem,
      this.sellingUnitId,
      this.leadtime,
      this.sellingpricePackingUnit,
      this.supplierCode,
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
      this.weighingItemType,
      this.itemMasterId,
      this.unitId,
      this.deviceName,
      this.userId});

  Items.fromJson(Map<String, dynamic> json) {
    itemMasterCode = json['itemMasterCode'];
    itemName = json['ItemName'];
    shortName = json['ShortName'];
    categoryId = json['CategoryId'];
    sellingPrice = json['SellingPrice'];
    costPrice = json['CostPrice'];
    barcode = json['Barcode'];
    reorderLevel = json['reorderLevel'];
    reorderQty = json['reorderQty'];
    supplierItemCode = json['SupplierItemCode'];
    departmentId = json['DepartmentId'];
    firstcategoryId = json['FirstcategoryId'];
    secondCategoryid = json['SecondCategoryid'];
    colorId = json['colorId'];
    sizeid = json['sizeid'];
    nonStockItem = json['nonStockItem'];
    weighingScaleItem = json['weighingScaleItem'];
    shelfNo = json['shelfNo'];
    rackNo = json['rackNo'];
    foCitem = json['foCitem'];
    sellingUnitId = json['sellingUnitId'];
    leadtime = json['leadtime'];
    sellingpricePackingUnit = json['sellingpricePackingUnit'];
    supplierCode = json['supplierCode'];
    discount = json['Discount'];
    active = json['Active'];
    weighingwCount = json['weighingwCount'];
    delFlag = json['delFlag'];
    itemGroup = json['itemGroup'];
    loadItems = json['loadItems'];
    createDate = json['createDate'];
    createUser = json['createUser'];
    modDate = json['modDate'];
    modUser = json['modUser'];
    arabicname = json['ArabicName'];
    remarks = json['remarks'];
    taxId = json['TaxId'];
    basePrice = json['basePrice'];
    counterStock = json['counterStock'];
    arabicBarcodeName = json['arabicBarcodeName'];
    weighingItemType = json['weighingItemType'];
    itemMasterId = json['itemmasterid'];
    unitId = json['UnitId'];
    deviceName = json['deviceName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemMasterCode'] = itemMasterCode;
    data['ItemName'] = itemName;
    data['shortName'] = shortName;
    data['categoryId'] = categoryId;
    data['sellingPrice'] = sellingPrice;
    data['costPrice'] = costPrice;
    data['barcode'] = barcode;
    data['reorderLevel'] = reorderLevel;
    data['reorderQty'] = reorderQty;
    data['supplierItemCode'] = supplierItemCode;
    data['departmentId'] = departmentId;
    data['firstcategoryId'] = firstcategoryId;
    data['secondCategoryid'] = secondCategoryid;
    data['colorId'] = colorId;
    data['sizeid'] = sizeid;
    data['nonStockItem'] = nonStockItem;
    data['weighingScaleItem'] = weighingScaleItem;
    data['shelfNo'] = shelfNo;
    data['rackNo'] = rackNo;
    data['foCitem'] = foCitem;
    data['sellingUnitId'] = sellingUnitId;
    data['leadtime'] = leadtime;
    data['sellingpricePackingUnit'] = sellingpricePackingUnit;
    data['supplierCode'] = supplierCode;
    data['discount'] = discount;
    data['active'] = active;
    data['weighingwCount'] = weighingwCount;
    data['delFlag'] = delFlag;
    data['itemGroup'] = itemGroup;
    data['loadItems'] = loadItems;
    data['createDate'] = createDate;
    data['createUser'] = createUser;
    data['modDate'] = modDate;
    data['modUser'] = modUser;
    data['arabicname'] = arabicname;
    data['remarks'] = remarks;
    data['taxId'] = taxId;
    data['basePrice'] = basePrice;
    data['counterStock'] = counterStock;
    data['arabicBarcodeName'] = arabicBarcodeName;
    data['weighingItemType'] = weighingItemType;
    data['itemMasterId'] = itemMasterId;
    data['UnitId'] = unitId;
    data['deviceName'] = deviceName;
    data['userId'] = userId;
    return data;
  }
}

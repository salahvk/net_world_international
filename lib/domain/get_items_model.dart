class GetitemsModel {
  List<Items>? items;

  GetitemsModel({this.items});

  factory GetitemsModel.fromJson(Map<String, dynamic> json) {
    return GetitemsModel(
      items:
          List<Items>.from(json['items'].map((item) => Items.fromJson(item))),
    );
  }
}

class Items {
  int id;
  // String itemMasterCode;
  String name;
  String shortName;
  int categoryId;
  int unitId;
  double sellingPrice;
  double costPrice;
  String barcode;
  int reorderLevel;
  int reorderQty;
  String supplierItemCode;
  int departmentId;
  int firstCategoryId;
  int secondCategoryId;
  int colorId;
  int sizeId;
  int nonStockItem;
  int weighingScaleItem;
  String shelfNo;
  String rackNo;
  int focItem;
  // String sellingUnitId;
  // String leadTime;
  // String sellingPricePackingUnit;
  String supplierCode;
  int discount;
  bool active;
  bool weighingwCount;
  int delFlag;
  String itemGroup;
  int loadItems;
  String createDate;
  String createUser;
  String modDate;
  String modUser;
  String arabicName;
  String remarks;
  int taxId;
  // int basePrice;
  // int counterStock;
  // String arabicBarcodeName;
  // String weighingItemType;

  Items({
    required this.id,
    // required this.itemMasterCode,
    required this.name,
    required this.shortName,
    required this.categoryId,
    required this.unitId,
    required this.sellingPrice,
    required this.costPrice,
    required this.barcode,
    required this.reorderLevel,
    required this.reorderQty,
    required this.supplierItemCode,
    required this.departmentId,
    required this.firstCategoryId,
    required this.secondCategoryId,
    required this.colorId,
    required this.sizeId,
    required this.nonStockItem,
    required this.weighingScaleItem,
    required this.shelfNo,
    required this.rackNo,
    required this.focItem,
    // required this.sellingUnitId,
    // required this.leadTime,
    // required this.sellingPricePackingUnit,
    required this.supplierCode,
    required this.discount,
    required this.active,
    required this.weighingwCount,
    required this.delFlag,
    required this.itemGroup,
    required this.loadItems,
    required this.createDate,
    required this.createUser,
    required this.modDate,
    required this.modUser,
    required this.arabicName,
    required this.remarks,
    required this.taxId,
    // required this.basePrice,
    // required this.counterStock,
    // required this.arabicBarcodeName,
    // required this.weighingItemType,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['Id'],
      // itemMasterCode: json['ItemMasterCode'],
      name: json['Name'],
      shortName: json['ShortName'],
      categoryId: json['CategoryId'],
      unitId: json['UnitId'],
      sellingPrice: json['SellingPrice'],
      costPrice: json['CostPrice'],
      barcode: json['Barcode'],
      reorderLevel: json['ReorderLevel'],
      reorderQty: json['ReorderQty'],
      supplierItemCode: json['SupplierItemCode'],
      departmentId: json['DepartmentId'],
      firstCategoryId: json['FirstcategoryId'],
      secondCategoryId: json['SecondCategoryid'],
      colorId: json['ColorId'],
      sizeId: json['Sizeid'],
      nonStockItem: json['NonStockItem'],
      weighingScaleItem: json['WeighingScaleItem'],
      shelfNo: json['ShelfNo'],
      rackNo: json['RackNo'],
      focItem: json['FOCitem'],
      // sellingUnitId: json['SellingUnitId'],
      // leadTime: json['Leadtime'],
      // sellingPricePackingUnit: json['SellingpricePackingUnit'],
      supplierCode: json['suppliercode'],
      discount: json['Discount'],
      active: json['Active'],
      weighingwCount: json['WeighingwCount'],
      delFlag: json['DelFlag'],
      itemGroup: json['ItemGroup'],
      loadItems: json['LoadItems'],
      createDate: json['CreateDate'],
      createUser: json['CreateUser'],
      modDate: json['ModDate'],
      modUser: json['ModUser'],
      arabicName: json['Arabicname'],
      remarks: json['Remarks'],
      taxId: json['TaxId'],
      // basePrice: json['BasePrice'],
      // counterStock: json['CounterStock'],
      // arabicBarcodeName: json['ArabicBarcodeName'],
      // weighingItemType: json['WeighingItemType'],
    );
  }
}

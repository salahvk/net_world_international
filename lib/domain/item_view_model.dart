// class ItemViewById {
//   Items? items;

//   ItemViewById({this.items});

//   ItemViewById.fromJson(Map<String?, dynamic> json) {
//     items = json['items'] != null ? Items.fromJson(json['items']) : null;
//   }

//   bool get active => false;

//   set active(bool active) {}

//   Map<String?, dynamic> toJson() {
//     final Map<String?, dynamic> data = <String?, dynamic>{};
//     if (items != null) {
//       data['items'] = items?.toJson();
//     }
//     return data;
//   }
// }

// class Items {
//   dynamic id;
//   String? name;
//   String? shortName;
//   dynamic categoryId;
//   dynamic unitId;
//   dynamic sellingPrice;
//   dynamic costPrice;
//   String? barcode;
//   dynamic reorderLevel;
//   dynamic reorderQty;
//   String? supplierItemCode;
//   dynamic departmentId;
//   dynamic firstcategoryId;
//   dynamic secondCategoryid;
//   dynamic colorId;
//   dynamic sizeid;
//   dynamic nonStockItem;
//   dynamic weighingScaleItem;
//   String? shelfNo;
//   String? rackNo;
//   dynamic fOCitem;
//   String? suppliercode;
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
//   String? arabicname;
//   String? remarks;
//   dynamic taxId;

//   Items(
//       {this.id,
//       this.name,
//       this.shortName,
//       this.categoryId,
//       this.unitId,
//       this.sellingPrice,
//       this.costPrice,
//       this.barcode,
//       this.reorderLevel,
//       this.reorderQty,
//       this.supplierItemCode,
//       this.departmentId,
//       this.firstcategoryId,
//       this.secondCategoryid,
//       this.colorId,
//       this.sizeid,
//       this.nonStockItem,
//       this.weighingScaleItem,
//       this.shelfNo,
//       this.rackNo,
//       this.fOCitem,
//       this.suppliercode,
//       this.discount,
//       this.active,
//       this.weighingwCount,
//       this.delFlag,
//       this.itemGroup,
//       this.loadItems,
//       this.createDate,
//       this.createUser,
//       this.modDate,
//       this.modUser,
//       this.arabicname,
//       this.remarks,
//       this.taxId});

//   Items.fromJson(Map<String?, dynamic> json) {
//     id = json['Id'];
//     name = json['Name'];
//     shortName = json['ShortName'];
//     categoryId = json['CategoryId'];
//     unitId = json['UnitId'];
//     sellingPrice = json['SellingPrice'];
//     costPrice = json['CostPrice'];
//     barcode = json['Barcode'];
//     reorderLevel = json['ReorderLevel'];
//     reorderQty = json['ReorderQty'];
//     supplierItemCode = json['SupplierItemCode'];
//     departmentId = json['DepartmentId'];
//     firstcategoryId = json['FirstcategoryId'];
//     secondCategoryid = json['SecondCategoryid'];
//     colorId = json['ColorId'];
//     sizeid = json['Sizeid'];
//     nonStockItem = json['NonStockItem'];
//     weighingScaleItem = json['WeighingScaleItem'];
//     shelfNo = json['ShelfNo'];
//     rackNo = json['RackNo'];
//     fOCitem = json['FOCitem'];
//     suppliercode = json['suppliercode'];
//     discount = json['Discount'];
//     active = json['Active'];
//     weighingwCount = json['WeighingwCount'];
//     delFlag = json['DelFlag'];
//     itemGroup = json['ItemGroup'];
//     loadItems = json['LoadItems'];
//     createDate = json['CreateDate'];
//     createUser = json['CreateUser'];
//     modDate = json['ModDate'];
//     modUser = json['ModUser'];
//     arabicname = json['Arabicname'];
//     remarks = json['Remarks'];
//     taxId = json['TaxId'];
//   }

//   Map<String?, dynamic> toJson() {
//     final Map<String?, dynamic> data = <String?, dynamic>{};
//     data['Id'] = id;
//     data['Name'] = name;
//     data['ShortName'] = shortName;
//     data['CategoryId'] = categoryId;
//     data['UnitId'] = unitId;
//     data['SellingPrice'] = sellingPrice;
//     data['CostPrice'] = costPrice;
//     data['Barcode'] = barcode;
//     data['ReorderLevel'] = reorderLevel;
//     data['ReorderQty'] = reorderQty;
//     data['SupplierItemCode'] = supplierItemCode;
//     data['DepartmentId'] = departmentId;
//     data['FirstcategoryId'] = firstcategoryId;
//     data['SecondCategoryid'] = secondCategoryid;
//     data['ColorId'] = colorId;
//     data['Sizeid'] = sizeid;
//     data['NonStockItem'] = nonStockItem;
//     data['WeighingScaleItem'] = weighingScaleItem;
//     data['ShelfNo'] = shelfNo;
//     data['RackNo'] = rackNo;
//     data['FOCitem'] = fOCitem;
//     data['suppliercode'] = suppliercode;
//     data['Discount'] = discount;
//     data['Active'] = active;
//     data['WeighingwCount'] = weighingwCount;
//     data['DelFlag'] = delFlag;
//     data['ItemGroup'] = itemGroup;
//     data['LoadItems'] = loadItems;
//     data['CreateDate'] = createDate;
//     data['CreateUser'] = createUser;
//     data['ModDate'] = modDate;
//     data['ModUser'] = modUser;
//     data['Arabicname'] = arabicname;
//     data['Remarks'] = remarks;
//     data['TaxId'] = taxId;
//     return data;
//   }
// }

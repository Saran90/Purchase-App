class Items {
  num? purchaseDetailId;
  num? productId;
  String? productName;
  String? packing;
  String? barcode;
  String? hsnCode;
  num? mrp;
  num? quantity;
  num? freeQuantity;
  num? rowNumber;
  num? taxPercentage;

  Items({
    this.purchaseDetailId,
    this.barcode,
    this.hsnCode,
    this.taxPercentage,
    this.packing,
    this.productId,
    this.productName,
    this.mrp,
    this.quantity,
    this.freeQuantity,
    this.rowNumber,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["purchaseDetailId"] = purchaseDetailId;
    map["productId"] = productId;
    map["Packing"] = packing;
    map["productName"] = productName;
    map["mrp"] = mrp;
    map["quantity"] = quantity;
    map["freeQuantity"] = freeQuantity;
    map["rowNumber"] = rowNumber;
    map["BarCode"] = barcode;
    map["HsnCode"] = hsnCode;
    map["TaxPer"] = taxPercentage;
    return map;
  }

  Items.fromJson(dynamic json) {
    purchaseDetailId = json["purchaseDetailId"];
    productId = json["productId"];
    productName = json["productName"];
    packing = json["packing"];
    mrp = json["mrp"];
    quantity = json["quantity"];
    freeQuantity = json["freeQuantity"];
    rowNumber = json["rowNumber"];
    barcode = json["BarCode"];
    hsnCode = json["HsnCode"];
    taxPercentage = json["TaxPer"];
  }
}

class AddPurchaseRequest {
  num? purchaseId;
  num? purchaseNo;
  String? purchaseDate;
  String? invoiceNo;
  String? invoiceDate;
  num? supplierId;
  String? supplierName;
  num? billAmount;
  num? userId;
  List<Items>? itemsList;

  AddPurchaseRequest({
    this.purchaseId,
    this.purchaseNo,
    this.purchaseDate,
    this.invoiceNo,
    this.invoiceDate,
    this.supplierId,
    this.supplierName,
    this.billAmount,
    this.userId,
    this.itemsList,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["purchaseId"] = purchaseId;
    map["purchaseNo"] = purchaseNo;
    map["purchaseDate"] = purchaseDate;
    map["invoiceNo"] = invoiceNo;
    map["invoiceDate"] = invoiceDate;
    map["supplierId"] = supplierId;
    map["supplierName"] = supplierName;
    map["billAmount"] = billAmount;
    map["userId"] = userId;
    if (itemsList != null) {
      map["items"] = itemsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  AddPurchaseRequest.fromJson(dynamic json) {
    purchaseId = json["purchaseId"];
    purchaseNo = json["purchaseNo"];
    purchaseDate = json["purchaseDate"];
    invoiceNo = json["invoiceNo"];
    invoiceDate = json["invoiceDate"];
    supplierId = json["supplierId"];
    supplierName = json["supplierName"];
    billAmount = json["billAmount"];
    userId = json["userId"];
    if (json["items"] != null) {
      itemsList = [];
      json["items"].forEach((v) {
        itemsList?.add(Items.fromJson(v));
      });
    }
  }
}

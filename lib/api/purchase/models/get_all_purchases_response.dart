class DataList {
  num? purchaseId;
  num? purchaseNo;
  String? purchaseDate;
  String? invoiceNo;
  String? invoiceDate;
  num? supplierId;
  String? supplierName;
  bool? isImported;
  num? billAmount;
  num? userId;
  dynamic items;

  DataList(
      {this.purchaseId, this.purchaseNo, this.purchaseDate, this.invoiceNo, this.invoiceDate, this.supplierId, this.supplierName, this.isImported, this.billAmount, this.userId, this.items});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["purchaseId"] = purchaseId;
    map["purchaseNo"] = purchaseNo;
    map["purchaseDate"] = purchaseDate;
    map["invoiceNo"] = invoiceNo;
    map["invoiceDate"] = invoiceDate;
    map["supplierId"] = supplierId;
    map["supplierName"] = supplierName;
    map["isImported"] = isImported;
    map["billAmount"] = billAmount;
    map["userId"] = userId;
    map["items"] = items;
    return map;
  }

  DataList.fromJson(dynamic json){
    purchaseId = json["purchaseId"];
    purchaseNo = json["purchaseNo"];
    purchaseDate = json["purchaseDate"];
    invoiceNo = json["invoiceNo"];
    invoiceDate = json["invoiceDate"];
    supplierId = json["supplierId"];
    supplierName = json["supplierName"];
    isImported = json["isImported"];
    billAmount = json["billAmount"];
    userId = json["userId"];
    items = json["items"];
  }
}

class GetAllPurchasesResponse {
  List<DataList>? dataListList;

  GetAllPurchasesResponse({this.dataListList});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataListList != null) {
      map["dataList"] = dataListList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  GetAllPurchasesResponse.fromJson(dynamic json){
    if (json != null) {
      dataListList = [];
      json.forEach((v) {
        dataListList?.add(DataList.fromJson(v));
      });
    }
  }
}
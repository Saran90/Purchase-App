class Data {
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

  Data(
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

  Data.fromJson(dynamic json){
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

class GetPurchaseBillsResponse {
  String? status;
  String? message;
  List<Data>? dataList;

  GetPurchaseBillsResponse({this.status, this.message, this.dataList});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["status"] = status;
    map["message"] = message;
    if (dataList != null) {
      map["data"] = dataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  GetPurchaseBillsResponse.fromJson(dynamic json){
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      dataList = [];
      json["data"].forEach((v) {
        dataList?.add(Data.fromJson(v));
      });
    }
  }
}
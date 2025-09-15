class Data {
  num? supplierId;
  String? supplierName;

  Data({this.supplierId, this.supplierName});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["supplierId"] = supplierId;
    map["supplierName"] = supplierName;
    return map;
  }

  Data.fromJson(dynamic json){
    supplierId = json["supplierId"];
    supplierName = json["supplierName"];
  }
}

class GetSuppliersResponse {
  String? status;
  String? message;
  List<Data>? dataList;

  GetSuppliersResponse({this.status, this.message, this.dataList});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["status"] = status;
    map["message"] = message;
    if (dataList != null) {
      map["data"] = dataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  GetSuppliersResponse.fromJson(dynamic json){
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
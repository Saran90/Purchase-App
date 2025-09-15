class GetProductByBarcodeResponse {
  num? productId;
  String? productName;
  String? packing;
  num? mrp;
  String? barCode;

  GetProductByBarcodeResponse(
      {this.productId, this.productName, this.packing, this.mrp, this.barCode});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["productId"] = productId;
    map["productName"] = productName;
    map["packing"] = packing;
    map["mrp"] = mrp;
    map["barCode"] = barCode;
    return map;
  }

  GetProductByBarcodeResponse.fromJson(dynamic json){
    productId = json["productId"];
    productName = json["productName"];
    packing = json["packing"];
    mrp = json["mrp"];
    barCode = json["barCode"];
  }
}
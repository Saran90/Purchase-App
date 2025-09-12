class DeletePurchaseRequest {
  num? purchaseId;

  DeletePurchaseRequest({this.purchaseId});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["purchaseId"] = purchaseId;
    return map;
  }

  DeletePurchaseRequest.fromJson(dynamic json){
    purchaseId = json["purchaseId"];
  }
}
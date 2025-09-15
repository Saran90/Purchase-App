class AddPurchaseResponse {
  String? message;
  int? purchaseId;

  AddPurchaseResponse({this.message});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["message"] = message;
    map["purchaseId"] = purchaseId;
    return map;
  }

  AddPurchaseResponse.fromJson(dynamic json){
    message = json["message"];
    purchaseId = json["purchaseId"];
  }
}
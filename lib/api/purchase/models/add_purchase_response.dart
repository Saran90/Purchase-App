class AddPurchaseResponse {
  String? message;

  AddPurchaseResponse({this.message});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["message"] = message;
    return map;
  }

  AddPurchaseResponse.fromJson(dynamic json){
    message = json["message"];
  }
}
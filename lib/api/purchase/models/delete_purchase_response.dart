class DeletePurchaseResponse {
  String? message;

  DeletePurchaseResponse({this.message});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["message"] = message;
    return map;
  }

  DeletePurchaseResponse.fromJson(dynamic json){
    message = json["message"];
  }
}
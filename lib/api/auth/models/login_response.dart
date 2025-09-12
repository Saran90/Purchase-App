class LoginResponse {
  String? token;

  LoginResponse({this.token});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["token"] = token;
    return map;
  }

  LoginResponse.fromJson(dynamic json){
    token = json["token"];
  }
}
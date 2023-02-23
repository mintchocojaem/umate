class LoginModel{
  late String message;
  late String accessToken;
  late String refreshToken;
  late bool admin;
  late bool successful;

  LoginModel({
    accessToken,
    refreshToken,
    admin,
    successful,
    message
  });

  LoginModel.fromJson(Map<String, dynamic> json){
    accessToken = json["data"]["accessToken"] as String;
    refreshToken = json["data"]["refreshToken"] as String;
    admin = json["data"]["admin"] as bool;
    successful = json["successful"] as bool;
    message = json["message"] as String;
  }

}

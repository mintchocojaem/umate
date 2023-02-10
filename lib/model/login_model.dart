class LoginModel{
  final String message;
  final String accessToken;
  final String refreshToken;
  final bool admin;
  final bool successful;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.admin,
    required this.successful,
    required this.message
  });

  factory LoginModel.formJson(Map<String, dynamic> json){
    return LoginModel(
        accessToken: json["data"]["accessToken"] as String,
        refreshToken: json["data"]["refreshToken"] as String,
        admin: json["data"]["admin"] as bool,
        successful: json["successful"] as bool,
        message: json["message"] as String
    );
  }


}

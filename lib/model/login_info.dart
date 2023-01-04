class LoginInfo{
  final String message;
  final String accessToken;
  final String refreshToken;
  final bool admin;
  final bool successful;

  LoginInfo({
    required this.accessToken,
    required this.refreshToken,
    required this.admin,
    required this.successful,
    required this.message
  });

  factory LoginInfo.formJson(Map<String, dynamic> json){
    return LoginInfo(
        accessToken: json["data"]["accessToken"] as String,
        refreshToken: json["data"]["refreshToken"] as String,
        admin: json["data"]["admin"] as bool,
        successful: json["successful"] as bool,
        message: json["message"] as String
    );
  }


}

class TokenModel{
  String accessToken;
  String refreshToken;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json){
    return TokenModel(
      accessToken: json["accessToken"] as String,
      refreshToken: json["refreshToken"] as String,
    );
  }

}

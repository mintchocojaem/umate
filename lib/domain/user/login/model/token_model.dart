class TokenModel{
  late String accessToken;
  late String refreshToken;

  TokenModel({
    accessToken,
    refreshToken,
  });

  TokenModel.fromJson(Map<String, dynamic> json){
    accessToken = json["accessToken"] as String;
    refreshToken = json["refreshToken"] as String;
  }

}

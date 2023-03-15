import 'package:danvery/app/data/provider/sms_auth_provider.dart';

class SMSAuthRepository {
  final SMSAuthProvider smsAuthProvider;

  SMSAuthRepository({required this.smsAuthProvider});

  Future<bool> sendSMSAuth(String signupToken, String phoneNumber) async {
    return await smsAuthProvider.sendSMSAuth(signupToken, phoneNumber);
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    return await smsAuthProvider.verifySMSAuth(signupToken, code);
  }

}

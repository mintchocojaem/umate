import 'package:danvery/app/data/repository/sms_auth_repository.dart';
import 'package:get/get.dart';

class SMSAuthController extends GetxController{

  final SMSAuthRepository smsAuthRepository;

  SMSAuthController({required this.smsAuthRepository});

  Future<bool> sendSMSAuth(String signupToken , String phoneNumber) async {
    try {
      final bool isSend = await smsAuthRepository.sendSMSAuth(signupToken, phoneNumber);
      return isSend;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifySMSAuth(String signupToken, String code) async {
    try {
      final bool isVerify = await smsAuthRepository.verifySMSAuth(signupToken, code);
      return isVerify;
    } catch (e) {
      return false;
    }
  }

}

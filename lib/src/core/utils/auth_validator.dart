import '../constants/regex.dart';

mixin class AuthValidator {
  String? validateStudentId({
    String? studentId,
    bool checkRegex = true,
  }) {
    if (studentId == null || studentId.isEmpty) {
      return '학번을 입력해주세요';
    }
    if (checkRegex && !RegExp(studentIdRegex).hasMatch(studentId)) {
      return '학번은 8자리의 숫자로 이루어져요';
    }
    return null;
  }

  String? validatePassword({
    String? password,
    bool checkRegex = true,
  }) {
    if (password == null || password.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    if (checkRegex && !RegExp(passwordRegex).hasMatch(password)) {
      return '비밀번호는 8~20자의 영문, 숫자, 특수문자로 이루어져요';
    }
    return null;
  }

  String? validatePasswordConfirm({
    String? password,
    String? passwordConfirm,
  }) {
    if (password == null || password.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    if (password != passwordConfirm) {
      return '비밀번호가 일치하지 않아요';
    }
    return null;
  }

  String? validatePhoneNumber({String? phoneNumber}) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return '휴대폰 번호를 입력해주세요';
    }
    if (!RegExp(phoneNumberRegex).hasMatch(phoneNumber)) {
      return '휴대폰 번호는 010으로 시작하는 11자리의 숫자로 이루어져요';
    }
    return null;
  }

  String? validateCode({String? code}) {
    if (code == null || code.isEmpty) {
      return '인증번호를 입력해주세요';
    }
    if (!RegExp(codeRegex).hasMatch(code)) {
      return '인증번호는 6자리의 숫자로 이루어져요';
    }
    return null;
  }

  String? validateNickname({String? nickname}) {
    if (nickname == null || nickname.isEmpty) {
      return '닉네임을 입력해주세요';
    }
    if (!RegExp(nicknameRegex).hasMatch(nickname)) {
      return '닉네임은 2~16자의 한글, 영문, 숫자로 이루어져요';
    }
    return null;
  }
}

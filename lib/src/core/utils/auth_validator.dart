mixin class AuthValidator {
  String? validateStudentId({String? studentId}) {
    if (studentId == null || studentId.isEmpty) {
      return '학번을 입력해주세요';
    }
    if (studentId.length != 8) {
      return '학번은 8자리의 숫자에요';
    }
    return null;
  }

  String? validatePassword({String? password}) {
    if (password == null || password.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    return null;
  }

  String? validatePasswordConfirm({
    String? password,
    String? passwordConfirm,
  }) {
    if (passwordConfirm == null || passwordConfirm.isEmpty) {
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
    if (phoneNumber.length != 11) {
      return '휴대폰 번호는 11자리의 숫자에요';
    }
    return null;
  }

  String? validateCode({String? code}) {
    if (code == null || code.isEmpty) {
      return '인증번호를 입력해주세요';
    }
    if (code.length != 6) {
      return '인증번호는 6자리의 숫자에요';
    }
    return null;
  }

  String? validateNickname({String? nickname}) {
    if (nickname == null || nickname.isEmpty) {
      return '닉네임을 입력해주세요';
    }
    return null;
  }
}

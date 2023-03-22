// 3~16자 영문 대소문자, 한글, 숫자, 특수문자(_), 공백 조합
bool isValidNicknameFormat(String nickname) {
  return RegExp(r"^(?!.*\s{2,})[A-Za-z\dㄱ-ㅎㅏ-ㅣ가-힣_ ]{3,16}$")
      .hasMatch(nickname);
}

// 8~16자 영문 대소문자, 숫자, 특수문자(!@#$%^&*+=\-_(){}[\]:;<>,.?~) 조합
bool isValidPasswordFormat(String password) {
  return RegExp(
      r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*+=\-_(){}[\]:;<>,.?~]{8,16}$")
      .hasMatch(password);
}

//대시(-)를 포함하거나 포함하지 않는 11자리 010 휴대폰 번호
bool isValidPhoneNumberFormat(String phoneNumber) {
  return RegExp(r'^010-?\d{4}-?\d{4}$').hasMatch(phoneNumber);
}

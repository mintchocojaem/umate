// 3~16자 영문 대소문자, 한글, 숫자, 특수문자(_), 공백 조합
bool isValidNicknameFormat(String nickname) {
  return RegExp(r"^(?!.*\s{2,})[A-Za-z\dㄱ-ㅎㅏ-ㅣ가-힣_ ]{3,16}$")
      .hasMatch(nickname);
}

// 8~16자 영문 대소문자, 숫자, 특수문자 조합(숫자와 영문자는 반드시 1자 이상 필요, 특수문자, 대문자는 선택사항)
bool isValidPasswordFormat(String password) {
  return RegExp(
          r"^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z!@#$%^&*+=\-_(){}[\]:;<>,.?~]{8,16}$")
      .hasMatch(password);
}

//대시(-)를 포함하거나 포함하지 않는 11자리 010 휴대폰 번호
bool isValidPhoneNumberFormat(String phoneNumber) {
  return RegExp(r'^010-?\d{4}-?\d{4}$').hasMatch(phoneNumber);
}

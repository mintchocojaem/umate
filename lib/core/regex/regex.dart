// 3~12자, 영문, 한글, 숫자, 특수문자(_), 공백 포함
final RegExp nicknameCheckRegExp = RegExp(r"^(?!.*\s{2,})[A-Za-z\dㄱ-ㅎㅏ-ㅣ가-힣_ ]{3,12}$");

//8자 이상 24자 미만, 하나 이상의 영문자와 숫자 포함 (특수문자, 대문자는 선택사항)
final RegExp passwordCheckRegExp = RegExp(
    r"^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z!@#$%^&*+=\-_(){}\[\]:;<>,.?~]{8,24}$");

//대시(-)를 포함하거나 포함하지 않는 11자리 010 휴대폰 번호
final RegExp phoneNumberCheckRegExp = RegExp(r'^010-?\d{4}-?\d{4}$');

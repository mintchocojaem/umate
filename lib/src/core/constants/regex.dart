const String nicknameRegex = r"""^(?=[a-zA-Z가-힣]*\d*[a-zA-Z가-힣]+\d*)[a-zA-Z가-힣\d]{2,16}$""";
const String passwordRegex = r"""^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+={}\[\]:;"'<>,.?\/~`|-]{8,20}$""";
const String phoneNumberRegex = r"""^010[0-9]{8}$""";
const String studentIdRegex = r"""^[0-9]{8}$""";
const String codeRegex = r"""^[0-9]{6}$""";
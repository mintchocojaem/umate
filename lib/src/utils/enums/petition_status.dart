enum PetitionStatus{
  active('ACTIVE','청원 중'),
  waiting('WAITING','대기 중'),
  answered('ANSWERED','답변 완료'),
  expired('EXPIRED','기간 만료');

  final String value;
  final String name;

  const PetitionStatus(this.value, this.name);

}
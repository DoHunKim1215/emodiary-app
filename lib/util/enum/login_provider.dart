enum ELoginProvider {
  DEFAULT("DEFAULT", "기본 로그인"),
  KAKAO("KAKAO", "카카오"),
  GOOGLE("GOOGLE", "구글"),
  APPLE("APPLE", "애플"),
  UNKNOWN("UNKNOWN", "알 수 없음");

  const ELoginProvider(this.name, this.displayName);

  final String name;
  final String displayName;

  factory ELoginProvider.getByName(String name) {
    return ELoginProvider.values.firstWhere(
      (value) => value.name == name,
      orElse: () => ELoginProvider.DEFAULT,
    );
  }
}

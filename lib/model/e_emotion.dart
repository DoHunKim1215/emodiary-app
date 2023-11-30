enum EEmotion implements Comparable<EEmotion> {
  NONE(value: "없음"),
  BAD(value: "나쁨"),
  SOSO(value: "보통"),
  GOOD(value: "좋음");

  final String value;
  const EEmotion({required this.value});

  String get valueStr => value;

  @override
  int compareTo(EEmotion other) {
    return name.compareTo(other.name);
  }

  factory EEmotion.fromString(String value) {
    switch (value) {
      case "나쁨":
        return EEmotion.BAD;
      case "보통":
        return EEmotion.SOSO;
      case "좋음":
        return EEmotion.GOOD;
      default:
        return EEmotion.NONE;
    }
  }
}

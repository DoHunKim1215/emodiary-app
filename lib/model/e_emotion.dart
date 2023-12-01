enum EEmotion implements Comparable<EEmotion> {
  NONE(
    value: "모름",
    oneComment: "무슨 감정을 가진지 모르겠어요...",
    twoComment: "하루를 위해 일기을 기록해주세요!",
  ),
  BAD(
    value: "나쁨",
    oneComment: "기분이 안 좋은 날이 많았던 한 달이네요.",
    twoComment: "다음에는 즐거운 일들이 더 많이 일어날 거예요!",
  ),
  SOSO(
    value: "보통",
    oneComment: "무난하게 흘러가는 한 달이네요.",
    twoComment: "다음에는 어떤 즐거운 일이 생길까요?",
  ),
  GOOD(
    value: "행복",
    oneComment: "기분 좋은 날이 많은 행복한 한 달이었네요!",
    twoComment: "다음에도 좋은 일이 가득할거에요!",
  );

  final String value;
  final String oneComment;
  final String twoComment;

  const EEmotion({
    required this.value,
    required this.oneComment,
    required this.twoComment,
  });

  String get valueStr => value;
  String get oneCommentStr => oneComment;
  String get twoCommentStr => twoComment;

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

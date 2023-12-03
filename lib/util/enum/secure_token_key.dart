enum AuthToken {
  accessToken,
  refreshToken,
}

extension SecureTokenKeyExtension on AuthToken {
  String get key {
    switch (this) {
      case AuthToken.accessToken:
        return "ACCESS_TOKEN";
      case AuthToken.refreshToken:
        return "REFRESH_TOKEN";
      default:
        assert(false, "Reached On Inaccessible Default In Enum Switch");
        return "";
    }
  }
}

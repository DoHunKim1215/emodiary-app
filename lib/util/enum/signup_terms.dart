enum ESignUpTerms {
  termsOfUse,
  consentToProvidePersonalInfo,
  marketing;
}

extension ESignUpTermsExtension on ESignUpTerms {
  String get fileName {
    switch (this) {
      case ESignUpTerms.termsOfUse:
        return "terms_of_use";
      case ESignUpTerms.consentToProvidePersonalInfo:
        return "consent_to_provide_pi";
      case ESignUpTerms.marketing:
        return "marketing";
      default:
        return "";
    }
  }

  String get title {
    switch (this) {
      case ESignUpTerms.termsOfUse:
        return "이용약관";
      case ESignUpTerms.consentToProvidePersonalInfo:
        return "개인정보 처리방침";
      case ESignUpTerms.marketing:
        return "광고성 정보 수신 및 마케팅 활용";
      default:
        return "";
    }
  }

  bool get isRequired {
    switch (this) {
      case ESignUpTerms.termsOfUse:
        return true;
      case ESignUpTerms.consentToProvidePersonalInfo:
        return true;
      case ESignUpTerms.marketing:
        return false;
      default:
        return false;
    }
  }
}

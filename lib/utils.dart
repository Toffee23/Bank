
extension StringUtils on String {
  bool get isEmail {
    const String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(pattern).hasMatch(this);
  }

  bool get isNotEmail => !isEmail;

  bool get hasDigit => RegExp(r'\d').hasMatch(this);

  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(this);

  bool get hasLowercase => RegExp(r'[a-z]').hasMatch(this);

  bool get hasSpecialCharacters => RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(this);

  String get formatToPrice {
    if (isEmpty) {
      return this;
    }

    List<String> parts = split('.');
    String integerPart = parts[0].replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},');
    String result = integerPart;

    if (parts.length > 1) {
      result += '.${parts[1]}';
    }

    return result;
  }

  String get formatToString => replaceAll(',', '');
}
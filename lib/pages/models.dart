class RegisterModel {
  final String email;
  final String phoneNumber;
  final String password;

  RegisterModel({
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, String> toJson() => {
    'email': email,
    'phoneNumber': phoneNumber,
    'password': password,
  };
}

class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() => {
    'email': email,
    'password': password,
  };
}

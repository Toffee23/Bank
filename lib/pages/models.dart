class RegisterModel {
  final String email;
  final String phone;
  final String password;

  RegisterModel({
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, String> toJson() => {
    'email': email,
    'phone': phone,
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

class UserModel {
  final String id;
  final String email;
  final String phoneNumber;
  final String balance;
  final DateTime createAt;
  final DateTime updatedAt;
  final String v;

  UserModel({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.balance,
    required this.createAt,
    required this.updatedAt,
    required this.v,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'phoneNumber': phoneNumber,
    'balance': balance,
    'createAt': createAt,
    'updatedAt': updatedAt,
    'v': v,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phoneNumber: json['phone'],
      balance: json['balance'],
      createAt: DateTime.parse(json['createAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['v'],
    );
  }

}

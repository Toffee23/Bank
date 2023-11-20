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
  final int phoneNumber;
  final num balance;
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
      id: json['_id'],
      phoneNumber: json['phone'],
      email: json['email'],
      balance: json['balance'],
      createAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'].toString(),
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    int? phoneNumber,
    num? balance,
    DateTime? createAt,
    DateTime? updatedAt,
    String? v,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      balance: balance ?? this.balance,
      createAt: createAt ?? this.createAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }
}

class DepositModel {
  final int phone;
  final num amount;

  DepositModel({
    required this.phone,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'amount': amount,
  };
}

class WithdrawModel {
  final int phone;
  final num amount;

  WithdrawModel({
    required this.phone,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'amount': amount,
  };
}

class SendModel {
  final String email;
  final int receiverPhoneNumber;
  final int amount;

  SendModel({
    required this.email,
    required this.receiverPhoneNumber,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'sender_email': email,
    'reciever_phoneno': receiverPhoneNumber,
    'amount': amount,
  };
}
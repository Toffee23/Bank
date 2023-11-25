import 'package:intl/intl.dart';
import 'package:portfolio/utils.dart';

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
  final num amount;

  SendModel({
    required this.email,
    required this.receiverPhoneNumber,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'sender_email': email,
    'receiver_phone': receiverPhoneNumber,
    'amount': amount,
  };
}

class TransactionHistoryModel {
  final String id;
  final String amount;
  final DateTime timestamp;
  final String description;
  final String type;

  TransactionHistoryModel({
    required this.id,
    required this.amount,
    required this.timestamp,
    required this.description,
    required this.type,
  });

  String get date => DateFormat('dd MMMM yyyy, hh:mm a').format(timestamp);

  bool get isCredit {
    switch (type) {
      case 'deposit':
        return true;
      case 'send':
      case 'withdrawal':
        return false;
      default:
        return false;
    }
  }

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) =>
    TransactionHistoryModel(
      id: json["_id"],
      amount: json["amount"].toString().formatToPrice,
      description: json["description"],
      type: json["type"] ?? "debit",
      timestamp: DateTime.parse(json["timestamp"]),
    );
}

class Transaction {
  final String description;
  final String date;
  final String type;
  final String amount;

  Transaction({
    required this.description,
    required this.date,
    required this.type,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      description: json['description'],
      date: json['date'],
      type: json['type'],
      amount: json['amount'],
    );
  }
}
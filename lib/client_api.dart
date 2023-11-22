import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:portfolio/models.dart';

class ClientApi {
  static const String _baseUrl = 'https://bank-app01-f13d87348993.herokuapp.com';
  static const String _register = '/api/auth/register';
  static const String _login = '/api/auth/login';
  static const String _deposit = '/api/depoWith/deposit';
  static const String _withdraw = '/api/depoWith/withdraw';
  static const String _transfer = '/api/transact/transfer';
  static const String _transactionHistory = '/api/transact/transaction-history';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<dynamic> register(RegisterModel model) async {
    const String url = '$_baseUrl$_register';

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        log('Failed from server');
        return jsonDecode(response.body)['message'];
      }
    } on SocketException catch (e) {
      log('Failed due to Network issue $e');
      return RequestStatus.networkFailure;
    } catch (e) {
      log('Failed mostly from the server $e');
      return RequestStatus.unKnownError;
    }
  }

  static Future<dynamic> login(LoginModel model) async {
    const String url = "$_baseUrl$_login";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        return jsonDecode(response.body);
      }
    } on SocketException catch (e) {
      log('Failed due to Network issue $e');
      return RequestStatus.networkFailure;
    } catch (e) {
      log('Failed mostly from the server $e');
      return RequestStatus.unKnownError;
    }
  }

  static Future<dynamic> deposit(DepositModel model) async {
    const String url = "$_baseUrl$_deposit";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        return RequestStatus.success;
      } else {
        return RequestStatus.failed;
      }
    } on SocketException catch (e) {
      log('Failed due to Network issue $e');
      return RequestStatus.networkFailure;
    } catch (e) {
      log('Failed mostly from the server $e');
      return RequestStatus.unKnownError;
    }
  }

  static Future<dynamic> withdraw(WithdrawModel model) async {
    const String url = "$_baseUrl$_withdraw";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      log(response.body);
      if (response.statusCode == 200) {
        return RequestStatus.success;
      } else {
        if (jsonDecode(response.body) == "Insufficient funds") {
          return RequestStatus.insufficientFunds;
        }
        return RequestStatus.failed;
      }
    } on SocketException catch (e) {
      log('Failed due to Network issue $e');
      return RequestStatus.networkFailure;
    } catch (e) {
      log('Failed mostly from the server $e');
      return RequestStatus.unKnownError;
    }
  }

  static Future<dynamic> send(SendModel model) async {
    const String url = "$_baseUrl$_transfer";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        return RequestStatus.success;
      } else {
        if (jsonDecode(response.body) == "Insufficient balance") {
          return RequestStatus.insufficientFunds;
        }
        return RequestStatus.failed;
      }
    } on SocketException catch (e) {
      log('Failed due to Network issue $e');
      return RequestStatus.networkFailure;
    } catch (e) {
      log('Failed mostly from the server $e');
      return RequestStatus.unKnownError;
    }
  }

  static Future<dynamic> transfer(String id) async {
    final String url = "$_baseUrl$_transfer/$id";

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      log('Got response: ${response.body}');

      if (response.statusCode == 200) {
        return RequestStatus.success;
      } else {
        return jsonDecode(response.body);
      }
    } on SocketException catch (e) {
      log('Failed due to Network issue $e');
      return RequestStatus.networkFailure;
    } catch (e) {
      log('Failed mostly from the server $e');
      return RequestStatus.unKnownError;
    }
  }

  static Future<List<TransactionHistoryModel>?> transactionHistory(String id) async {
    final String url = "$_baseUrl$_transactionHistory/$id";

    try {
      final http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<TransactionHistoryModel>((json) =>
            TransactionHistoryModel.fromJson(json)).toList();
      } else {
        return null;
      }
    } on SocketException catch (e) {
      log('Failed due to Network issue $e');
      return null;
    } catch (e) {
      log('Failed mostly from the server $e');
      return null;
    }
  }
}

enum RequestStatus {
  networkFailure,
  serverError,
  unKnownError,
  success,
  failed,
  insufficientFunds
}

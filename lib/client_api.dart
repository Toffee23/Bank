import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:portfolio/models.dart';

class ClientApi {
  static const String _baseUrl =
      'https://bank-app01-f13d87348993.herokuapp.com';
  static const String _register = '/api/auth/register';
  static const String _login = '/api/auth/login';
  static const String _deposit = '/api/depoWith/deposit';
  static const String _withdraw = '/api/depoWith/withdraw';
  static const String _transfer = '/api/transact/transfer';
  static const String _transactionHistory =
      '/api/transact/transaction-history/:userId';
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
        print(response.body);
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
      log('Error Message');
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      log('Got response: ${response.body}');

      if (response.statusCode == 200) {
        print(response.body);
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

  static Future<dynamic> withdraw(WithdrawModel model) async {
    const String url = "$_baseUrl$_withdraw";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      log('Got response: ${response.body}');

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

  // static Future<dynamic> send(DepositModel model) async {
  //   const String url = "$_baseUrl$_transfer";

  //   try {
  //     final http.Response response = await http.post(
  //       Uri.parse(url),
  //       headers: headers,
  //       body: jsonEncode(model.toJson()),
  //     );

  //     log('Got response: ${response.body}');

  //     if (response.statusCode == 200) {
  //       return UserModel.fromJson(jsonDecode(response.body));
  //     } else {
  //       return jsonDecode(response.body);
  //     }
  //   } on SocketException catch (e) {
  //     log('Failed due to Network issue $e');
  //     return RequestStatus.networkFailure;
  //   } catch (e) {
  //     log('Failed mostly from the server $e');
  //     return RequestStatus.unKnownError;
  //   }
  // }

  static Future<dynamic> transfer(DepositModel model) async {
    const String url = "$_baseUrl$_transfer";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );

      log('Got response: ${response.body}');

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
}

//  static Future<dynamic> transfer(DepositModel model) async {
//     const String url = "$_baseUrl$_transactionHistory";

//     try {
//       final http.Response response = await http.get(
//         Uri.parse(url),
//         headers: headers,
//         body: jsonEncode(model.toJson()),
//       );

//       log('Got response: ${response.body}');

//       if (response.statusCode == 200) {
//         return UserModel.fromJson(jsonDecode(response.body));
//       } else {
//         return jsonDecode(response.body);
//       }
//     } on SocketException catch (e) {
//       log('Failed due to Network issue $e');
//       return RequestStatus.networkFailure;
//     } catch (e) {
//       log('Failed mostly from the server $e');
//       return RequestStatus.unKnownError;
//     }
//   }
enum RequestStatus { networkFailure, serverError, unKnownError, success }

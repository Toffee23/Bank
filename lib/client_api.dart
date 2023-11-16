import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:portfolio/pages/models.dart';

class ClientApi {
  static String baseUrl = 'https://bank-app01-f13d87348993.herokuapp.com';
  static String registerEndpoint = "/api/auth/register";
  static String loginEndpoint = "/api/auth/login";
  static String depositEndpoint = "/api/depoWith/deposit";
  static String withdrawEndpoint = "/api/depoWith/withdraw";
  static String transferEndpoint = "/api/transact/transfer";
  static String transactionHistoryEndpoint =
      "/api/transact/transaction-history/:userId";
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<dynamic> register(RegisterModel model) async {
    final String url = "$baseUrl$registerEndpoint";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );
      log(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
      return {'status': 'failed', 'message': 'Connection error'};
    }
  }

  static Future<dynamic> login(LoginModel model) async {
    final String url = "$baseUrl$loginEndpoint";

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(model.toJson()),
      );
      log(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
      return {'status': 'failed', 'message': 'Connection error'};
    }
  }
}

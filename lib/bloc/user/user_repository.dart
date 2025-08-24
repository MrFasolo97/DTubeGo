import 'dart:developer';

import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'package:ovh.fso.dtubego/res/Config/appConfigValues.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart'
    as globals;

import 'package:ovh.fso.dtubego/bloc/user/user_response_model.dart';
import 'package:ovh.fso.dtubego/utils/Avalon/growInt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:base58check/base58.dart';

abstract class UserRepository {
  Future<User?> getAccountData(
      String apiNode, String username, String applicationUser);

  Future<bool> getAccountVerificationOnline(String username);
  Future<bool> getAccountVerificationOffline(String username);

  Future<Map<String, int>> getVP(
      String apiNode, String username, String applicationUser);
  Future<int> getDTC(String apiNode, String username, String applicationUser);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User?> getAccountData(
      String apiNode, String username, String applicationUser) async {
    // if browse only mode
    if (username == "na") {
      return null;
    }

    log("Fetching user data of $username");

    try {
      final url = Uri.parse(apiNode +
          APIUrlSchema.accountDataUrl.replaceAll("##USERNAME", username));

      final response = await http.get(url);

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      if (isStatusCodeAcceptable(response.statusCode)) {
        final data = json.decode(response.body);

        if (data is List && data.isEmpty) {
          log("Empty array response - user not found");
          return null;
        }

        if (data is! Map<String, dynamic>) {
          log("Unexpected response format: ${data.runtimeType}");
          throw Exception('Unexpected response format');
        }

        final user = ApiResultModel.fromJson(data, applicationUser).user;
        return user;
      } else {
        log("Error status code: ${response.statusCode}");
        throw Exception('Wrong status code! ${response.statusCode}');
      }
    } catch (e) {
      log("Error fetching user data: $e");
      rethrow;
    }
  }

  Future<bool> getAccountVerificationOnline(String username) async {
    var response = await http.get(Uri.parse(
        AppConfig.originalDtuberCheckUrl.replaceAll("##USERNAME", username)));
    if (await isStatusCodeAcceptable(response.statusCode)) {
      bool data = await json.decode(response.body);
      return data;
    } else {
      log(response.statusCode.toString());
      throw Exception(
          'Wrong status code! ' + response.statusCode.toString() + " ");
    }
  }

  Future<bool> getAccountVerificationOffline(String username) async {
    return globals.verifiedUsers.contains(username);
  }

  Future<Map<String, int>> getVP(
      String apiNode, String username, String applicationUser) async {
    Map<String, int> currentVT = {
      "v": 0,
      "t": 0,
    };

    try {
      final url = Uri.parse(apiNode +
          APIUrlSchema.accountDataUrl.replaceAll("##USERNAME", username));

      final response = await http.get(url);

      if (isStatusCodeAcceptable(response.statusCode)) {
        final data = json.decode(response.body);

        // Handle empty response
        if (data is List && data.isEmpty) {
          return currentVT;
        }

        if (data is! Map<String, dynamic>) {
          return currentVT;
        }

        int dtcBalance = data['balance'] ?? -1;
        int vp = data['vt'] != null && data['vt']['v'] != null
            ? data['vt']['v']
            : -1;
        int vpTS =
            data['vt'] != null && data['vt']['t'] != null ? data['vt']['t'] : 0;

        final configUrl = Uri.parse(apiNode + APIUrlSchema.avalonConfig);
        final configResponse = await http.get(configUrl);

        if (isStatusCodeAcceptable(configResponse.statusCode)) {
          final configData = json.decode(configResponse.body);
          int vpGrowth = configData['vtGrowth'] ?? 0;
          currentVT = growInt(vp, vpTS, (dtcBalance / vpGrowth), 0, 0);
        }
      }
      return currentVT;
    } catch (e) {
      log("Error getting VP: $e");
      return currentVT;
    }
  }

  Future<int> getDTC(String apiNode, String username, applicationUser) async {
    try {
      final url = Uri.parse(apiNode +
          APIUrlSchema.accountDataUrl.replaceAll("##USERNAME", username));

      final response = await http.get(url);

      if (isStatusCodeAcceptable(response.statusCode)) {
        final data = json.decode(response.body);

        // Handle empty response
        if (data is List && data.isEmpty) {
          return 0;
        }

        if (data is! Map<String, dynamic>) {
          return 0;
        }

        // Use direct access instead of creating User object for better performance
        return data['balance'] ?? 0;
      }
      return 0;
    } catch (e) {
      log("Error getting DTC: $e");
      return 0;
    }
  }
}

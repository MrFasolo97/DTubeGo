import 'dart:developer';

import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'package:ovh.fso.dtubego/res/Config/appConfigValues.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;

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
    String apiNode, String username, applicationUser) async {
    // if browse only mode
    if (await username == "na") {
      username = "";
      return null;
    }
    log("Fetching user data of " + await username);
    var response = await http.get(Uri.parse(apiNode +
        APIUrlSchema.accountDataUrl.replaceAll("##USERNAME", await username)));
    if (isStatusCodeAcceptable(await response.statusCode)) {
      var data = await json.decode(response.body);
      User user = await ApiResultModel
          .fromJson(data, applicationUser)
          .user;
      return user;
    } else {
      log(response.statusCode.toString());
      throw Exception(
          'Wrong status code! ' + response.statusCode.toString() + " ");
    }
  }

  Future<bool> getAccountVerificationOnline(String username) async {
    var response = await http.get(Uri.parse(
        AppConfig.originalDtuberCheckUrl.replaceAll("##USERNAME", username)));
    if (await isStatusCodeAcceptable(response.statusCode)) {
      bool data = json.decode(response.body);
      return data;
    } else {
      log(response.statusCode.toString());
      throw Exception('Wrong status code! ' + response.statusCode.toString() + " ");
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

    int dtcBalance;
    var response = await http.get(Uri.parse(apiNode +
        APIUrlSchema.accountDataUrl.replaceAll("##USERNAME", username)));
    if (isStatusCodeAcceptable(response.statusCode)) {
      var data = json.decode(response.body);
      dtcBalance = data['balance'] != null ? data['balance'] : -1;
      int vp = data['vt']['v'] != null ? data['vt']['v'] : -1;
      int vpTS = data['vt']['t'] != null ? data['vt']['t'] : 0;

      var configResponse =
          await http.get(Uri.parse(apiNode + APIUrlSchema.avalonConfig));
      if (isStatusCodeAcceptable(await configResponse.statusCode)) {
        var configData = json.decode(configResponse.body);
        int vpGrowth = configData['vtGrowth'] != null ? configData['vtGrowth'] : 0;
        currentVT = growInt(vp, vpTS, (dtcBalance / vpGrowth), 0, 0);
      } else {
        log(configResponse.statusCode.toString());
        throw Exception('Wrong status code! ' + configResponse.statusCode.toString() + " ");
      }
    }
    return currentVT;
  }

  Future<int> getDTC(String apiNode, String username, applicationUser) async {
    int dtcBalance;
    var response = await http.get(Uri.parse(apiNode +
        APIUrlSchema.accountDataUrl.replaceAll("##USERNAME", username)));
    if (isStatusCodeAcceptable(response.statusCode)) {
      var data = json.decode(response.body);

      User user = ApiResultModel.fromJson(data, applicationUser).user;
      dtcBalance = user.balance != null ? user.balance : -1;
    } else {
      log(response.statusCode.toString());
      throw Exception('Wrong status code! ' + response.statusCode.toString() + " ");
    }


    return dtcBalance;
  }
}

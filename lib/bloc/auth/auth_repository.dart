import 'dart:developer';

import 'package:ovh.fso.dtubego/bloc/config/txTypes.dart';
import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'package:ovh.fso.dtubego/res/Config/appConfigValues.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;
import 'package:ovh.fso.dtubego/bloc/auth/auth_response_model.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/SecureStorage.dart' as sec;
import 'package:ovh.fso.dtubego/utils/Crypto/crypto_convert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AuthRepository {
  Future<bool> signOut();
  Future<bool> browseOnlyPermissions();
  Future<bool> signInWithCredentials(
      String apiNode, String username, String privateKey);
  Future<List<int>> getTxTypesForCredentials(
      String apiNode, String username, String privateKey);
  void fetchAndStoreVerifiedUsers();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  @override
  Future<bool> signOut() async {
    var deleted = await sec.deleteUsernameKey();
    if (deleted) {
      return true;
    } else {
      throw Exception();
    }
  }

  Future<bool> browseOnlyPermissions() async {
    globals.keyPermissions.clear();
    return true;
  }

  @override
  Future<bool> signInWithCredentials(
      String apiNode, String username, String privateKey) async {
    bool _keyIsValid = false;

    var pub = privToPub(privateKey);

//load user
    var response;
    try {
      response = await http
          .get(
        Uri.parse(apiNode +
            APIUrlSchema.accountDataUrl.replaceAll("##USERNAME", username)),
      )
          .catchError((e) {
        throw e;
      });
    } catch (e) {
      throw e;
    }
    if (response.statusCode == 404) {
      // username unknown
      _keyIsValid = false;
    } else {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        Auth authInformation = ApiResultModel.fromJson(data).auth;
        if (pub.toString() == authInformation.pub) {
          _keyIsValid = true;
          for (var txType in txTypes.keys) {
            globals.keyPermissions.add(txType);
          }
          log(globals.keyPermissions.join(", "));
        } else {
          for (Keys key in authInformation.keys) {
            if (key.pub == pub.toString()) {
              _keyIsValid = true;
              globals.keyPermissions = key.types;
              log(globals.keyPermissions.join(", "));
              break;
            }
          }
        }

        //check if key is enough to login

      } else {
        throw Exception();
      }
    }
    return _keyIsValid;
  }

  Future<List<int>> getTxTypesForCredentials(
      String apiNode, String username, String privateKey) async {
    bool _keyIsValid = false;

    var pub = privToPub(privateKey);

//load user
    var response;
    try {
      response = await http
          .get(
        Uri.parse(apiNode +
            APIUrlSchema.accountDataUrl.replaceAll("##USERNAME", username)),
      )
          .catchError((e) {
        return [];
      });
    } catch (e) {
      return [];
    }
    if (response.statusCode == 404) {
      // username unknown
      return [];
    } else {
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        Auth authInformation = ApiResultModel.fromJson(data).auth;
        List<int> _txTypes = [];
        if (pub.toString() == authInformation.pub) {
          for (var txType in txTypes.keys) {
            _txTypes.add(txType);
          }
        } else {
          for (Keys key in authInformation.keys) {
            if (key.pub == pub.toString()) {
              return key.types;
            }
          }
        }
        return _txTypes;
      } else {
        return [];
      }
    }
  }

  void fetchAndStoreVerifiedUsers() async {
    var response = await http.get(Uri.parse(AppConfig.originalDtuberListUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      globals.verifiedUsers = List.from(data);
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:ovh.fso.dtubego/res/Config/APINodesConfigValues.dart';
import 'package:http/http.dart' as http;

import 'dart:collection';

Future<List> getAPINodesList() async {
  List? apiNodes;
  var response = await http
      .get(Uri.parse(
          'https://raw.githubusercontent.com/dtubego/dtube/main/public/DTube_files/avalon_apis.json'))
      .timeout(Duration(milliseconds: 5000), onTimeout: () {
// timeout occurred
    return http.Response('Error', 408);
  });
  if (response.statusCode >= 400 && response.statusCode != 408) {
    log(response.statusCode.toString());
  } else if (response.statusCode == 200) {
    var _afterRequestMicroSeconds = DateTime.now().microsecondsSinceEpoch;
    log(_afterRequestMicroSeconds.toString());
// node responded
// save responsetime to list
    apiNodes = await json.decode(await response.body) as List;
    await apiNodes;
  }
  return apiNodes != null ? apiNodes : [];
}

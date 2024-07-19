import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'dart:developer' as dev;

Future<bool> isUserLinkDmcaBanned(String user, String link) async {
  var response = await http.get(Uri.parse(APIUrlSchema.dmcaCheckUrl.replaceFirst("##USERNAME", user).replaceFirst("##LINK", link)),
        headers: {
        "Content-Type": "application/json",
      });
    if (response.statusCode == 200 || response.statusCode == 304) {
      var data = json.decode(response.body);

      DmcaSingleCheck dmca = DmcaSingleCheck.fromJson(data);
      if (dmca.dmca > 0)
        dev.log(user+"/"+link +" Hidden for DMCA");
      return dmca.dmca > 0;
    } else {
      dev.log(response.body.toString());
      throw Exception();
    }
  }
class DmcaSingleCheck {
  late int dmca;

  DmcaSingleCheck({required this.dmca});

  DmcaSingleCheck.fromJson(Map<String, dynamic> json) {
    dmca = json['dmca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dmca'] = this.dmca;
    return data;
  }
}
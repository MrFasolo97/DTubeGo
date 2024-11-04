import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ovh.fso.dtubego/bloc/feed/feed_response_model.dart';
import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'dart:developer' as dev;
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart';
import 'package:ovh.fso.dtubego/res/Config/appConfigValues.dart';

class DmcaCheck {
  late List authors;
  late List ids;
  DmcaCheck() {
    this.authors = [];
    this.ids = [];
  }
  Future<List<FeedItem>> filterFeed(List<FeedItem> feed) async {
    List<FeedItem> newFeed = [];
    //try {
      //dev.log(feed.toString());
      http
        .post(Uri.parse(APIUrlSchema.dmcaFilterFeed), headers: {"content-type": "application/json"}, body: json.encode(feed))
        .then((response) async {
      dev.log(response.statusCode.toString());
      if (isStatusCodeAcceptable(response.statusCode)) {
        dev.log(response.body.toString());
        var json2 = json.decode(response.body);
        if (json2.length > 0) {
        await json2.forEach((v) {
          if (v["author"] != null && v["link"] != null) {
            newFeed.add(FeedItem.fromJson(v, applicationUsername));
          }
        });
        }
        return newFeed;
      } else {
        newFeed = []; 
      }
      return newFeed;
    });/*
    } catch(err) {
      dev.log(err.toString());
      throw "Unable to filter feed! #1";
    }*/
    return [];
    // throw "Unable to filter feed! #2";
  }

  Future<bool> isUserLinkDmcaBanned(String user, String link) async {
    if (this.authors.indexOf(user) != -1 ||
        this.ids.indexOf(user + "/" + link) != -1) {
      return true;
    }
    try {
      var response = await http.get(
          Uri.parse(APIUrlSchema.dmcaCheckUrl
              .replaceFirst("##USERNAME", user)
              .replaceFirst("##LINK", link)),
          headers: {
            "Content-Type": "application/json",
          });
      if (isStatusCodeAcceptable(response.statusCode)) {
        var data = await json.decode(response.body);
        DmcaSingleCheck dmca = await DmcaSingleCheck.fromJson(data);
        if (dmca.dmca.toInt() > 0) {
          dev.log(user + "/" + link + " Hidden for DMCA");
          if (dmca.dmca.toInt() == 2) {
            this.authors.add(user);
          } else {
            this.ids.add(user + "/" + link);
          }
          return true;
        } else {
          dev.log(user + "/" + link + " Shown (no DMCA problems)");
          return false;
        }
      } else {
        dev.log(response.body.toString());
        return false;
      }
    } catch (err) {
      dev.log(err.toString());
      return false;
    }
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

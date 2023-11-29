import 'dart:developer';

import 'package:ovh.fso.dtubego/bloc/notification/notification_response_model.dart';
import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class NotificationRepository {
  Future<List<AvalonNotification>> getNotifications(
      String apiNode, List<int> notificationTypes, String applicationUser);
}

class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<List<AvalonNotification>> getNotifications(String apiNode,
      List<int> notificationTypes, String applicationUser) async {
    // handling notification types
    var response = await http.get(Uri.parse(apiNode +
        APIUrlSchema.notificationFeedUrl
            .replaceAll("##USERNAME", applicationUser)));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      log(response.body);
      // filter here for specific notification types
      List<AvalonNotification> posts =
          ApiResultModel.fromJson(data).notifications;
      return posts;
    } else {
      throw Exception();
    }
  }
}

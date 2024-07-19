import 'package:ovh.fso.dtubego/bloc/accountHistory/accountHistory_response_model.dart';
import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AccountHistoryRepository {
  Future<List<AvalonAccountHistoryItem>> getAccountHistory(String apiNode,
      List<int> accountHistoryTypes, String applicationUser, int fromBloc);
}

class AccountHistoryRepositoryImpl implements AccountHistoryRepository {
  @override
  Future<List<AvalonAccountHistoryItem>> getAccountHistory(String apiNode,
      List<int> accountHistoryTypes, String applicationUser, fromBloc) async {
    // handling accountHistory types
    var response = await http.get(Uri.parse(apiNode +
        APIUrlSchema.accountHistoryFeedUrl
            .replaceAll("##USERNAME", applicationUser)
            .replaceAll("##FROMBLOC", fromBloc.toString())));
    if (response.statusCode == 200 || response.statusCode == 304) {
      var data = json.decode(response.body);
      // filter here for specific accountHistory types
      List<AvalonAccountHistoryItem> historyItems =
          ApiResultModel.fromJson(data).accountHistorys;
      return historyItems;
    } else {
      throw Exception();
    }
  }
}

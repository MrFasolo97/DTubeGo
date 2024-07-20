import 'dart:convert';
import 'dart:developer' as dev;
import 'package:ovh.fso.dtubego/bloc/avalonConfig/avalonConfig_response_model.dart';
import 'package:ovh.fso.dtubego/bloc/search/search_response_model.dart';
import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'package:http/http.dart' as http;
import 'package:ovh.fso.dtubego/res/Config/appConfigValues.dart';

abstract class SearchRepository {
  Future<SearchResults> getSearchResults(String searchQuery,
      String searchEntity, String apiNode, String currentUser);
}

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<SearchResults> getSearchResults(String searchQuery,
      String searchEntity, String apiNode, String currentUser) async {
    // int vpGrowth = 360000000; // Hardcoded: Todo fix and fetch from chain config ASAP!
    SearchResults results;
    var configResponse = await http.get(Uri.parse(apiNode + APIUrlSchema.avalonConfig));
    if (isStatusCodeAcceptable(configResponse.statusCode)) {
      var configData = await json.decode(configResponse.body);

      AvalonConfig conf = ApiResultModelAvalonConfig
          .fromJson(configData)
          .conf;
      int vpGrowth = conf.vtGrowth;
    String _searchURL = "";
    switch (searchEntity) {
      case "Users":
        _searchURL = APIUrlSchema.searchAccountsUrl
            .replaceAll('##SEARCHSTRING', searchQuery);
        break;
      case "Posts":
        _searchURL = APIUrlSchema.searchPostsUrl
            .replaceAll('##SEARCHSTRING', searchQuery);
        break;
      default:
    }
    var response = await http.get(Uri.parse(_searchURL));
    if (isStatusCodeAcceptable(response.statusCode)) {
      // var data = json.decode(response.data);
      var data = await json.decode(response.body);
      dev.log(data.toString());
      results = SearchResults.fromJson(data, vpGrowth, currentUser);
      return results;
      // filter here for specfic notification types
    } else {
      throw Exception();
    }
  }
  throw Exception();
}

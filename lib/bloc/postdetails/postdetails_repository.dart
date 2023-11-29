import 'package:ovh.fso.dtubego/bloc/postdetails/postdetails_response_model.dart';
import 'package:ovh.fso.dtubego/res/Config/APIUrlSchema.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class PostRepository {
  Future<Post> getPost(String apiNode, String author, String link,
      String applicationUser, bool topLevel);
}

class PostRepositoryImpl implements PostRepository {
  @override
  Future<Post> getPost(String apiNode, String author, String link,
      String applicationUser, bool topLevel) async {
    Post _post = Post(
        sId: "",
        author: "",
        link: "",
        ts: 0,
        dist: 0,
        tags: [],
        isFlaggedByUser: false);

    if (!topLevel) {
      // load exactly this post / comment
      var response = await http.get(Uri.parse(apiNode +
          APIUrlSchema.postDataUrl
              .replaceAll("##AUTHOR", author)
              .replaceAll("##LINK", link)));
      if (response.statusCode == 200) {
        var _data = json.decode(response.body);

        Post _post = ApiResultModel.fromJson(_data, applicationUser).post;

        return _post;
      } else {
        throw Exception();
      }
    } else {
      // iterate through potential comments to top level post
      String _tag = "";
      while (_tag == "") {
        var response = await http.get(Uri.parse(apiNode +
            APIUrlSchema.postDataUrl
                .replaceAll("##AUTHOR", author)
                .replaceAll("##LINK", link)));
        if (response.statusCode == 200) {
          var _data = json.decode(response.body);

          Post _post = ApiResultModel.fromJson(_data, applicationUser).post;
          _tag = _post.jsonString!.tag!;
          if (_tag == "") {
            author = _post.pa!;
            link = _post.pp!;
          } else {
            return _post;
          }
        } else {
          print("post other exception");
          throw Exception();
        }
      }
      if (_post.sId != "") {
        return _post;
      } else {
        throw Exception();
      }
    }
  }
}

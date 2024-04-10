import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:internet_tugma/network_server/model_posts.dart';
import 'package:internet_tugma/network_server/model_url.dart';

class InternetData {
  var dio = Dio();

  Future<String> getPosts() async {
    try {
      Response response = await dio.get("${ModelUrl.url}/posts");
      return jsonEncode(response.data).toString();
    } on DioException catch (e) {
      return e.response!.statusCode.toString();
    }
  }

  Future<String> getError() async {
    try {
      Response response = await dio.get("${ModelUrl.url}/posts1234");
      return jsonEncode(response.data).toString();
    } on DioException catch (e) {
      return e.response!.statusCode.toString();
    }
  }

  Future<ModelPosts> getOnePost(int id) async {
    Response response = await dio.get("${ModelUrl.url}/posts/$id");
    List<ModelPosts> list = [];
    for (var element in response.data) {
      list.add(ModelPosts.fromJosn(element));
    }
    return list[0];
  }
}

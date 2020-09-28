import 'dart:convert';
import 'package:destiny_robot/unitls/global.dart';
import 'package:dio/dio.dart';
import 'http_utils.dart';
import 'api_url.dart';
import '../models/user_info_model.dart';

class ApiService {
  //获取今日新闻
  // static Future<UserInfoMode> getOauthTokenRequest() async {
  //   Response response =
  //       await HttpUtils().request(ApiUrl.OAUTH_TOKEN_URL, method: HttpUtils.GET);
  //   if (response != null) {
  //     var responseData = jsonDecode(response.data);
  //     if (responseData == null) {
  //       return null;
  //     }
  //     // return UserInfoMode.fromJson(responseData);
  //   } else {
  //     return null;
  //   }
  // }
  static Future<UserInfoModel> getOauthTokenRequest(
      String username, String verification_code) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Basic YXBwOmFwcA=="
    }).request(
        "${ApiUrl.OAUTH_TOKEN_URL}?mobile=${username}&verification_code=${verification_code}",
        method: HttpUtils.POST);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      UserInfoModel data = UserInfoModel.fromJson(responseData["datas"]);
      return data;
    } else {
      return null;
    }
  }

//获取用户信息
  static Future<UserInfoModel> getUserInfoRequest() async {
    Response response =
        await HttpUtils(headers: {"Authorization": "Bearer ${Global.tokenModel.accessToken}"})
            .request(ApiUrl.USER_DETAIL_URL, method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      UserInfoModel data = UserInfoModel.fromJson(responseData["data"]);
      return data;
    } else {
      return null;
    }
  }
}

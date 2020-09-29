import 'dart:convert';
import 'package:destiny_robot/unitls/global.dart';
import 'package:dio/dio.dart';
import 'http_utils.dart';
import 'api_url.dart';
import '../models/user_info_model.dart';

class ApiService {
  //获取token
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
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.USER_DETAIL_URL, method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      UserInfoModel data = UserInfoModel.fromJson(responseData["data"]);
      return data;
    } else {
      return null;
    }
  }

  //修改用户个人信息
  static Future<dynamic> alterUserInfoRequest(
      Map<String, dynamic> params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.ALTER_USER_INFO_URL,
        data: params, method: HttpUtils.POST);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

  //修改用户基本信息
  static Future<dynamic> alterUserBaseInfoRequest(
      Map<String, dynamic> params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.ALTER_BASE_USER_INFO_URL,
        data: params, method: HttpUtils.POST);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

//上传图片
  static Future<dynamic> uploadImageRequest(FormData params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).uploadFile(ApiUrl.UPLOAD_IMAGE_URL, data: params);
    if (response != null) {
      var responseData = response.data;
      return responseData['data']['urls'][0] ?? null;
    } else {
      return null;
    }
  }
}

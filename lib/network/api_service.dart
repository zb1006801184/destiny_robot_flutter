import 'dart:convert';
import 'package:destiny_robot/unitls/global.dart';
import 'package:destiny_robot/unitls/toast_view.dart';
import 'package:dio/dio.dart';
import 'http_utils.dart';
import 'api_url.dart';
import '../models/user_info_model.dart';
import '../models/sift_model.dart';
import '../models/sift_list_model.dart';
import '../models/sift_user_model.dart';

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
      UserInfoModel data = UserInfoModel.fromJson(responseData["data"]);
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

//保存自我介绍
  static Future<dynamic> saveUserDetailRequest(
      Map<String, dynamic> params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.SAVE_USER_DETAIL_URL,
        data: params, method: HttpUtils.POST);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

//保存相册
  static Future<dynamic> saveAlbumRequest(Map<String, dynamic> params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.SAVE_ALUBM_URL, data: params, method: HttpUtils.POST);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

//实名认证
  static Future<dynamic> saveIDCardRequest(Map<String, dynamic> params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.SAVE_IDCARD_URL, data: params, method: HttpUtils.POST);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

//获取实名认证
  static Future<dynamic> getIDCardRequest() async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.GET_IDCARD_URL, method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

//学生认证
  static Future<dynamic> saveStudentRequest(Map<String, dynamic> params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.SAVE_STUDENT_URL, data: params, method: HttpUtils.POST);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

//获取学生认证
  static Future<dynamic> getStudentRequest() async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.SAVE_STUDENT_URL, method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

//保存匹配条件
  static Future<dynamic> saveMatchRequest(Map<String, dynamic> params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.SAVE_MATCH_URL, data: params, method: HttpUtils.POST);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      return responseData;
    } else {
      return null;
    }
  }

//获取匹配条件
  static Future<SiftModel> getMatchRequest() async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.SAVE_MATCH_URL, method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      SiftModel data;
      try {
        data = SiftModel.fromJson(responseData["data"]);
      } catch (e) {
        print(e);
      }
      return data;
    } else {
      return null;
    }
  }

//获取匹配条件
  static Future<List<SiftListModel>> getMatchListRequest() async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.GET_MATCH_LIST_URL, method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      List data = responseData['data'];
      List<SiftListModel> result = [];
      data.forEach((element) { 
        result.add(SiftListModel.fromJson(element));
      });
      return result;
    } else {
      return null;
    }
  }


  //根据匹配轨迹id获取匹配用户

static Future<List<SiftUserModel>> getMatchWithIDRequest(Map<String, dynamic> params) async {
    Response response = await HttpUtils(headers: {
      "Authorization": "Bearer ${Global.tokenModel.accessToken}"
    }).request(ApiUrl.GET_MATCH_ID_URL, data: params,method: HttpUtils.GET);
    if (response != null) {
      var responseData = jsonDecode(response.data);
      List data = responseData['data'];
      List<SiftUserModel> result = [];
      data.forEach((element) { 
        result.add(SiftUserModel.fromJson(element));
      });
      return result;
    } else {
      return null;
    }
  }
}

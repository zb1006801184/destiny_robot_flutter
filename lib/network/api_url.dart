class ApiUrl {
  static const String BASE_URL = 'http://192.168.3.200:7040';
  //登录
  static const String OAUTH_TOKEN_URL = '/api-auth/oauth/mobile/token';
  //获取用户信息
  static const String USER_DETAIL_URL = '/api-love/account_data';
  //修改用户信息
  static const String ALTER_USER_INFO_URL = '/api-love/account_data/base';
  //保存基本信息
  static const String ALTER_BASE_USER_INFO_URL =
      '/api-love/account_data/personal';
  //上传图片
  static const String UPLOAD_IMAGE_URL = '/api-user/files/uploads';
}

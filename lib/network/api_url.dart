class ApiUrl {
  static const String BASE_URL = 'http://192.168.3.200:7040';
  //登录
  static const String OAUTH_TOKEN_URL = '/api-auth/oauth/mobile/token';
  //获取用户信息
  static const String USER_DETAIL_URL = '/api-love/account_data';
  //修改个人信息
  static const String ALTER_BASE_USER_INFO_URL = '/api-love/account_data/base';
  //修改基本信息
  static const String ALTER_USER_INFO_URL = '/api-love/account_data/personal';
  //上传图片
  static const String UPLOAD_IMAGE_URL = '/api-user/files/uploads';
  //保存自我介绍
  static const String SAVE_USER_DETAIL_URL = '/api-love/account_data/details';
  //保存相册
  static const String SAVE_ALUBM_URL = '/api-love/account_data/album';
  //实名认证
  static const String SAVE_IDCARD_URL = '/api-love/account_data/identification';
  //获取实名认证
  static const String GET_IDCARD_URL = '/api-love/account_data/identification';
  //学生认证 、获取学生认证
  static const String SAVE_STUDENT_URL =
      '/api-love/account_data/student/identification';
  //保存匹配条件
  static const String SAVE_MATCH_URL = '/api-love/match/condition';
}

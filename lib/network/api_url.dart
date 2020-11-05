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
  //保存匹配条件、获取匹配条件
  static const String SAVE_MATCH_URL = '/api-love/match/condition';
  //获取匹配轨迹列表
  static const String GET_MATCH_LIST_URL = '/api-love/match/trail';
  //根据匹配轨迹id获取匹配用户
  static const String GET_MATCH_ID_URL = '/api-love/match/account';
  //去匹配 、停止匹配
  static const String GET_TOTO_MATCH_URL = '/api-love/match';
  //获取融云token
  static const String GET_RONGYUN_TOKEN_URL =
      '/api-love/account_data/rong/token';
  //获取他人信息
  static const String GET_OTHER_MESSAGE_URL = '/api-love/account_data/other';
  //我喜欢的人列表
  static const String GET_MINE_LIKE_URL = '/api-love/account_data/account_like';
  //喜欢我的人

  static const String GET_LIKE_MINE_URL = '/api-love/account_data/like_account';

}

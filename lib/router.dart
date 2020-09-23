import 'package:destiny_robot/rotues/main/home_page.dart';
import 'package:destiny_robot/rotues/mine/person_data/edit_data_page.dart';
import 'package:destiny_robot/rotues/mine/person_data/personal_base_data_page.dart';
import 'package:destiny_robot/rotues/mine/person_data/personal_data.page.dart';
import 'package:flutter/material.dart';
import 'im/pages/file_preview_page.dart';
import 'other/search_message_page.dart';

import 'im/pages/conversation_page.dart';
import 'im/pages/image_preview_page.dart';
import 'im/pages/sight/video_play_page.dart';
import 'im/pages/sight/video_record_page.dart';
import 'im/pages/webview_page.dart';

import 'other/debug_page.dart';
import 'other/message_read_page.dart';
import 'other/chat_debug_page.dart';
import 'other/chatroom_debug_page.dart';
import 'other/select_conversation_page.dart';

import 'rotues/mine/person_data/personal_data_ introduction_page.dart';
import 'rotues/mine/person_data/personal_data_album_page.dart';
import 'rotues/mine/person_like/person_like_page.dart';
import 'rotues/mine/person_author/person_author_page.dart';
import 'rotues/mine/person_author/student_author_page.dart';
import 'rotues/mine/person_sift/person_sift_page.dart';
import 'rotues/mine/mine_set/mine_set_page.dart';

final routes = {
  '/': (context) => HomePage(),
  '/conversation': (context, {arguments}) =>
      ConversationPage(arguments: arguments),
  '/image_preview': (context, {arguments}) =>
      ImagePreviewPage(message: arguments),
  '/debug': (context) => DebugPage(),
  '/video_record': (context, {arguments}) =>
      VideoRecordPage(arguments: arguments),
  '/video_play': (context, {arguments}) => VideoPlayPage(message: arguments),
  '/message_read_page': (context, {arguments}) =>
      MessageReadPage(message: arguments),
  '/file_preview': (context, {arguments}) =>
      FilePreviewPage(message: arguments),
  '/webview': (context, {arguments}) => WebViewPage(arguments: arguments),
  '/chat_debug': (context, {arguments}) => ChatDebugPage(arguments: arguments),
  '/chatroom_debug': (context, {arguments}) => ChatRoomDebugPage(),
  '/search_message': (context, {arguments}) =>
      SearchMessagePage(arguments: arguments),
  '/select_conversation_page': (context, {arguments}) =>
      SelectConversationPage(arguments: arguments),
  '/edit_data_page': (context, {arguments}) => EditDataPage(),
  '/PersonalDataPage': (context, {arguments}) => PersonalDataPage(),
  '/PersonalBaseDataPage': (context, {arguments}) => PersonalBaseDataPage(),
  '/PersonalDataIntroductionPage': (context, {arguments}) =>
      PersonalDataIntroductionPage(),
  '/PersonalDataAlbumPage': (context, {arguments}) => PersonalDataAlbumPage(),
  '/PersonLikePage': (context, {arguments}) => PersonLikePage(),
  '/PersonAuthorPages': (context, {arguments}) => PersonAuthorPages(),
  '/StudentAuthorPage': (context, {arguments}) => StudentAuthorPage(),
  '/PersonSiftPage': (context, {arguments}) => PersonSiftPage(),
  '/MineSetPage': (context, {arguments}) => MineSetPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

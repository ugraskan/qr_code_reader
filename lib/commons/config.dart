// (C) 2019 Haziran Yazılım. All rights reserved.
// Proprietary License.

import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

class Config {
  Config._();

  static const bool FORCED_TEST_PACKAGE  = true; // WATCH OUT!!!! DO NOT True this on production


  static bool IS_TEST_PACKAGE  = false;
  /* -----------  STRINGS ------------------ */
  static const String STR_APPLICATION_TITLE = "QR Kod Okuyucu";

  /* -----------  KEYS ------------------ */
  static const String KEY_SHARED_PREF_COLOR = "pref-Color";
  static const String KEY_SHARED_KEY_PREF_LOOK_N_FEEL = "pref-lookAndFeel";
  static const String KEY_SHARED_SAVED_TOKEN = "pref-savedToken";
  static const String KEY_SHARED_FIRST_RUN = "pref-firstRun";
  static const String KEY_SHARED_HAS_APPROVED_IMAGE = "pref-approvedImage";
  static const String KEY_SHARED_SHORTCUTS = "pref-shortcuts";
  static const String KEY_FILE_CACHE = "PartneraFileCacheKey";
  static const String KEY_SEARCH_HISTORY = "pref-searchHistory";
  static const String KEY_FIREBASE_TOKEN = "pref-firebaseToken";
  static const String KEY_LAST_UPDATE_SHOWN_ON = "pref-lastUpdateShownOn";
  static const String KEY_IMPORTANT_ANNOUNCEMENT = "pref-shownAnnouncement";
  static const String KEY_WORK_MODE = "pref-workMode";
  static const String KEY_NO_IMAGE = "pref-noImage";

  static const String TOKEN_GLUE = "-||-";

  /* -----------  CACHE ------------------ */
  static const Duration CACHE_MAX_TIME = Duration(hours: 1);
  static const int CACHE_MAX_ITEM = 20;

  /* -----------  DEFAULT PREFS ------------------ */
  static const String DEF_PREF_THEME_COLOR = "0XFF00518";

  // static String DEF_PREF_LOOK_AND_FEEL = 'ios';
  static String DEF_PREF_LOOK_AND_FEEL = null; // @TODO: Change it <null> before release, IN development give what you want.
  static const List<String> DEF_PREF_SHORTCUTS = ['absence', 'expense', 'lunch'];

  /* -----------  COLORS ------------------ */

  /// #white
  static const Color COLOR_WHITE = Color(0xFFFFFFFF);

  /// #black
  static const Color COLOR_BLACK = Color(0xFF000000);

  /// #dark
  static const Color COLOR_TEXT_DEFAULT_DARK = Color(0xFF242B33);

  /// #whiteTwo
  static const Color COLOR_WHITE_DIRTY = Color(0xFFD8D8D8);

  //#paleGreyThree
  static const Color COLOR_WHITE_GRAY = Color(0xFFF4F6FC);

  //white14
  static const Color COLOR_WHITE_GRAY_V2 = Color(0xFFFCFCFC);

  /// #blueyGrey
  static const Color COLOR_LIGHT_GRAY = Color(0xFF8A94A6);

  /// #slate
  static const Color COLOR_MID_GRAY = Color(0xFF3E4A59);

  /// #darkGreyBlue
  static const Color COLOR_DARK_GRAY = Color(0xFF2E384D);

  /// #bluish
  static const Color COLOR_BUTTON_POSSITIVE = Color(0xFF208DBB);

  /// #cloudyBlue
  static const Color COLOR_LIGHT_BLUE = Color(0xFFB7D0DE);

  //static const Color COLOR_YK_BLUE = Color(0xFF00518A);
  //static const Color COLOR_YK_DARK_BLUE = Color(0xFF004B6F);

  /// #oceanBlue
  static const Color COLOR_LINK_BLUE = Color(0xFF0069b3);

  /// #fadedOrange
  static const Color COLOR_YK_ORANGE = Color(0xFFF49E4C);

  /// #paleSalmon
  static const Color COLOR_LIGHT_PINK = Color(0xFFFFB296);

  static const Color COLOR_SALMON = Color(0xFFFFE5DB);

  /// #bluish
  static const Color COLOR_YK_GRADIENT_BEGIN = Color(0xFF208DBB);

  /// #waterBlue
  static const Color COLOR_YK_GRADIENT_END = Color(0xFF117BD6);

  /// #fadedOrange
  static const Color COLOR_YK_ORANGE_GRADIENT_BEGIN = Color(0xFFF49E4C);

  /// #melon
  static const Color COLOR_YK_ORANGE_GRADIENT_END = Color(0xFFFF875C);

  /// #blueyGreyTwo
  static const Color COLOR_BLUE_GRAY = Color(0xFF8798AD);

  /// #battleshipGrey
  static const Color COLOR_BLUE_GRAY_VAR_2 = Color(0xFF69707F);

  /// #paleLilac
  static const Color COLOR_PALE_LILAC = Color(0xFFE0E7EB);

  /// #fadedRed
  static const Color COLOR_FADED_RED = Color(0xFFD63649);

  /// #mediumGreen
  static const Color COLOR_MEDIUM_GREEN = Color(0xFF33AC2E);

  static const Color COLOR_ICON_BUTTON_BACK = Color(0xFFF0EFED);

  static const Color COLOR_ICON_GRAY_BLUE = Color(0xFFBCC7CE);

  static const Color COLOR_DEACTIVE_GRAY = Color(0xFFBBBBBB);

  /// #validationErrorColor

  static const Color COLOR_VALIDATION_ERROR = Color(0xFFD32F2F); //Colors.red[700];

  /* -----------  WS ------------------ */
  static const String WS_END_POINT_URL_PROD = "https://erpapimw.yurticikargo.com/erp/";
  static const String WS_END_POINT_URL_TEST = "https://erpapimwtest.yurticikargo.com/erp/";
  static const String WS_PORTAL_END_POINT_URL_PROD = "https://mobilehrcms.yurticikargo.com/rest/";
  static const String WS_PORTAL_END_POINT_URL_TEST = "https://mobilehrcmstest.yurticikargo.com/rest/";
  static const int HTTP_TIME_OUT = 60;


  static String WS_END_POINT_URL = WS_END_POINT_URL_PROD;
  static String WS_PORTAL_END_POINT_URL = WS_PORTAL_END_POINT_URL_PROD;


  static const String STORE_FRONT_URL = "https://store.yurticikargo.com"; //"http://store.partnera.com.tr/";
  static const String WS_PORTAL_API_USERNAME = "DataIntegrationService";
  static const String WS_PORTAL_API_PASSWORD = "welcome1";
  static const int WS_HTTP_TIME_OUT = 30; //20 secs
  static const bool WS_WORK_WITH_MOCK = false;
  static const int API_VERSION = 1;
  static final String WS_USER_AGENT = "Partnera-Shell/1.0: (${Platform.operatingSystem}, V: ${Platform.version})/${Platform.localeName}";
  static const int REQUEST_TOKEN_ON_LOGIN_SHOW_PROGRESS_NOTIFICATION_AFTER = 3; // 3 secs
  static const int REQUEST_TOKEN_ON_LOGIN_TIME_OUT = 10; // 10 secs
  static const int CHECK_FOR_UPDATE_ON_LOGIN_TIME_OUT = 5; // 5 secs

  static const bool ANNOUNCEMENT_DOES_NOT_SHOW_THE_SAME_POPUP_MORE_THEN_ONCE = true;


  /* -----------  PATH ------------------ */
  static const String PATH_USER_IMG = "user.jpg";

  /* -----------  Behaviour  ------------------ */
  static const int BEHAVIOUR_SEARCH_HISTORY_COUNT = 5;
  static const bool BEHAVIOUR_CHECK_FOR_UPDATES = true;
  static const Duration BEHAVIOUR_REMIND_UPDATES_ON_APP_START_IN_EVERY = Duration(days: 1);
  static const bool BEHAVIOUR_CLEAR_ALL_DATA_ON_APP_START = false; //Watch out! Do not turn it on in production. Newer!
  static const List<DeviceOrientation> SUPPORTED_SCREEN_ORIENTATIONS = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    //DeviceOrientation.landscapeLeft,
    //DeviceOrientation.landscapeRight,
  ];

  /* -----------  DEBUG ------------------ */
  static const bool DEBUG = true;
  static const bool DEBUG_OUTPUT_REQ_RES = true;

  static const Map<String, String> DEBUG_TYPE_ITEMS = {"Test":"Test", "Canlı":"Prod"};
  static const List<String> DEBUG_PHONE_UUIDS = [
      "5f1f2d8b91097b02", // ssubasi
      "b961d4390f5ca3ff", // eugraskan
      "aazzef-abcf123-132-312-311",
  ];
}

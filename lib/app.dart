// (C) 2019 Haziran Yazılım. All rights reserved.
// Proprietary License.
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_qrcode_app/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_qrcode_app/commons/config.dart';

class PartneraQRCodeApp extends StatelessWidget {
  PartneraQRCodeApp() {
    _changePlatform();
  }

  _changePlatform() {
    switch (Config.DEF_PREF_LOOK_AND_FEEL) {
      case "ios":
        if (Config.DEBUG) {
          print("Application will run as (forced: 'Cupertino App')");
        }
        changeToCupertinoPlatform();
        break;
      case "android":
        if (Config.DEBUG) {
          print("Application will run as (forced: 'Material App')");
        }
        changeToMaterialPlatform();
        break;
      default:
        Config.DEF_PREF_LOOK_AND_FEEL = Platform.operatingSystem.toLowerCase();
        if (Config.DEBUG) {
          print(
              "Application will run as it is. In this case (normal: '${Platform.operatingSystem} app')");
        }
        changeToAutoDetectPlatform();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: Config.STR_APPLICATION_TITLE,
      onGenerateRoute: (RouteSettings settings) {
        if (ROUTES[settings.name] != null) {
          return platformPageRoute(builder: (BuildContext context) {
            return ROUTES[settings.name](settings);
          });
        }
      },
    );
  }
}

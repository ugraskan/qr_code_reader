// (C) 2019 Haziran Yazılım. All rights reserved.
// Proprietary License.
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qrcode_app/app.dart';
import 'package:flutter_qrcode_app/commons/config.dart';

void main2() {
  runApp(PartneraQRCodeApp());
}

//@WATCH_OUT: removed async on main, and await FlutterCrashlytics().initialize();
// it was making black flickering on app start.
void main() {
  runApp(PartneraQRCodeApp());

}

import 'package:flutter/material.dart';
import 'package:flutter_qrcode_app/pages/home.dart';
import 'package:flutter_qrcode_app/pages/photo.dart';
import 'package:flutter_qrcode_app/pages/success.dart';


final ROUTES = {
  '/':(RouteSettings s) => HomePage(),
  '/photo':(RouteSettings s) => PhotoUploadPage(pushData: s.arguments),
  '/success': (RouteSettings s) => SuccessPage(pushData: s.arguments),
};


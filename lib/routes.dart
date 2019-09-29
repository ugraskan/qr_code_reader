import 'package:flutter/material.dart';
import 'package:flutter_qrcode_app/pages/home.dart';
import 'package:flutter_qrcode_app/pages/photo.dart';


final ROUTES = {
  '/':(RouteSettings s) => HomePage(),
  '/photo':(RouteSettings s) => PhotoUploadPage(pushData: s.arguments),
};


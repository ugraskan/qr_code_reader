import 'package:flutter_qrcode_app/utils/network_util.dart';
import 'package:flutter_qrcode_app/entities/base.dart';
import 'dart:convert' show JsonDecoder, JsonEncoder;

abstract class BaseService {
  NetworkUtil netUtil = new NetworkUtil();

  String prepare(Map<String, dynamic> inMap) {
    JsonEncoder enc = new JsonEncoder();
    return enc.convert(_prepare(inMap));
  }

  dynamic _prepare(Map<String, dynamic> inMap) {
    print('_prepare');
    Map<String, dynamic> retMap = Map();

    inMap.forEach((k, v) {
      String s = v.runtimeType.toString();
      if (s.contains("List<")) {
        retMap[k] = Map<String, dynamic>();
        int i = 0;
        v.forEach((l) {
          if (l is BaseEntity) {
            retMap[k]["$i"] = _prepare(l.toMap());
            i++;
          } else {
            throw Exception("Only one nested array i can handle. This is a @todo message");
          }
        });
      } else {
        if (v is BaseEntity) {
          retMap[k] = _prepare(v.toMap());
        } else {
          retMap[k] = v == null ? "" : v.toString();
        }
      }
    });
    return retMap;
  }
}

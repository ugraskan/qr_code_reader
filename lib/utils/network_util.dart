import 'dart:async';
import 'dart:convert';

import 'package:flutter_qrcode_app/commons/config.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url, {Map headers}) {
    //  _Metric metric = _Metric();

    print("Getting to: " + url);

    Map<String, String> postHeaders;
    if (headers != null) {
      postHeaders = Map<String, String>.from(headers);
    } else {
      postHeaders = new Map<String, String>();
    }

    // metric.start("GET", url);
    return http.get(url, headers: postHeaders).timeout(const Duration(seconds: Config.HTTP_TIME_OUT)).then((http.Response response) {
      //metric.stop(response);
      print("response.stausCode: " + response.statusCode.toString());
      if (Config.DEBUG_OUTPUT_REQ_RES) {
        print("response.body: " + response.body);
      }
      if (response.statusCode < 200 || response.statusCode >= 300 || json == null) {
        String msg = "Error while fetching data";
        if (json != null) {
          dynamic dyn = _decoder.convert(response.body);
          msg = dyn['message'];
        }
        throw new Exception(msg);
      }

      if (headers != null && headers["raw"] != null && headers['raw'] == 'true') {
        return response.body;
      }

      return _decoder.convert(response.body);
    });
  }

  Future<dynamic> post(String url, {Map headers, body}) async {
    //_Metric metric = _Metric();
    print("Posting to: " + url + " with body.length: " + body.toString().length.toString());
    dynamic postBody;
    Map<String, String> postHeaders;

    if (headers != null) {
      postHeaders = Map<String, String>.from(headers);
    } else {
      postHeaders = new Map<String, String>();
    }
    if (body != null) {
      if (body.runtimeType.toString().contains("Map<")) {
        postBody = Map<String, String>.from(body);
      } else {
        postHeaders['Content-Type'] = "application/json";
        postBody = body;
      }
    } else {
      postBody = new Map<String, String>();
    }


    if (Config.DEBUG_OUTPUT_REQ_RES) {
      print("with headers " + postHeaders.toString());
      print("with body " + postBody.toString());
    }

    // metric.start("POST", url, body: body.toString());
    return http
        .post(url, body: postBody, headers: postHeaders)
        .timeout(const Duration(seconds: Config.HTTP_TIME_OUT))
        .then((http.Response response) {
      //metric.stop(response);
      print("response.stausCode: " + response.statusCode.toString());
      if (Config.DEBUG_OUTPUT_REQ_RES) {
        print("response.body: " + response.body);
      }
      if (response.statusCode < 200 || response.statusCode >= 300 || json == null) {
        String msg = "Error while fetching data";
        if (json != null) {
          dynamic dyn = _decoder.convert(response.body);
          msg = dyn['message'];
        }
        throw new Exception(msg);
      }

      return _decoder.convert(response.body);
    });
  }
}

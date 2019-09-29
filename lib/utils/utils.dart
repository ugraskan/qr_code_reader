import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:vector_math/vector_math.dart' as VectorMath;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_qrcode_app/commons/config.dart';
import 'package:path_provider/path_provider.dart';

abstract class Utils {
  static const Map<int, String> MONTH_NAMES = {
    1: "Ocak",
    2: "Şubat",
    3: "Mart",
    4: "Nisan",
    5: "Mayıs",
    6: "Haziran",
    7: "Temmuz",
    8: "Ağustos",
    9: "Eylül",
    10: "Ekim",
    11: "Kasım",
    12: "Aralık",
  };

  static const R = 6371e3; // metres

  static String getMonthName(int monthIndex) {
    if (monthIndex < 1 || monthIndex > 12) {
      return "N/A";
    }
    return MONTH_NAMES[monthIndex];
  }

  static String _formatDurationInTextStyle(Duration t, {int stopIn}) {
    int sec = t.inSeconds;

    if (sec < 60) {
      return "Az Önce";
    }

    if (sec < 3600) {
      return t.inMinutes.toString() + " dk";
    }

    if (sec >= 3600 && sec < 86400) {
      return t.inHours.toString() + " sa";
    }
    if ((sec >= 86400 && sec < 604800) || stopIn == 604800) {
      return t.inDays.toString() + " gn";
    }

    if (sec >= 604800 && sec < 18144000) {
      return (t.inDays / 7).floor().toString() + " hf";
    }

    return (t.inDays / 30).floor().toString() + " ay";
  }

  static String formatToFbStyleDate(DateTime d) {
    DateTime now = DateTime.now();

    Duration t = now.difference(d);

    return _formatDurationInTextStyle(t);
  }

  static String formatToFbStyleDateStopInDays(Duration d) {
    return _formatDurationInTextStyle(d, stopIn: 604800);
  }









  static String formatToHourString(TimeOfDay tof) {
    return tof.hour.toString().padLeft(2, "0") + ":" + tof.minute.toString().padLeft(2, "0");
  }

  static String formatDistance(double distance) {
    if (distance < 1000) {
      return distance.round().toString() + " mt";
    }
    return (distance / 1000).toStringAsFixed(2) + " km";
  }

  /*
   * Calculate distance of two coordinates,
   * Giving an ‘as-the-crow-flies’ distance between the points (ignoring any hills they fly over, of course!).
   * @see https://www.movable-type.co.uk/scripts/latlong.html
   */
  static double calcDistance(double lat1, double lat2, double lon1, double lon2) {
    double f1 = VectorMath.radians(lat1);
    double f2 = VectorMath.radians(lat2);
    double df = VectorMath.radians(lat2 - lat1);
    double dl = VectorMath.radians(lon2 - lon1);

    double a = Math.sin(df / 2) * Math.sin(df / 2) + Math.cos(f1) * Math.cos(f2) * Math.sin(dl / 2) * Math.sin(dl / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c;
  }



  static String jsCreateFormString(String url) {
    return "var myForm = document.createElement('form'); myForm.setAttribute('action', '$url');"
        "myForm.setAttribute('method', 'post');myForm.setAttribute('hidden', 'true');";
  }

  static String jsCreateFormEndString() {
    return "document.body.appendChild(myForm);myForm.submit();";
  }

  static String jsCreateFieldString(String name, String value) {
    return "var myInput = document.createElement('input');myInput.setAttribute('type', 'text');"
        "myInput.setAttribute('name', '$name');myInput.setAttribute('value', '$value');"
        "myForm.appendChild(myInput);";
  }

  static Map<dynamic, dynamic> flipMap(Map map) {
    Map ret = Map();

    map.forEach((k, v) {
      ret[v] = k;
    });
    return ret;
  }

  static Future<File> downloadImageFromUrl(String url) async {
    HttpClient _httpClient = HttpClient();

    final Uri resolved = Uri.base.resolve(url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('HTTP request failed, statusCode: ${response?.statusCode}, $resolved');
    }
    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (bytes.lengthInBytes == 0) {
      throw Exception('NetworkImage is an empty file: $resolved');
    }

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path + "/" + DateTime.now().microsecondsSinceEpoch.toString();

    File f = File(tempPath);
    return f.writeAsBytes(bytes);
  }
}

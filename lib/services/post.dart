import 'dart:async';
import 'package:flutter_qrcode_app/services/base.dart';
import 'package:flutter_qrcode_app/entities/post.dart';

class PostXmlService extends BaseService {
  Future<XmlPostItem> postXml(String endPointUrl,String data,) async {
    print(endPointUrl);
    print(data);
    /*String body = this.prepare({
      "data": data,
    });*/
    String body=data;

    return netUtil
        .post(endPointUrl, body: body)
        .then((dynamic res) {
      if (res['status'] == "error") {
        throw new Exception(res["errorMessage"]);
      }

      return XmlPostItem.map(res);
    });
  }
  }
import 'base.dart';

class XmlPostItem extends BaseEntity {
  String status;
  String message;

  XmlPostItem.map(dynamic obj) {
    this.status = obj['status'].toString();
    this.message = obj['message'].toString();
  }

  Map<String, dynamic> toMap() {
    return {'status': this.status, 'message': this.message};
  }
}
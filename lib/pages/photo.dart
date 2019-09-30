import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_qrcode_app/commons/config.dart';
import 'package:flutter_qrcode_app/utils/document_file_formfield.dart';
import 'package:flutter_qrcode_app/themes/theme.dart';
import 'package:flutter_qrcode_app/widgets/positive_action_button.dart';
import 'package:flutter_qrcode_app/utils/dialogs.dart';
import 'package:flutter_qrcode_app/widgets/show_error_sheet.dart';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:flutter_qrcode_app/services/post.dart';

class PhotoUploadPage extends StatefulWidget {
  final List<Map> pushData;

  const PhotoUploadPage({Key key, this.pushData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  List<Map> _pushData = List();
  File _currentImage;

  @override
  void initState() {
    super.initState();
    print(widget.pushData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<HttpClientResponse> prepareXmlData() async {
    try {
      print(_currentImage);

      String encodedImage = Config.KEY_NO_IMAGE;
      _formKey.currentState.save();

      if (_currentImage == null) {
        Dialogs.alert(context, "Bilgilendirme", "Lütfen önce evrakın resmini çekiniz.");
      } else {
        if (_currentImage != null && _currentImage != "") {
          encodedImage = Base64Codec().encode(_currentImage.readAsBytesSync());
        }

        var builder = new xml.XmlBuilder();
        //builder.processing('xml', 'version="1.0" encoding="iso-8859-9"');
        builder.element('document', nest: () {
          builder.element('token', nest: widget.pushData[0]["token"]);
          builder.element('data', nest: encodedImage);
        });
        var bookshelfXml = builder.build();
        String xmlData = bookshelfXml.toString();
        print("xmlData: $xmlData");

        String _postUrl = widget.pushData[0]["decodedUrl"];

        await PostXmlService().postXml(_postUrl, xmlData).then((v) {
          _pushData.add({"message": "Evrak başarılı bir şekilde yüklenmiştir."});
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/success", (Route<dynamic> route) => false,
              arguments: _pushData);
        }).catchError((e) {
          throw e;
        }).whenComplete(() {
          print("service call complete");
          setState(() => _isLoading = false);
        });
      }
    } catch (e) {
      showErrorSheet(context: context, error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Navigator.of(context).canPop()
                    ? PlatformIconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        androidIcon: Icon(Icons.arrow_back,
                            color: Config.COLOR_MID_GRAY),
                        iosIcon: Icon(CupertinoIcons.back,
                            color: Config.COLOR_MID_GRAY),
                      )
                    : Container(),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(24, 75, 24, 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Evrak Yükle",
                                      style: AppTheme.textPageTitleDarkStyle()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              DocumentFileFormField(
                                  initialImage: _currentImage,
                                  onSaved: (e) {
                                    print("on Saved");
                                    print(e);
                                    setState(() {
                                      _currentImage = e;
                                    });
                                  }),
                              SizedBox(height: 20),
                              _currentImage == null
                                  ? Text("Evrak yüklemek için artıya basınız",
                                      style: AppTheme.textHint())
                                  : Text(
                                      "Değiştirmek için fotoğrafın üstüne basınız",
                                      style: AppTheme.textHint()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: PositiveActionButton(
                                child: Text("Evrakı Gönder",
                                    style: AppTheme.textButtonPositive()),
                                onPressed: () => prepareXmlData(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

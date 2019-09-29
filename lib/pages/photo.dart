import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_qrcode_app/commons/config.dart';
import 'package:flutter_qrcode_app/utils/document_file_formfield.dart';
import 'package:flutter_qrcode_app/utils/utils.dart';
import 'package:flutter_qrcode_app/themes/theme.dart';
import 'package:flutter_qrcode_app/widgets/positive_action_button.dart';
import 'package:flutter_qrcode_app/widgets/show_error_sheet.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoUploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  File _currentImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _uploadAndPushToHome() async {
     String encodedImage = Config.KEY_NO_IMAGE;
    _formKey.currentState.save();
    setState(() => _isLoading = true);
    if (_currentImage != null && _currentImage != "") {
       encodedImage = Base64Codec().encode(_currentImage.readAsBytesSync());
    }

     try {
       /*await UserService().changeProfileImage(encodedImage).then((v) {
         preferences.setBool(Config.KEY_SHARED_HAS_APPROVED_IMAGE, true);
        Future.delayed(Duration(seconds: 1)).then((_) {
           return Navigator.of(context).canPop()
               ? Navigator.of(context).pushNamed("/home/home")
               : Navigator.of(context).pushReplacementNamed("/home/home");
         });
       }).catchError((e) {
         throw e;
       }).whenComplete(() {
         print("service call complete");
         setState(() => _isLoading = false);
       });*/
     } catch (e) {
       showErrorSheet(context: context, error: e);
     }

     setState(() => _isLoading = false);
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
                                onPressed: () => _uploadAndPushToHome(),
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

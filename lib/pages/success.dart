import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_qrcode_app/themes/theme.dart';
import 'package:flutter_qrcode_app/utils/dialogs.dart';
import 'package:flutter_qrcode_app/widgets/positive_action_button.dart';

class SuccessPage extends StatefulWidget {
  final List<Map> pushData;

  const SuccessPage({Key key, this.pushData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                          width: 282,
                          height: 210,
                          child: new Image.asset('assets/img/successIcon.png',
                              fit: BoxFit.contain)),
                      SizedBox(height: 17),
                      Text(widget.pushData[0]["message"],
                          style: AppTheme.textMutedGray()),
                    ],
                  ),
                  SizedBox(height: 62),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: PositiveActionButton(
                            child: Text("Yenii Evrak Gönder",
                                style: AppTheme.textButtonPositive()),
                            onPressed: () {
                              return Navigator.of(context).pushReplacementNamed("/");
                            } //Navigator.of(context).pushNamed(""),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _isLoading ? Dialogs.ykIndicator(context) : Container(),
          ],
        ),
      ),
    );
  }
}

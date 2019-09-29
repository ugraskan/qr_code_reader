// (C) 2019 Haziran Yazılım. All rights reserved.
// Proprietary License.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_qrcode_app/commons/config.dart';
import 'package:flutter_qrcode_app/themes/theme.dart';
import 'package:flutter_qrcode_app/utils/image_picker_handler.dart';

const kTaskBarHeightMaterial = 50.0;
const kTaskBarHeightCupertino = 42.0;

class FloatingActionButtonItem {
  Color foreGroundColor;
  Color backGroundColor;
  final IconData icon;
  final Function func;
  final Function then;

  FloatingActionButtonItem({@required this.icon, @required this.func, this.then, this.foreGroundColor, this.backGroundColor});
}

abstract class Dialogs {

  static void showImagePickerActionSheet(
      BuildContext context, ImagePickerHandler listener,
      {hasRemoveOption = false}) {
    List<Widget> actionSheetActions = List();
    if (hasRemoveOption) {
      actionSheetActions.add(
        CupertinoActionSheetAction(
          child: Text('Kaldır'),
          onPressed: () {
            listener.removeImage();
            Navigator.pop(context);
          },
        ),
      );
    }

    actionSheetActions.addAll([
      CupertinoActionSheetAction(
        child: Text('Kameradan'),
        onPressed: () {
          listener.openCamera();
          Navigator.pop(context);
        },
      ),
      CupertinoActionSheetAction(
        child: Text('Galeriden'),
        onPressed: () {
          listener.openGallery();
          Navigator.pop(context);
        },
      ),
    ]);

    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('İşlem Seçin'),
          message: Text('Lütfen görüntü için yapılacak eylemi seçin.'),
          actions: actionSheetActions,
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Vazgeç'),
            isDefaultAction: false,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  static Future<void> alert(BuildContext context, String title, String message) async {
    title = null;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 18),
            child: Text(message, style: AppTheme.textAlertBodyGray()),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FlatButton(
                    child: Text("Tamam", style: AppTheme.textButtonPositive()),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static void confirm(BuildContext context, String title, String message, Function then) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            PlatformDialogAction(
              child: Text("Vazgeç"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            PlatformDialogAction(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
                then();
              },
            ),
          ],
        );
      },
    );
  }

  static Widget indicator(BuildContext context) {
    return new Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: const ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        Center(
          child: PlatformCircularProgressIndicator(),
        ),
      ],
    );
  }

  static Widget ykIndicator(BuildContext context) {
    return new Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: const ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        Center(
          child: Container(
            decoration:
                BoxDecoration(color: Colors.grey[50], backgroundBlendMode: BlendMode.colorDodge, borderRadius: BorderRadius.circular(25)),
            child: Image(
              filterQuality: FilterQuality.high,
              height: 100.0,
              image: AssetImage("assets/img/loader.gif"),
            ),
          ),
        ),
      ],
    );
  }

  static Widget lock() {
    return Stack(
      children: [
        new Opacity(
          opacity: 0.4,
          child: const ModalBarrier(dismissible: false, color: Colors.grey),
        ),
      ],
    );
  }

  /// Use instance  with SingleTickerProviderStateMixin
  static Widget floatingActionButtons(
      BuildContext context, AnimationController _animationController, List<FloatingActionButtonItem> items) {
    List<Widget> children = new List();

    if (items.length < 2) {
      FloatingActionButtonItem fab = items[0];
      return FloatingActionButton(
        heroTag: null,
        backgroundColor: fab.foreGroundColor ?? Theme.of(context).primaryColor,
        child: new Icon(fab.icon, color: fab.backGroundColor ?? Theme.of(context).buttonColor),
        onPressed: () {
          _animationController.reverse();
          //Navigator.pop(context);
          Navigator.push(context, new MaterialPageRoute(builder: (context) => fab.func())).then((v) {
            if (fab.then != null) {
              fab.then(v);
            }
          });
        },
      );
    }
    //when you need a menu for items :)

    for (int index = 0; index < items.length; index++) {
      FloatingActionButtonItem fab = items[index];
      Widget child = new Container(
        height: 70.0,
        width: 56.0,
        alignment: FractionalOffset.topCenter,
        child: new ScaleTransition(
          scale: new CurvedAnimation(
            parent: _animationController,
            curve: new Interval(
              0.0,
              1.0 - index / items.length / 2.0,
              curve: Curves.linear,
            ),
          ),
          child: new FloatingActionButton(
            heroTag: null,
            backgroundColor: fab.foreGroundColor,
            child: new Icon(fab.icon, color: fab.backGroundColor),
            onPressed: () {
              _animationController.reverse();
              //Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(builder: (context) => fab.func())).then((v) {
                if (fab.then != null) {
                  fab.then(v);
                }
              });
            },
          ),
        ),
      );
      children.add(child);
    }

    children.add(FloatingActionButton(
      heroTag: null,
      child: new AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return new Transform(
            transform: new Matrix4.rotationZ(_animationController.value * 0.5 * math.pi),
            alignment: FractionalOffset.center,
            child: new Icon(_animationController.isDismissed ? Icons.menu : Icons.close),
          );
        },
      ),
      onPressed: () {
        if (_animationController.isDismissed) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
    ));

    return Column(mainAxisSize: MainAxisSize.min, children: children);
  }
}

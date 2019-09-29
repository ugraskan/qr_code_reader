import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_qrcode_app/commons/config.dart';
import 'package:flutter_qrcode_app/themes/theme.dart';
import 'package:flutter_qrcode_app/exceptions/exceptions.dart';
import 'package:flutter_qrcode_app/widgets/message_with_image.dart';


Future<void> showErrorSheet({BuildContext context, dynamic error}) async {
  double popupHeight = 300;

  print('============================================================================================>Error');
  print(error is ControlledException ? "is a Controlled Exception" : "Uncontrolled Exception");
  print(error.toString());

  var stackTrace;
  try {
    if (error.stackTrace != null) {
      stackTrace = error.stackTrace;
      print("Stack Trace: \n");
      print(error.stackTrace.toString());
    }
  }
  on NoSuchMethodError {
    //skip, just does not has stack trace
  }



  print('Error<============================================================================================');


  return await showCupertinoModalPopup<dynamic>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: popupHeight,
        padding: const EdgeInsets.only(top: 7.0),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.elliptical(25, 25),
            topLeft: Radius.elliptical(25, 25),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(
            color: CupertinoColors.black,
            fontSize: 22.0,
          ),
          child: GestureDetector(
            // Blocks taps from propagating to the modal sheet and popping.
            onTap: () {},
            child: SafeArea(
              top: false,
              child: Card(
                elevation: 0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: MessageWithImage(
                        path: 'assets/img/errorIcon.png',
                        title: error.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

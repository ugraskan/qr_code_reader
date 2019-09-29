import 'package:flutter/material.dart';
import 'package:flutter_qrcode_app/commons/config.dart';

class PositiveActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color disabledColor;
  final Color bgColor;

  const PositiveActionButton({Key key, this.onPressed, this.child, this.disabledColor, this.bgColor}) : super(key: key);

  //TONOT TODO: Normally its gradient, but come'on, its a button
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      disabledColor: disabledColor,
      onPressed: onPressed,
      child: child,
      shape: StadiumBorder(),
      padding: EdgeInsets.all(18),
      color: this.bgColor == null ? Config.COLOR_BUTTON_POSSITIVE : this.bgColor,
      textColor: Config.COLOR_WHITE,
    );
  }
}

class ActionButtonWithLightBorder extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ActionButtonWithLightBorder({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: Config.COLOR_WHITE_DIRTY, style: BorderStyle.solid),
      onPressed: onPressed,
      child: child,
      shape: StadiumBorder(),
      padding: EdgeInsets.all(18),
    );
  }
}

class ActionButtonSmall extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color buttonColor;

  const ActionButtonSmall({Key key, this.onPressed, this.child, this.buttonColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      onPressed: onPressed,
      child: child,
      shape: StadiumBorder(),
      padding: EdgeInsets.all(0),
      color: buttonColor,
    );
  }
}

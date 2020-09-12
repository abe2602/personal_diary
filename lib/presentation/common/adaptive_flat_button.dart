import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_diary/presentation/common/adaptative_stateless_widget.dart';

class AdaptiveFlatButton extends AdaptiveStatelessWidget {
  const AdaptiveFlatButton({
    @required this.child,
    @required this.onPressed,
    this.width = double.maxFinite,
    this.height = 50,
    this.textColor = Colors.white,
    this.materialSplashColor,
    this.padding,
  })  : assert(child != null),
        assert(onPressed != null);

  final Widget child;
  final Function onPressed;
  final double width;
  final double height;
  final Color textColor;
  final Color materialSplashColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget buildCupertinoWidget(BuildContext context) => CupertinoButton(
        onPressed: onPressed,
        padding: padding,
        child: child,
      );

  @override
  Widget buildMaterialWidget(BuildContext context) => FlatButton(
        textColor: textColor,
        splashColor: materialSplashColor,
        onPressed: onPressed,
        padding: padding,
        child: child,
      );
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_diary/presentation/common/adaptative_stateless_widget.dart';

class AdaptiveFilledButton extends AdaptiveStatelessWidget {
  const AdaptiveFilledButton({
    @required this.child,
    @required this.onPressed,
    this.width,
    this.height = 56,
  })  : assert(child != null),
        assert(onPressed != null);

  final Widget child;
  final Function onPressed;
  final double width;
  final double height;

  @override
  Widget buildCupertinoWidget(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: CupertinoButton.filled(
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.circular(6),
          child: child,
        ),
      );

  @override
  Widget buildMaterialWidget(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: RaisedButton(
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: child,
        ),
      );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_diary/presentation/common/personal_diary_colors.dart';

import 'adaptative_stateless_widget.dart';

/// AlertDialog that renders differently depending on the platform we're
/// running on.
class AdaptiveAlertDialog extends AdaptiveStatelessWidget {
  const AdaptiveAlertDialog({
    @required this.title,
    @required this.message,
  })  : assert(title != null),
        assert(message != null);

  final String title;
  final String message;

  @override
  Widget buildCupertinoWidget(BuildContext context) => CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: PersonalDiaryColors.lightBackground,
        ),
        child: CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
        ),
      );

  @override
  Widget buildMaterialWidget(BuildContext context) => Theme(
        data: ThemeData(
          primaryColor: PersonalDiaryColors.lightBackground,
        ),
        child: AlertDialog(
          title: Text(title),
          content: Text(message),
        ),
      );
}

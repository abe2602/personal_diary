import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_diary/generated/l10n.dart';

import 'single_action_alert_dialog.dart';

class GenericErrorAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SingleActionAlertDialog(
        primaryMessage: S.of(context).genericErrorPrimaryText,
        secondaryMessage: S.of(context).genericErrorSecondaryText,
        buttonText: S.of(context).tryAgainButtonLabel,
      );
}

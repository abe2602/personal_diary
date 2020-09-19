import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_diary/presentation/common/adaptive_flat_button.dart';
import 'package:personal_diary/presentation/common/personal_diary_colors.dart';

// Dialogs used in this project are different than iOS and Android natives
// ones, so there's no need to be adaptive.
class SingleActionAlertDialog extends StatelessWidget {
  const SingleActionAlertDialog({
    @required this.primaryMessage,
    @required this.buttonText,
    this.secondaryMessage,
    this.icon,
    this.onPressed,
    this.shouldDismissOnBackPress = true,
  })  : assert(primaryMessage != null),
        assert(shouldDismissOnBackPress != null);

  final String primaryMessage;
  final String secondaryMessage;
  final String buttonText;
  final IconData icon;
  final VoidCallback onPressed;
  final bool shouldDismissOnBackPress;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => shouldDismissOnBackPress,
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
            width: 48,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Icon(
                  icon ?? Icons.error_outline,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  primaryMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    secondaryMessage ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  color: PersonalDiaryColors.iconColor,
                  height: 2,
                ),
                Container(
                  child: AdaptiveFlatButton(
                    onPressed: () {
                      onPressed?.call();
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: PersonalDiaryColors.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

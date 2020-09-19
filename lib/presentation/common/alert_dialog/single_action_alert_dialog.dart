import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_diary/presentation/common/adaptive_flat_button.dart';
import 'package:personal_diary/presentation/common/personal_diary_colors.dart';

class SingleActionAlertDialog extends StatelessWidget {
  const SingleActionAlertDialog({
    @required this.title,
    @required this.buttonText,
    this.message,
    this.icon,
    this.onPressed,
    this.shouldDismissOnBackPress = true,
  })  : assert(title != null),
        assert(shouldDismissOnBackPress != null);

  final String title;
  final String message;
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
                  title,
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
                    message ?? '',
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

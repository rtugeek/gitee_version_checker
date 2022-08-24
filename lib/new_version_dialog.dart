import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class NewVersionDialog extends StatelessWidget {
  final Widget title;
  final Widget? message;
  final String okString;
  final VoidCallback? onOkPressed;
  final VoidCallback? onCancelPressed;

  const NewVersionDialog(
      {Key? key,
      required this.title,
      required this.message,
      this.onOkPressed,
      this.onCancelPressed,
      this.okString = "确定"})
      : super(key: key);

  static show(String title, String? message,
      {VoidCallback? onOkPressed,
      VoidCallback? onCancelPressed,
      String okString = "确定"}) {
    SmartDialog.show(builder: (c) {
      return NewVersionDialog(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        message: message == null
            ? null
            : Text(message, style: const TextStyle(fontSize: 18)),
        onCancelPressed: () {
          SmartDialog.dismiss(status: SmartStatus.dialog);
          onCancelPressed?.call();
        },
        onOkPressed: () {
          onOkPressed?.call();
          SmartDialog.dismiss(status: SmartStatus.dialog);
        },
        okString: okString,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(maxHeight: 500, minWidth: 300, maxWidth: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(16)),
      child: Wrap(
        direction: Axis.vertical,
        spacing: 16,
        children: [
          title,
          if (message != null) message!,
          SizedBox(
            width: 300 - 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: onCancelPressed,
                  child: const Text(
                    "取消",
                  ),
                ),
                MaterialButton(
                  onPressed: onOkPressed,
                  child: Text(okString),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

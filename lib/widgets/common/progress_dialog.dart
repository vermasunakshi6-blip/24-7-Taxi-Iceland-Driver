import 'package:flutter/cupertino.dart';

import '../../apppackages.dart';

class ProgressDialog {
  static BuildContext? _dialogContext;

  static void show(BuildContext context,
      {String? message}) {
    if (_dialogContext != null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        return Center(
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: CupertinoActivityIndicator(),
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    final dialogContext = _dialogContext;
    if (dialogContext == null || !dialogContext.mounted) {
      _dialogContext = null;
      return;
    }
    final navigator = Navigator.of(dialogContext, rootNavigator: true);
    navigator.pop();
    _dialogContext = null;
  }
}

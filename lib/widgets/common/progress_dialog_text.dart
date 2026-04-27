import 'package:flutter/cupertino.dart';

import '../../apppackages.dart';

class ProgressDialogText {
  static void show(BuildContext context,
      {String? message}) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 150.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const CupertinoActivityIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    (message?.isNotEmpty ?? false) ? message! : AppStrings.loading,
                    style: blackBody,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

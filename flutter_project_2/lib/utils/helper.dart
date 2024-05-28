import 'package:flutter/material.dart';

enum Status { success, info, warning, error }

class Helper {
  static void showSnackbar(BuildContext context, Status status, String text) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 170,
          left: 10,
          right: 10),
      showCloseIcon: true,
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: status == Status.success
          ? Colors.green.shade700
          : status == Status.info
              ? Colors.blue
              : status == Status.warning
                  ? Colors.orange
                  : Colors.red.shade700,
      closeIconColor: Colors.white,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

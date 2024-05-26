import 'package:flutter/material.dart';

class Helper {
  static void showSnackbar(BuildContext context, bool correct, String text) {
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
      backgroundColor: correct ? Colors.green.shade700 : Colors.red.shade700,
      closeIconColor: Colors.white,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

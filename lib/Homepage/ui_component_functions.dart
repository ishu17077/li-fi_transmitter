import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool isDarkTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark ? true : false;
}

void flutterShowToast(String message,
    {Toast toastLength = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
  );
}

void summonAlertDialogBox(BuildContext context, String contents,
    {List<Widget>? actions}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(contents),
            actions: actions,
          ));
}

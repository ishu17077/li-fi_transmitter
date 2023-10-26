import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifi_transmitter/Homepage/ui_component_functions.dart';
import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> permissionCheck(BuildContext context) async {
  PermissionStatus status = await Permission.camera.status;
  if (status.isDenied) {
    // ignore: use_build_context_synchronously
    summonAlertDialogBox(
      context,
      'Please enable camera permission for this app to work.',
      actions: [
        TextButton(
            onPressed: () async {
              PermissionStatus stillStatus = await Permission.camera.request();
              if (stillStatus.isDenied ||
                  stillStatus.isPermanentlyDenied ||
                  stillStatus.isRestricted) {
                SystemNavigator.pop();
              }
            },
            child: const Text('Okay')),
        TextButton(
            onPressed: () => SystemNavigator.pop(), child: const Text('Exit'))
      ],
    );
  } else if (status.isPermanentlyDenied) {
    flutterShowToast('Please enable Camera permission in Settings',
        toastLength: Toast.LENGTH_LONG);
    openAppSettings();
  } else if (status.isRestricted) {
    // ignore: use_build_context_synchronously
    summonAlertDialogBox(
      context,
      'Please ask your organiser or family admin to grant the camera permission.',
      actions: [
        TextButton(
            onPressed: () => Permission.camera
                .request()
                .isDenied
                .then((value) => SystemNavigator.pop()),
            child: const Text('Okay')),
        TextButton(
            onPressed: () => SystemNavigator.pop(), child: const Text('Exit'))
      ],
    );
    // The OS restricts access, for example because of parental controls.
  }
  return await Permission.camera.status;
}

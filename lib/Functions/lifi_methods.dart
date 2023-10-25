import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lifi_transmitter/Functions/permission_check.dart';
import 'package:lifi_transmitter/Homepage/ui_component_functions.dart';

enum FlashLight { onn, off }

late CameraController controller;
late List<CameraDescription> cameras;
// ignore: non_constant_identifier_names
List<String> li_fi_messages = <String>[
  'Hi',
  'Hello',
  'How are you?',
  'I am fine',
  'Ok',
  'Good Morning',
  'Good Afternoon',
  'Good Evening',
  'Thank you',
  'Sorry'
];

Future<void> initializeCamera(BuildContext context) async {
  cameras = await availableCameras();
  controller =
      CameraController(cameras[0], ResolutionPreset.low, enableAudio: false);
  await controller
      .initialize()
      .onError((error, stackTrace) => permissionCheck(context));
}

Future<void> toggleFlashlight(FlashLight flashLight) async {
  if (controller.value.isInitialized) {
    if (flashLight == FlashLight.onn) {
      await controller.setFlashMode(FlashMode.torch);
    } else if (flashLight == FlashLight.off) {
      await controller.setFlashMode(FlashMode.off);
    }
  }
}

void selectedOption(String selection) {
  if (selection == 'Hi') {
    hi();
  } else if (selection == 'Hello') {
    hello();
  } else if (selection == 'How are you?') {
    howAreYou();
  } else if (selection == 'I am fine') {
    iAmFine();
  } else if (selection == 'Ok') {
    ok();
  } else if (selection == 'Good Morning') {
    goodMorning();
  } else if (selection == 'Good Afternoon') {
    goodAfternoon();
  } else if (selection == 'Good Evening') {
    goodEvening();
  } else if (selection == 'Thank you') {
    thankYou();
  } else if (selection == 'Sorry') {
    sorry();
  }
}

void hi() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 300));
  toggleFlashlight(FlashLight.off);

  flutterShowToast('Data Sent');
}

void hello() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 600));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

void howAreYou() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 800));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

void iAmFine() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 1000));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

void ok() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 1100));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

void goodMorning() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.off);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

void goodAfternoon() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 800));
  toggleFlashlight(FlashLight.off);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

void goodEvening() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.off);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.off);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

void thankYou() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 800));
  toggleFlashlight(FlashLight.off);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 800));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

void sorry() {
  flutterShowToast('Sending Data');
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 200));
  toggleFlashlight(FlashLight.off);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 200));
  toggleFlashlight(FlashLight.off);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 200));
  toggleFlashlight(FlashLight.off);
  sleep(const Duration(milliseconds: 400));
  toggleFlashlight(FlashLight.onn);
  sleep(const Duration(milliseconds: 200));
  toggleFlashlight(FlashLight.off);
  flutterShowToast('Data Sent');
}

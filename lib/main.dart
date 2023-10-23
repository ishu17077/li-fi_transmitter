// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Li-Fi Transmitter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
          primaryTextTheme:
              TextTheme(bodyLarge: TextStyle(color: Colors.white70))),
      home: MyHomePage(title: 'Li-Fi Data Transmitter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<CameraDescription> cameras;
  late CameraController _controller;
  String? dropdownValue;
  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _controller =
        CameraController(cameras[0], ResolutionPreset.low, enableAudio: false);
    await _controller.initialize().onError((error, stackTrace) {});
  }

  Future<void> toggleFlashlight(FlashLight flashLight) async {
    if (_controller.value.isInitialized) {
      if (flashLight == FlashLight.onn) {
        await _controller.setFlashMode(FlashMode.torch);
      } else if (flashLight == FlashLight.off) {
        await _controller.setFlashMode(FlashMode.off);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? darkDynamic?.onPrimary
                    .withOpacity(0.1)
                    .harmonizeWith(Colors.black) ??
                Colors.grey[850]
            : darkDynamic?.onPrimaryContainer ?? Colors.white,
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: darkDynamic?.onPrimary ?? Colors.deepPurple,

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text(
            'Li-Fi Transmitter',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 40.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDarkTheme(context)
                        ? darkDynamic?.onSurface.withOpacity(0.1) ??
                            Colors.grey.withOpacity(0.1)
                        : darkDynamic?.onPrimary.withOpacity(0.1) ??
                            Colors.white),
                child: DropdownButton<String>(
                    elevation: 20,
                    hint: const Text('Select your message'),
                    icon: const Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    enableFeedback: true,
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? darkDynamic?.primaryContainer
                                    .harmonizeWith(Colors.black) ??
                                Colors.grey[850]
                            : darkDynamic?.primary ?? Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    value: dropdownValue,
                    // dropdownColor: ,
                    items: <String>[
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
                    ]
                        .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ))
                        .toList(),
                    underline: const SizedBox(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value ?? '';
                      });
                    }),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                // shadowColor: MaterialStatePropertyAll(
                //     darkDynamic?.onPrimary.withOpacity(0.6) ??
                //         Colors.deepPurple),
                color: isDarkTheme(context)
                    ? lightDynamic?.primary ?? Colors.deepPurple
                    : darkDynamic?.primary ?? Colors.deepPurple,

                onPressed: () {
                  if (dropdownValue != null) {
                    selectedOption(dropdownValue!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please select your message!'),
                    ));
                  }
                },
                child: Text(
                  'Send',
                  style: TextStyle(
                      color: isDarkTheme(context)
                          ? lightDynamic?.onPrimary ?? Colors.white54
                          : darkDynamic?.onPrimary ?? Colors.black54),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.25),
              Image.asset(
                'images/IMG-20231022-WA0008.png',
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Made with <3 by Team Ayush',
                    style: TextStyle(
                        color: isDarkTheme(context)
                            ? lightDynamic?.onPrimary ?? Colors.white54
                            : darkDynamic?.onPrimary ?? Colors.black54),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? true : false;
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
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 300));
    toggleFlashlight(FlashLight.off);

    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void hello() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 600));
    toggleFlashlight(FlashLight.off);
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void howAreYou() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 800));
    toggleFlashlight(FlashLight.off);
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void iAmFine() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 1000));
    toggleFlashlight(FlashLight.off);
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void ok() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 1100));
    toggleFlashlight(FlashLight.off);
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void goodMorning() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 400));
    toggleFlashlight(FlashLight.off);
    sleep(const Duration(milliseconds: 400));
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 400));
    toggleFlashlight(FlashLight.off);
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void goodAfternoon() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 800));
    toggleFlashlight(FlashLight.off);
    sleep(const Duration(milliseconds: 400));
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 400));
    toggleFlashlight(FlashLight.off);
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void goodEvening() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
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
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void thankYou() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 800));
    toggleFlashlight(FlashLight.off);
    sleep(const Duration(milliseconds: 400));
    toggleFlashlight(FlashLight.onn);
    sleep(const Duration(milliseconds: 800));
    toggleFlashlight(FlashLight.off);
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }

  void sorry() {
    Fluttertoast.showToast(
      msg: "Sending Data",
      toastLength: Toast.LENGTH_SHORT,
    );
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
    Fluttertoast.showToast(
      msg: "Data Sent",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 600,
    );
  }
}

enum FlashLight { onn, off }

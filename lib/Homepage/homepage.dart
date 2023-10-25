import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:lifi_transmitter/Functions/lifi_methods.dart';
import 'package:lifi_transmitter/Functions/permission_check.dart';

import 'package:lifi_transmitter/Homepage/ui_component_functions.dart';
import 'package:permission_handler/permission_handler.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Li-Fi Transmitter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
          primaryTextTheme:
              const TextTheme(bodyLarge: TextStyle(color: Colors.white70))),
      home: const MyHomePage(title: 'Li-Fi Data Transmitter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  // ignore: use_key_in_widget_constructors
  const MyHomePage({required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? dropdownValue;
  @override
  void initState() {
    initializeCamera(context);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return Scaffold(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? darkDynamic?.onPrimary
                      .withOpacity(0.1)
                      .harmonizeWith(Colors.black) ??
                  Colors.grey[850]
              : darkDynamic?.onPrimaryContainer ?? Colors.white,
          appBar: AppBar(
            backgroundColor: darkDynamic?.onPrimary ?? Colors.deepPurple,
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
                      items: li_fi_messages
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

                  onPressed: () async {
                    if (dropdownValue != null) {
                      permissionCheck(context);
                      if (await Permission.camera.status.isGranted) {
                        selectedOption(dropdownValue!);
                      }
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
        );
      },
    );
  }
}

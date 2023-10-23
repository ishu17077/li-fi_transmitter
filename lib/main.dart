// ignore_for_file: use_key_in_widget_constructors

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
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
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => Scaffold(
        // backgroundColor: Theme.of(context).brightness == Brightness.dark
        //     ? darkDynamic?.onBackground
        //             .withOpacity(0.01)
        //             .harmonizeWith(Colors.black) ??
        //         Colors.grey[850]
        //     : darkDynamic?.onBackground ?? Colors.white,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDarkTheme(context)
                        ? darkDynamic?.onSurface.withOpacity(0.1) ??
                            Colors.grey.withOpacity(0.1)
                        : darkDynamic?.onSurface ?? Colors.white),
                child: DropdownButton<String>(
                    hint: const Text('Select your message'),
                    icon: const Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    enableFeedback: true,
                    borderRadius: BorderRadius.circular(20),
                    value: dropdownValue,
                    // dropdownColor: ,
                    items: <String>['hi', 'bye', 'sye']
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
              TextButton(
                style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(15),
                    shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return darkDynamic?.onPrimaryContainer
                                .withOpacity(0.2) ??
                            Colors.deepPurple;
                      }
                      return darkDynamic?.onPrimaryContainer.withOpacity(0.3) ??
                          Colors.deepPurple;
                    })),
                onPressed: () {},
                child: Text(
                  'Send',
                  style: TextStyle(
                      color: darkDynamic?.onPrimary ?? Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? true : false;
  }
}

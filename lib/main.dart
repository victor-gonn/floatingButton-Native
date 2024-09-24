import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('floatingButton.com/channel');

  int count = 0;

  @override
  void initState() {
    
    super.initState();

    platform.setMethodCallHandler((call) {
      if(call.method == "touch") {
        setState(() {
          count++;
        });
        
      }
      return Future.value(count);
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo native button'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$count', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50),
            ),
            ElevatedButton(
              onPressed: () {
                platform.invokeMethod('create');
              },
               child: Text('Create'),),
               ElevatedButton(
              onPressed: () {
                 platform.invokeMethod('show');
              },
               child: Text('Show'),),
               ElevatedButton(
              onPressed: () {
                 platform.invokeMethod('hide');
              },
               child: Text('Hide'),),

               ElevatedButton(
              onPressed: () {
                 platform.invokeMethod("isShowing").then((isShowing) => print(isShowing));
              },
               child: Text('isShowing'),),
          ],
        ),
      ),
    );
  }
}

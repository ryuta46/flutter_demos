import 'package:flutter/material.dart';
import 'package:flutter_demos/capture.dart';
import 'package:flutter_demos/home.dart';

void main() {
  runApp(new MaterialApp(
    home: new Home(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/capture': (BuildContext context) => new Capture(),
    },
  ));
}


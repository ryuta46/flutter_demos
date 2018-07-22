import 'package:flutter/material.dart';
import 'package:flutter_demos/camera.dart';
import 'package:flutter_demos/home.dart';

void main() {
  runApp(new MaterialApp(
    home: new Home(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/' : (BuildContext context) => new Home(),
      '/camera': (BuildContext context) => new Camera(),
    },
  ));
}


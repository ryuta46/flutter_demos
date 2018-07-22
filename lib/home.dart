import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Home"),
      ),
      body: new Center(
        child: new RaisedButton(
          child: const Text("Launch Next Screen"),
          onPressed: () {
            Navigator.of(context).pushNamed("/camera");
          },
        ),
      ),
    );
  }
}

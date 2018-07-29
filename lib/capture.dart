import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Capture extends StatefulWidget {
  @override
  _CaptureState createState() => new _CaptureState();
}

class _CaptureState extends State<Capture> {
  CameraController controller;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    (() async {
      List<CameraDescription> cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.high);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    })();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget preview;
    if (!_isReady()) {
      preview = new Container();
    } else {
      preview = new Container(
          child:
          new Center(
              child: new AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: new CameraPreview(controller))
          )
      );
    }
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: const Text("Camera"),
        ),
        body:
        new Column(
            children: <Widget>[
              preview,
              new IconButton(
                icon: new Icon(Icons.camera_alt),
                tooltip: 'Capture',
                onPressed: () { _onPressedCaptureIcon(); }
              ),
            ]
        )
    );
  }

  bool _isReady() {
    return controller != null && controller.value.isInitialized;
  }

  _onPressedCaptureIcon() {
    _takePicture().then((String filePath) {
      _showSnackBar('Picture saved to $filePath');
    }).catchError((e) {
      _showSnackBar(e);
    });
  }

  Future<String> _takePicture() async {
    if (!_isReady()) {
      throw("Camera controller is not initialized.");
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${_timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      throw("Camera is already pending.");
    }

    await controller.takePicture(filePath);

    return filePath;
  }

  String _timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}


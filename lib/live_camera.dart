import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'bounding_box.dart';
import 'camera.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';

class LiveFeed extends StatefulWidget {
  final List<CameraDescription> cameras;

  LiveFeed(this.cameras);

  @override
  _LiveFeedState createState() => _LiveFeedState();
}

class _LiveFeedState extends State<LiveFeed> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;

  initCameras() async {}

  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/eyes_float.tflite",
      labels: "assets/labels.txt",
    );
  }

  /*
  The set recognitions function assigns the values of recognitions, imageHeight and width to the variables defined here as callback
  */
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(result),
      ),
      body: Stack(
        children: <Widget>[
          CameraFeed(widget.cameras, setRecognitions),
          // BoundingBox(
          //   _recognitions == null ? [23,23] : _recognitions,
          //   math.max(_imageHeight, _imageWidth),
          //   math.min(_imageHeight, _imageWidth),
          //   screen.height,
          //   screen.width,
          // ),
        ],
      ),
    );
  }
}
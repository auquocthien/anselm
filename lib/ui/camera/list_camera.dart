import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './camera_page.dart';

class ListCamera extends StatefulWidget {
  const ListCamera({Key? key}) : super(key: key);

  @override
  State<ListCamera> createState() => _ListCameraState();
}

class _ListCameraState extends State<ListCamera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await availableCameras().then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}

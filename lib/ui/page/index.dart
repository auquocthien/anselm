import '../../route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../camera/list_camera.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    // var hei = MediaQuery.of(context).size.height;
    // var wid = MediaQuery.of(context).size.width;
    return const Scaffold(body: ListCamera());
  }
}

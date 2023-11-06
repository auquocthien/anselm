import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({Key? key, required this.cameras}) : super(key: key);
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  GoogleTranslator translator = GoogleTranslator();

  List<String> list = <String>['Vni', 'Eng'];
  String output_text = '';
  String source_text = 'xe hơi';
  String dropdownValue = "Vni";
  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void trans() {
    translator.translate(source_text, to: 'en').then((output) {
      setState(() {
        output_text = output.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _cameraController.value.isInitialized
              ? buildCameraPreview(_cameraController)
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Widget buildCameraPreview(CameraController cameraController) {
    return Column(
      children: [
        CameraPreview(cameraController),
        Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 8.0),
            child: buildDropdownLang()),
        Container(
          padding: EdgeInsets.only(left: 8.0),
          alignment: Alignment.topLeft,
          child: Text(
            output_text.toString(),
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget buildDropdownLang() {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          print(dropdownValue);
          trans();
        });
      },
      items: list.map<DropdownMenuItem<String>>((String valu) {
        return DropdownMenuItem<String>(
          value: valu,
          child: Text(
            valu,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        );
      }).toList(),
    );
  }
}

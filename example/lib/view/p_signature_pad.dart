import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class PSignaturePad extends StatefulWidget {
  PSignaturePad({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PSignaturePad> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: SfSignaturePad(
                        key: signatureGlobalKey,
                        backgroundColor: Colors.white,
                        strokeColor: Colors.black,
                        minimumStrokeWidth: 1.0,
                        maximumStrokeWidth: 4.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)))),
          ),
          Row(children: <Widget>[
            TextButton(
              child: const Text('ToImage'),
              onPressed: _handleSaveButtonPressed,
            ),
            TextButton(
              child: const Text('Clear'),
              onPressed: _handleClearButtonPressed,
            )
          ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center);
  }
}

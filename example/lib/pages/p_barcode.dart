import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class PBarcode extends StatelessWidget {
  const PBarcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 200,
      child: SfBarcodeGenerator(
        value: 'github.com/msfm2018',
        symbology: QRCode(),
        showValue: true,
      ),
    ));
  }
}

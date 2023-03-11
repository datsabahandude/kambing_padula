import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  // final controller = TextEditingController();
  String qrCode = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QR Scanner'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Scan Result'),
            const SizedBox(height: 8),
            InkWell(onTap: () {}, child: Text(qrCode)),
            ElevatedButton(
              onPressed: () => scanQRCode(),
              child: const Text('Scan'),
            )
          ]),
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', // line indicator color
          'Cancel', // cancel string
          true, // can activate flash
          ScanMode.QR // for scanning 'QR'/'Barcode' etc
          );
      if (!mounted) return;
      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed';
      Fluttertoast.showToast(
          msg: qrCode,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

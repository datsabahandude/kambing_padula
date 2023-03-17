import 'dart:io';
import 'dart:typed_data';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:kambing_padula/testing/qr_scan.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final controller = TextEditingController();
  Uint8List? bytes;
  Widget barcode() {
    return BarcodeWidget(
      barcode: Barcode.qrCode(),
      color: Colors.black,
      data: controller.text,
      width: 200,
      height: 200,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cField = TextFormField(
        autofocus: false,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          controller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            hintText: "..."));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QR Code'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QRScanPage()));
              },
              child: Row(
                children: const [
                  Text('QR Scan'),
                  Icon(Icons.arrow_right_sharp)
                ],
              ))
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  barcode(),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(child: cField),
                      const SizedBox(width: 12),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {});
                        },
                        backgroundColor: const Color.fromRGBO(39, 55, 144, 1),
                        child: const Icon(Icons.generating_tokens_rounded),
                      )
                    ],
                  ),
                  controller.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                              clipBehavior: Clip.antiAlias,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(39, 55, 144, 1),
                              child: MaterialButton(
                                onPressed: () async {
                                  final qrCtrl = ScreenshotController();
                                  final bytes =
                                      await qrCtrl.captureFromWidget(barcode());
                                  setState(() {
                                    this.bytes = bytes;
                                  });
                                  saveImg(bytes);
                                },
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.6,
                                child: const Text(
                                  'Download QR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                        )
                      : Container(),
                ],
              ))),
    );
  }

  Future saveImg(Uint8List bytes) async {
    final appStorage = (await getApplicationDocumentsDirectory()).path;
    final file = File('$appStorage/image.png');
    file.writeAsBytes(bytes);
    try {
      await GallerySaver.saveImage(file.path, albumName: 'Flutter');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Downloaded to Gallery')));
    } catch (e) {
      print(e);
    }
  }
}

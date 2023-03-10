import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:kambing_padula/testing/qr_scan.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cField = TextFormField(
        autofocus: false,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Nama Kambing ?';
          }
        },
        onSaved: (value) {
          controller.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: const TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w700,
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.paste_outlined, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "...",
            hintStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.deepPurple,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
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
                children: [Text('QR Scan'), Icon(Icons.arrow_right_sharp)],
              ))
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    color: Colors.black,
                    data: controller.text ?? 'Hello World',
                    width: 200,
                    height: 200,
                  ),
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
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(Icons.done),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}

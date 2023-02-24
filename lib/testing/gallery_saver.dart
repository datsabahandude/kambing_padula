import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class gallerySaver extends StatefulWidget {
  const gallerySaver({super.key});

  @override
  State<gallerySaver> createState() => _gallerySaverState();
}

class _gallerySaverState extends State<gallerySaver> {
  File? image;
  Uint8List? imageBytes;
  Future _pickCamera() async {
    try {
      /// set imageQuality: 1-100
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 25);
      if (image == null) return;
      Uint8List imageBytes = await image.readAsBytes();
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        this.imageBytes = imageBytes;
      });
    } on PlatformException catch (e) {}
    Navigator.of(context).pop();
  }

  Future _pickGallery() async {
    try {
      /// set imageQuality: 1-100
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
      if (image == null) return;
      Uint8List imageBytes = await image.readAsBytes();
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        this.imageBytes = imageBytes;
      });
    } on PlatformException catch (e) {}
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Compress Image",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                // color: Colors.lightGreenAccent,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        color: Colors.amber[50],
        child: Center(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () async {
                      /// alternatively look into Dio package if download image not working
                      /// toDcim: true // if want inside camera folder
                      try {
                        await GallerySaver.saveImage(image!.path,
                            albumName: 'Flutter');
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Downloaded to Gallery')));
                      } on PlatformException catch (e) {}
                    },
                    // alignment: const AlignmentDirectional(0, 0),
                    child: imageBytes != null
                        ? Image.memory(
                            imageBytes!,
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            fit: BoxFit.cover,
                          )
                        : image != null
                            ? Image.file(
                                image!,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                fit: BoxFit.cover,
                              )
                            : Image(
                                image: const AssetImage(
                                    'assets/images/kambir.jpg'),
                                width: MediaQuery.of(context).size.width,
                                // height: 300,
                                fit: BoxFit.cover,
                              )),
                SizedBox(
                  height: 20,
                  child: imageBytes != null
                      ? Text(
                          'Memory size: ${((imageBytes!.lengthInBytes / 1024) / 1024).toStringAsFixed(3)} MB (Quality 25%)')
                      : const Text('Waiting for image...'),
                ),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(119, 204, 255, 1),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Please Choose'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        InkWell(
                          onTap: _pickCamera,
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.camera_alt),
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: _pickGallery,
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.image_rounded),
                              ),
                              Text(
                                'Gallery',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}

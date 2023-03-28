import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'models/kambing.dart';

class KambingDialog extends StatefulWidget {
  final Kambing? kambing;
  final Function(Uint8List imageBytes, DateTime datenow, String name,
      String price, String gender) onClickedDone;
  const KambingDialog({
    Key? key,
    this.kambing,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  State<KambingDialog> createState() => _KambingDialogState();
}

class _KambingDialogState extends State<KambingDialog>
    with SingleTickerProviderStateMixin {
  _KambingDialogState() {
    _selectedVal = jantina[0];
  }
  final _formKey = GlobalKey<FormState>();
  final jantina = ['Jantan', 'Betina', 'LGBTQ'];
  String? _selectedVal = '';
  DateTime datenow = DateTime.now();
  String umur = '';
  final namaEditingController = TextEditingController();
  final hargaEditingController = TextEditingController();
  File? image;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();

    if (widget.kambing != null) {
      final kambing = widget.kambing!;

      imageBytes = kambing.imageBytes;
      datenow = kambing.date;
      namaEditingController.text = kambing.name;
      hargaEditingController.text = kambing.price;
      _selectedVal = kambing.gender;
    }
  }

  @override
  void dispose() {
    namaEditingController.dispose();
    hargaEditingController.dispose();
    super.dispose();
  }

  Future _pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      Uint8List imageBytes = await image.readAsBytes();
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        this.imageBytes = imageBytes;
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    Navigator.of(context).pop();
  }

  Future _pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      Uint8List imageBytes = await image.readAsBytes();
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        this.imageBytes = imageBytes;
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final namaField = TextFormField(
        autofocus: false,
        controller: namaEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Nama Kambing ?';
          }
        },
        onSaved: (value) {
          namaEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.paste_outlined, color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Nama Kambing",
            hintStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.deepPurple,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final hargaField = TextFormField(
        autofocus: false,
        controller: hargaEditingController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Harga jual?';
          }
        },
        onSaved: (value) {
          hargaEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.monetization_on_outlined,
                color: Colors.purple),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Harga Kambing",
            hintStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.deepPurple,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final isEditing = widget.kambing != null;
    final title = isEditing ? 'Ubah Maklumat' : 'Tambah Kambing Baru';
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(),
        ),
      ),
      content: SingleChildScrollView(
        // padding: EdgeInsets.all(15.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: imageBytes != null
                          ? ClipOval(
                              child: Image.memory(
                                imageBytes!,
                                width: 180,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            )
                          : image != null
                              ? ClipOval(
                                  child: Image.file(
                                    image!,
                                    width: 180,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/kambir.jpg"),
                                  backgroundColor: Colors.transparent,
                                  radius: 100),
                    ),
                    Positioned(
                      top: 130,
                      left: 130,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text(
                                      'Sila Pilih',
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepPurple,
                                      )),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            splashColor: Colors.purple,
                                            onTap: _pickImageCamera,
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                                Text(
                                                  'Kamera',
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.deepPurple,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.purple,
                                            onTap: _pickImageGallery,
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.image_outlined,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                                Text(
                                                  'Album',
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 20,
                                                              color: Colors
                                                                  .deepPurple,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              });
                        },
                        child: const Icon(Icons.add_a_photo_outlined,
                            color: Color(0xff360c72)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    String mm = '', yy = '';
                    DateTime? newdate = await showDatePicker(
                      context: context,
                      initialDate: datenow,
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                    );
                    if (newdate == null) return;
                    // TTT
                    if ((DateTime.now().day >= newdate.day) &&
                        (DateTime.now().month >= newdate.month) &&
                        DateTime.now().year >= newdate.year) {
                      yy = '${DateTime.now().year - newdate.year}';
                      mm = '${DateTime.now().month - newdate.month}';
                    }
                    //TFT
                    else if ((DateTime.now().day >= newdate.day) &&
                        (DateTime.now().month < newdate.month) &&
                        DateTime.now().year >= newdate.year) {
                      if (DateTime.now().year == newdate.year) {
                        return;
                      }
                      yy = '${DateTime.now().year - newdate.year - 1}';
                      mm = '${DateTime.now().month - newdate.month + 12}';
                    }
                    //FTT
                    else if ((DateTime.now().day < newdate.day) &&
                        (DateTime.now().month >= newdate.month) &&
                        DateTime.now().year >= newdate.year) {
                      if (DateTime.now().year == newdate.year &&
                          DateTime.now().day < newdate.day) {
                        return;
                      }
                      if (DateTime.now().month == newdate.month &&
                          DateTime.now().year != newdate.year) {
                        yy = '${DateTime.now().year - newdate.year - 1}';
                        mm = '${DateTime.now().month - newdate.month + 11}';
                      } else if (DateTime.now().month == newdate.month) {
                        yy = '${DateTime.now().year - newdate.year}';
                        mm = '${DateTime.now().month - newdate.month}';
                      } else {
                        yy = '${DateTime.now().year - newdate.year}';
                        mm = '${DateTime.now().month - newdate.month - 1}';
                      }
                    }
                    //FFT
                    else if ((DateTime.now().day < newdate.day) &&
                        (DateTime.now().month < newdate.month) &&
                        DateTime.now().year >= newdate.year) {
                      if (DateTime.now().year == newdate.year) {
                        return;
                      }
                      yy = '${DateTime.now().year - newdate.year - 1}';
                      mm = '${DateTime.now().month - newdate.month + 11}';
                    } else {
                      return;
                    }
                    setState(() => datenow = newdate);
                    umur = '$yy Tahun $mm Bulan';
                  },
                  icon: const Icon(Icons.cake_outlined, color: Colors.purple),
                  label: Text(
                    '${datenow.day}/${datenow.month}/${datenow.year}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.av_timer, color: Colors.purple),
                  label: Text(
                    'Umur: $umur',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.deepPurple, fontSize: 14),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                namaField,
                const SizedBox(
                  height: 15.0,
                ),
                hargaField,
                const SizedBox(
                  height: 15.0,
                ),
                DropdownButtonFormField(
                  value: _selectedVal,
                  items: jantina
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          )))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedVal = val as String;
                    });
                  },
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    prefixIcon: _selectedVal == 'Jantan'
                        ? const Icon(
                            Icons.male_outlined,
                            color: Colors.blue,
                          )
                        : _selectedVal == 'Betina'
                            ? const Icon(
                                Icons.female_outlined,
                                color: Colors.pink,
                              )
                            : const Icon(Icons.transgender_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();
                      if ((isValid && image != null) ||
                          (isValid && imageBytes != null)) {
                        final img = imageBytes!;
                        final nama = namaEditingController.text;
                        final harga = hargaEditingController.text;
                        final g = _selectedVal!;
                        widget.onClickedDone(img, datenow, nama, harga, g);
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: "Daftar Berjaya!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.deepPurple,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if ((image == null) && (imageBytes == null)) {
                        Fluttertoast.showToast(
                            msg: "Mana Gambarnya?",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      "Daftar Kambing",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff360c72),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

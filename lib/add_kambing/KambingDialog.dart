import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'kambing.dart';

class KambingDialog extends StatefulWidget {
  final Kambing? kambing;
  final Function(Uint8List imageBytes, DateTime datenow, String umur, String name, String price, String gender) onClickedDone;
  const KambingDialog({
    Key? key,
    this.kambing,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  State<KambingDialog> createState() => _KambingDialogState();
}

class _KambingDialogState extends State<KambingDialog> with SingleTickerProviderStateMixin{
  _KambingDialogState(){
    _selectedVal = jantina[0];
  }
  final _formKey = GlobalKey<FormState>();
  final jantina = ['Jantan','Betina','LGBTQ'];
  String? _selectedVal = '';
  DateTime datenow = DateTime.now();
  String umur = '';
  final namaEditingController = new TextEditingController();
  final hargaEditingController = new TextEditingController();
  File? image;
  Uint8List? imageBytes;

  bool isExpense = true;

  @override
  void initState() {
    super.initState();

    if (widget.kambing != null) {
      final kambing = widget.kambing!;

      imageBytes = kambing.imageBytes;
      datenow = kambing.date;
      umur = kambing.age;
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

  Future _pickImageCamera() async{
    try{
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      Uint8List imageBytes = await image.readAsBytes();
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        this.imageBytes = imageBytes;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Navigator.of(context).pop();
  }
  Future _pickImageGallery() async{
    try{
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      Uint8List imageBytes = await image.readAsBytes();
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        this.imageBytes = imageBytes;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
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
        onSaved: (value){
          namaEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.yellow,
                fontWeight: FontWeight.w700,
              ),),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.paste_outlined, color: Colors.purple),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Nama Kambing",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ));
    final hargaField = TextFormField(
        autofocus: false,
        controller: hargaEditingController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Harga jual?';
          }
        },
        onSaved: (value){
          hargaEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 12.0,
                color: Colors.yellow,
                fontWeight: FontWeight.w700,
              ),),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.monetization_on_outlined, color: Colors.purple),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Harga Kambing",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ));
    final isEditing = widget.kambing != null;
    final title = isEditing ? 'Ubah Maklumat' : 'Tambah Kambing Baru';
    return AlertDialog(
      title: Text(title, style: GoogleFonts.poppins(
        textStyle: TextStyle(),),),
      content: SingleChildScrollView(
        // padding: EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: image != null ? ClipOval(child: Image.file(
                        image!,
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                      ) : CircleAvatar(
                          backgroundImage: AssetImage("images/kambir.jpg"),
                          backgroundColor: Colors.transparent,
                          radius: 100),
                    ),
                    Positioned(
                      top: 130,
                      left: 130,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: Colors.white,
                        child: Icon(Icons.add_a_photo_outlined, color: Color(0xff360c72)),
                        padding: EdgeInsets.all(15),
                        shape: CircleBorder(),
                        onPressed: (){
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(title: Text('Sila Pilih',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepPurple,
                                  )
                              ),),
                                content: SingleChildScrollView(
                                  child: ListBody(children: [
                                    InkWell(splashColor: Colors.purple,
                                      onTap: _pickImageCamera,
                                      child: Row(
                                        children: [
                                          Padding(padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.camera_alt, color: Colors.deepPurple,),
                                          ),
                                          Text('Kamera', style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.deepPurple,
                                                fontWeight: FontWeight.w500,
                                              )
                                          ),)
                                        ],
                                      ),
                                    ),
                                    InkWell(splashColor: Colors.greenAccent,
                                      onTap: _pickImageGallery,
                                      child: Row(
                                        children: [
                                          Padding(padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.image_outlined, color: Colors.deepPurple,),
                                          ),
                                          Text('Album', style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.deepPurple,
                                                  fontWeight: FontWeight.w500
                                              )
                                          ),)
                                        ],
                                      ),
                                    )
                                  ],),
                                )
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                ElevatedButton.icon(
                  onPressed: () async{
                    DateTime? newdate = await showDatePicker(
                      context: context,
                      initialDate: datenow,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (newdate == null) return;
                    setState(() => datenow = newdate);
                    umur = '${DateTime.now().year-datenow.year} tahun ${DateTime.now().month-datenow.month} bulan';
                  },
                  icon: Icon(Icons.cake_outlined, color: Colors.purple),
                  label: Text('${datenow.day}/${datenow.month}/${datenow.year}',
                    style: GoogleFonts.poppins(
                    textStyle: TextStyle(),),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => umur = '${DateTime.now().year-datenow.year} tahun ${DateTime.now().month-datenow.month} bulan');
                  },
                  icon: Icon(Icons.av_timer, color: Colors.purple),
                  label: Text('Umur: '+ umur,
                    style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 14
                    ),),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                ),
                SizedBox(height: 10.0,),
                namaField, SizedBox(height: 15.0,),
                hargaField, SizedBox(height: 15.0,),
                DropdownButtonFormField(
                  value: _selectedVal,
                  items: jantina.map(
                          (e)=> DropdownMenuItem(child: Text(e), value: e)
                  ).toList(),
                  onChanged: (val){
                    setState(() {
                      _selectedVal = val as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white,
                  ),
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    prefixIcon: _selectedVal == 'Jantan' ? Icon(Icons.male_outlined, color: Colors.blue,)
                        : _selectedVal == 'Betina' ? Icon(Icons.female_outlined, color: Colors.pink,)
                        : Icon(Icons.transgender_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width * 0.6,
                      onPressed:() async {
                        final isValid = _formKey.currentState!.validate();
                        if (isValid && image != null) {
                          final img = imageBytes!;
                          final nama = namaEditingController.text;
                          final harga = hargaEditingController.text;
                          final g = _selectedVal!;
                          widget.onClickedDone(img, datenow, umur, nama, harga, g);
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(
                              msg: "Daftar Berjaya!", toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.black87,
                              fontSize: 16.0);
                        }
                        else if (image == null){
                          Fluttertoast.showToast(
                              msg: "Mana Gambarnya?", toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Text(
                        "Daftar Kambing",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Color(0xff360c72),
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        // buildCancelButton(context),
        // buildAddButton(context, isEditing: isEditing),
      ],
    );
  }
}
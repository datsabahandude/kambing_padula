import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kambing_padula/add_kambing/KambingDialog.dart';
// import 'package:kambing_padula/add_kambing/add_goat.dart';
import 'package:kambing_padula/add_kambing/boxes.dart';
import 'package:kambing_padula/add_kambing/kambing.dart';
import 'package:kambing_padula/main.dart';

class kambing_list extends StatefulWidget {
  const kambing_list({Key? key}) : super(key: key);

  @override
  State<kambing_list> createState() => _kambing_listState();
}

class _kambing_listState extends State<kambing_list> with SingleTickerProviderStateMixin{
  _kambing_listState(){
    _selectedVal = jantina[0];
  }
  final jantina = ['Jantan','Betina','LGBTQ'];
  String? _selectedVal = '';
  String umur='';
  DateTime datenow = DateTime.now();
  final namaEditingController = new TextEditingController();
  final hargaEditingController = new TextEditingController();
  File? image;
  String? url;
  final List<Kambing> kambings = [];
  @override
  void initState() {
    super.initState();
  }
  void dispose(){
    // Hive.box('kambing').close();
    Hive.close();
    super.dispose();
  }
  Future _pickImageCamera() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() => this.image = imagetemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Navigator.of(context).pop();
  }
  Future _pickImageGallery() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagetemp = File(image.path);
      //final imagepermanent = await saveImagePermanently(image.path);
      setState(() => this.image = imagetemp);
      //setState(() => this.image = imagepermanent);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    Navigator.of(context).pop();
  }
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/goated.jpg"),
              fit: BoxFit.cover)
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: new IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
              },
            ),
            title: Text("Senarai Kambing",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.lightGreenAccent,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),),),
            actions: [],
          ),
          body: ValueListenableBuilder<Box<Kambing>>(
            valueListenable: Boxes.getKambings().listenable(),
            builder: (context, box, _) {
              final kambings = box.values.toList().cast<Kambing>();
              return buildContent(kambings);
            },
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreenAccent,
          onPressed: () => showDialog(
              context: context,
              builder: (context) => KambingDialog(
                onClickedDone: addKambing
              )
          ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
  Widget buildContent(List<Kambing> kambings) {
    if (kambings.isEmpty) {
      return Center(
        child: Text(
          'gak ada kambingnya?',
          style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: Colors.lightGreenAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),
          )
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24,),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: kambings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final kambing = kambings[index];
                    return buildKambing(context, kambing);
          }
          )
          )
        ],
      );
    }
  }
  Widget buildKambing(
      BuildContext context,
      Kambing kambing,
      ) {
    // final date = DateFormat.yMMMd().format(kambing.date);
    // edit all below
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          kambing.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text('date'),
        trailing: Text(
          'amount',
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, kambing),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Kambing kambing) => Row(
    children: [
      Expanded(
        child: TextButton.icon(
          label: Text('Edit'),
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => KambingDialog(
                kambing: kambing,
                onClickedDone: (image, datenow, umur, name, price, gender){},
                // onClickedDone: (name, amount, isExpense) {
                //   return editKambing(kambing, name, amount, isExpense);
                // },
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: TextButton.icon(
          label: Text('Delete'),
          icon: Icon(Icons.delete),
          onPressed: () => deleteKambing(kambing),
        ),
      )
    ],
  );

  Future addKambing(String image, DateTime datenow, String umur, String name, String price, String gender) async{
    final kambing = Kambing()
      ..image = image
      ..date = datenow
      ..age = umur
      ..name = namaEditingController.text
      ..price = hargaEditingController.text
      ..gender = _selectedVal!;
    final box = Boxes.getKambings();
    box.add(kambing);
  }
/*
  void editTransaction(
      Transaction transaction,
      String name,
      double amount,
      bool isExpense,
      ) {
    transaction.name = name;
    transaction.amount = amount;
    transaction.isExpense = isExpense;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    transaction.save();
  }
*/
  void deleteKambing(Kambing kambing) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    kambing.delete();
    //setState(() => transactions.remove(transaction));
  }
}

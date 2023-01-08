import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambing_padula/add_kambing/KambingDialog.dart';
import 'package:kambing_padula/add_kambing/boxes.dart';
import 'package:kambing_padula/add_kambing/kambing.dart';
import 'package:kambing_padula/main.dart';

class kambing_list extends StatefulWidget {
  const kambing_list({Key? key}) : super(key: key);

  @override
  State<kambing_list> createState() => _kambing_listState();
}

class _kambing_listState extends State<kambing_list> {

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose(){
    Hive.close();
    super.dispose();
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
                  itemBuilder: (context, index) {
                    final kambing = kambings[index];
                    return buildKambing(context, kambing);
          }
          )
          )
        ],
      );
    }
  }
  // template UI
  Widget buildKambing(
      BuildContext context,
      Kambing kambing,
      ) {
    final gambar = kambing.imageBytes;
    final lahir = kambing.date;
    final age = kambing.age;
    final nama = kambing.name;
    final harga = kambing.price;
    final gender = kambing.gender;

    return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity
      ),
      child: Card(
        shadowColor: Colors.deepPurple,
        elevation: 8,
        child: ListTile(
          tileColor: Colors.yellowAccent,
          leading: Image.memory(gambar),
          title: Text(nama, style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.bold),),),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Text(harga),
                  ),
                  Spacer(),
                  Container(
                    child: Text(age),
                  ),
                ],
              ),
              Container(child: Text('${lahir.day}/${lahir.month}/${lahir.year}'),)
            ],
          ),
          isThreeLine: true,
          trailing: Icon(Icons.keyboard_arrow_right_rounded),
          onTap: (){
            deleteKambing(kambing);
            },
        ),
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
                onClickedDone: (image, datenow, umur, name, price, gender) {
                  // editKambing(kambing, image, date, umur, nama, harga, jantina);
                },
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: TextButton.icon(
          label: Text('Padam'),
          icon: Icon(Icons.delete),
          onPressed: () => deleteKambing(kambing),
        ),
      )
    ],
  );

  Future addKambing(Uint8List imageBytes, DateTime datenow, String umur, String name, String price, String gender) async{
    final kambing = Kambing()
      ..imageBytes = imageBytes
      ..date = datenow
      ..age = umur
      ..name = name
      ..price = price
      ..gender = gender;
    final box = Boxes.getKambings();
    box.add(kambing);
  }

  void editKambing(
      Kambing kambing,
      Uint8List image,
      DateTime date,
      String umur,
      String nama,
      String harga,
      String jantina
      ) {
    kambing.imageBytes = image;
    kambing.date = date;
    kambing.age = umur;
    kambing.name = nama;
    kambing.price = harga;
    kambing.gender = jantina;

    kambing.save();
  }

  void deleteKambing(Kambing kambing) {
    kambing.delete();
  }
}

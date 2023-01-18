import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambing_padula/add_kambing/KambingDialog.dart';
import 'package:kambing_padula/add_kambing/models/boxes.dart';
import 'package:kambing_padula/add_kambing/models/kambing.dart';
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
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            // color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        ),
        title: Text(
          "Senarai Kambing",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                // color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        ),
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
        backgroundColor: Colors.deepPurple,
        onPressed: () => showDialog(
            context: context,
            builder: (context) => KambingDialog(onClickedDone: addKambing)),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget buildContent(List<Kambing> kambings) {
    if (kambings.isEmpty) {
      return Center(
        child: Text('gak ada kambingnya?',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: kambings.length,
                  itemBuilder: (context, index) {
                    final kambing = kambings[index];
                    return buildKambing(context, kambing);
                  }))
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
    final nama = kambing.name;
    final harga = kambing.price;
    final gender = kambing.gender;
    String mm = '', yy = '';
    if ((DateTime.now().day >= lahir.day) &&
        (DateTime.now().month >= lahir.month) &&
        DateTime.now().year >= lahir.year) {
      yy = '${DateTime.now().year - lahir.year}';
      mm = '${DateTime.now().month - lahir.month}';
    }
    //TFT
    else if ((DateTime.now().day >= lahir.day) &&
        (DateTime.now().month < lahir.month) &&
        DateTime.now().year >= lahir.year) {
      if (DateTime.now().year == lahir.year) {}
      yy = '${DateTime.now().year - lahir.year - 1}';
      mm = '${DateTime.now().month - lahir.month + 12}';
    }
    //FTT
    else if ((DateTime.now().day < lahir.day) &&
        (DateTime.now().month >= lahir.month) &&
        DateTime.now().year >= lahir.year) {
      if (DateTime.now().year == lahir.year &&
          DateTime.now().day < lahir.day) {}
      if (DateTime.now().month == lahir.month &&
          DateTime.now().year != lahir.year) {
        yy = '${DateTime.now().year - lahir.year - 1}';
        mm = '${DateTime.now().month - lahir.month + 11}';
      } else if (DateTime.now().month == lahir.month) {
        yy = '${DateTime.now().year - lahir.year}';
        mm = '${DateTime.now().month - lahir.month}';
      } else {
        yy = '${DateTime.now().year - lahir.year}';
        mm = '${DateTime.now().month - lahir.month - 1}';
      }
    }
    //FFT
    else if ((DateTime.now().day < lahir.day) &&
        (DateTime.now().month < lahir.month) &&
        DateTime.now().year >= lahir.year) {
      if (DateTime.now().year == lahir.year) {}
      yy = '${DateTime.now().year - lahir.year - 1}';
      mm = '${DateTime.now().month - lahir.month + 11}';
    } else {}
    final age = yy + ' Tahun ' + mm + ' Bulan';
    return Card(
      shadowColor: Colors.deepPurpleAccent,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: EdgeInsets.all(6),
        // margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 40),
        child: AspectRatio(
          aspectRatio: 3 / 1,
          child: Container(
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      gambar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                AspectRatio(
                  aspectRatio: 5 / 3,
                  child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              gender == 'Jantan'
                                  ? Icon(
                                      Icons.male_outlined,
                                      color: Colors.blue,
                                    )
                                  : gender == 'Betina'
                                      ? Icon(
                                          Icons.female_outlined,
                                          color: Colors.pink,
                                        )
                                      : Icon(Icons.transgender_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                nama,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.av_timer, color: Colors.purple),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                age,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.cake_outlined, color: Colors.purple),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${lahir.day}/${lahir.month}/${lahir.year}',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                )),
                              ),
                            ],
                          ),
                          // SizedBox(height: 20,),
                          Text(
                            'RM  ' + harga,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        deleteKambing(kambing);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    /*return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity
      ),
      child: Card(
        shadowColor: Colors.deepPurpleAccent,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24)
    ),
    child: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: MemoryImage(gambar),
              child: InkWell(
                onTap: (){},
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
          ],
        ),
        ListTile(
          tileColor: Colors.white,
          title: Center(child:
          Text(
            nama,
            style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          ),
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Text('RM'+harga, style: GoogleFonts.poppins(textStyle: txtstl),),
                  ),
                  Spacer(),
                  Container(
                    child: Text(age, style: GoogleFonts.poppins(textStyle: txtstl),),
                  ),
                  Spacer(),
                  Container(
                    child: Text(gender, style: GoogleFonts.poppins(textStyle: txtstl),),
                  ),
                ],
              ),
              Container(child: Text('${lahir.day}/${lahir.month}/${lahir.year}', style: GoogleFonts.poppins(textStyle: txtstl),),)
            ],
          ),
          isThreeLine: true,
          // trailing: Icon(Icons.keyboard_arrow_right_rounded),
          onTap: (){
            // deleteKambing(kambing);
          },
        ),
      ],
    ),
      ),
    );*/
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
                    onClickedDone: (image, datenow, name, price, gender) {
                      // editKambing(kambing, image, date, nama, harga, jantina);
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

  Future addKambing(Uint8List imageBytes, DateTime datenow, String name,
      String price, String gender) async {
    final kambing = Kambing()
      ..imageBytes = imageBytes
      ..date = datenow
      ..name = name
      ..price = price
      ..gender = gender;
    final box = Boxes.getKambings();
    box.add(kambing);
  }

  void editKambing(Kambing kambing, Uint8List image, DateTime date, String nama,
      String harga, String jantina) {
    kambing.imageBytes = image;
    kambing.date = date;
    kambing.name = nama;
    kambing.price = harga;
    kambing.gender = jantina;

    kambing.save();
  }

  void deleteKambing(Kambing kambing) {
    kambing.delete();
  }
}

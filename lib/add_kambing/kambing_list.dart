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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.transparent,
      /*appBar: AppBar(
        // leading: new IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_rounded,
        //     // color: Colors.white,
        //     size: 30,
        //   ),
        //   onPressed: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => MyHomePage()));
        //   },
        // ),
        automaticallyImplyLeading: false,
        title: Text(
          "Senarai Kambing",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                // color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/kambir.jpg"),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
      */
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: height * 0.3,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/goated.jpg"),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(1.0),
                        ],
                        begin: Alignment.topRight, end: Alignment.bottomLeft)),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 20,
                    child: RichText(
                        text: TextSpan(
                      text: "Kambing",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                          children: [
                            TextSpan(
                                text: "\nPak Dola",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                              ),
                            )
                          ]
                    ),
                    ),
                  )
                ],
              ),
              Transform.translate(
                offset: Offset(0.0, - (height*0.3-height*0.26)),
                child: Container(
                  width: width,
                  height: 400,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                  ),
                  child: DefaultTabController(length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.black,
                          labelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                // color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          unselectedLabelColor: Colors.grey[400],
                          unselectedLabelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              // color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                          indicatorSize: TabBarIndicatorSize.label,
                          // indicatorColor: Colors.transparent,
                          tabs: [
                        Tab(child: Text("Kambing"),),
                        Tab(child: Text("Matang"),),
                        Tab(child: Text("Anak"),),
                      ]
                      ),
                      SizedBox(height: 5,),
                      /*Container(
                        child: TabBarView(
                          children: [
                            Container(child: Text('Tab 1')),
                            Container(child: Text('Tab 2')),
                            Container(child: Text('Tab 3')),
                          ],
                          // ValueListenableBuilder<Box<Kambing>>(
                          //   valueListenable: Boxes.getKambings().listenable(),
                          //   builder: (context, box, _) {
                          //     final kambings = box.values.toList().cast<Kambing>();
                          //     return buildContent(kambings);
                          //   },
                          // ),
                        ),
                      )*/
                    ],
                  ),
                  ),
                ),
              )
            ],
          ),
        ),
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
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: kambings.length,
                    itemBuilder: (context, index) {
                      final kambing = kambings[index];
                      return buildKambing(context, kambing);
                    }),
              ))
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
                  child: InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        gambar,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(24)),
                              content: Image.memory(
                                gambar,
                                width: MediaQuery.of(context).size.width,
                                // height: 300,
                                // height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                    },
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
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        InkWell(
                                          splashColor: Colors.purple,
                                          onTap: () => showDialog(
                                            context: context,
                                            builder: (context) => KambingDialog(
                                              kambing: kambing,
                                              onClickedDone: (imageBytes,
                                                  datenow,
                                                  name,
                                                  price,
                                                  gender) {
                                                editKambing(
                                                    kambing,
                                                    imageBytes,
                                                    datenow,
                                                    name,
                                                    price,
                                                    gender);
                                              },
                                            ),
                                          ),
                                          /*Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KambingDialog(
                                                kambing: kambing,
                                                onClickedDone: (imageBytes,
                                                    datenow,
                                                    name,
                                                    price,
                                                    gender) {
                                                  editKambing(
                                                      kambing,
                                                      imageBytes,
                                                      datenow,
                                                      name,
                                                      price,
                                                      gender);
                                                },
                                              ),
                                            ),
                                          ),*/
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Text(
                                                'Ubah Maklumat',
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.red,
                                          onTap: () {
                                            deleteKambing(kambing);
                                            Navigator.of(context).pop();
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                'Padam',
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.redAccent,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            });
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

  void editKambing(Kambing kambing, Uint8List imageBytes, DateTime datenow,
      String name, String price, String gender) {
    kambing.imageBytes = imageBytes;
    kambing.date = datenow;
    kambing.name = name;
    kambing.price = price;
    kambing.gender = gender;

    kambing.save();
  }

  void deleteKambing(Kambing kambing) {
    kambing.delete();
  }
}

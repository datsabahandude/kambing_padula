import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambing_padula/add_kambing/add_goat.dart';
import 'package:kambing_padula/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class kambing_list extends StatefulWidget {
  const kambing_list({Key? key}) : super(key: key);

  @override
  State<kambing_list> createState() => _kambing_listState();
}

class _kambing_listState extends State<kambing_list> {
  // String? noteValue;
  final _box = Hive.box('mybox');
  @override
  void initState() {
    super.initState();
    // getNotes();
  }
  // void getNotes() async{
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   noteValue = pref.getString('nameKey');
  //   setState(() {
  //
  //   });
  // }
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
                padding: EdgeInsets.all(20),
                child: _box.get(1) != null ? Text(_box.get(1)
                ):Container(
                  child: Text('theres no data'),
                ),
                // child: noteValue == null ? Text('No Data D:') : Text(noteValue!,),
                // child: ListView.builder(
                //     scrollDirection: Axis.vertical,
                //     itemCount: _itemlist.length,
                //     itemBuilder: (context, index) {
                //       final item = _itemlist[index];
                //       return ItemCard(_itemlist[index] as dumm);
                //     } //=> build(context),
                // ),
              ),
            ],
          ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreenAccent,
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        add_goat()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

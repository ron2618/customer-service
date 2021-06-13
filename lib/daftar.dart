import 'package:app_firebase/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nama = TextEditingController();
    TextEditingController _nohp = TextEditingController();
    TextEditingController _unit = TextEditingController();
    TextEditingController _blokrumah = TextEditingController();
    TextEditingController _wilayah = TextEditingController();
    final firestoreInstance = FirebaseFirestore.instance;
    String cs ="";
      bool _obscureText = true;
    
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
    Future<void> getdata() async {
    final db = FirebaseFirestore.instance;
    
// Get document with ID totalVisitors in collection dashboard
   
    await db
        .collection('app')
        .doc("h7lG06JNy1xO4CUrBXty")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      // Get value of field date from document dashboard/totalVisitors
      setState(() {
        cs = documentSnapshot.data()['cs'];
      });
    });
  }
  Future<void> daftar() async {
    if (_emailController.text == '') {
      final snackBar = SnackBar(content: Text('Email Tidak Boleh Kosong',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
    }else if(_nama.text==''){
      final snackBar = SnackBar(content: Text('Nama Tidak Boleh Kosong',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
    }else if(_nohp.text == ''){
      final snackBar = SnackBar(content: Text('No Hp Tidak Boleh Kosong',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
    }else if(_blokrumah.text == ''){
      final snackBar = SnackBar(content: Text('No Rumah Tidak Boleh Kosong',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
    }else if(_unit.text == ''){
      final snackBar = SnackBar(content: Text('Unit Tidak Boleh Kosong',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
    }else if (_wilayah.text == '') {
      final snackBar = SnackBar(content: Text('Wilayah Tidak Boleh Kosong',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
    }else if(_passwordController.text == ''){
      final snackBar = SnackBar(content: Text('Password Tidak Boleh Kosong',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
    }else{
        try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text
  );
   countDocuments(_emailController.text);
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    final snackBar = SnackBar(content: Text('Password Terlalu pendek',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
  } else if (e.code == 'email-already-in-use') {
     final snackBar = SnackBar(content: Text('Email Sudah di gunakan',style: TextStyle(fontSize: 25),));
               _scaffoldKey.currentState.showSnackBar(snackBar);
  }else{
   
  }
} catch (e) {
  print(e);
}
    }
    
  }
      void countDocuments(String email) async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('pengguna').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    int id = _myDocCount.length+1;  // Count of Documents in Collection
     firestoreInstance.collection("pengguna").doc(email).set(
  {
    "id"    : id.toString(),
    "image": "alpa-"+id.toString(),
    "email" : email,
    "nama": _nama.text,
    "telepon": _nohp.text,
    "unit": _unit.text,
    "blok atau no rumah": _blokrumah.text,
    "wilayah":_wilayah.text,

  }).then((value){
    final snackBar = SnackBar(content: Text('Akun Berhasil Di buat'));
               _scaffoldKey.currentState.showSnackBar(snackBar);
    _emailController.text = "";
    _passwordController.text = "";
    _nama.text ="";
    _nohp.text = "";
    _unit.text = "";
    _blokrumah.text="";
    _wilayah.text ="";
  });
}
@override
void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; // mengambil tinggi hp
    double width = MediaQuery.of(context).size.width; // mengambil lebar hp
    return Scaffold(
      key: _scaffoldKey,   
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Text("CS "+cs),
      ),
      body: Container(
        height: height,
        width: width,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "Customer Service",
              style: TextStyle(fontSize: 30, color: Colors.green),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "Buat Akun Baru",
              style: TextStyle(fontSize: 30, color: Colors.lightBlue,fontWeight: FontWeight.bold),
            )),
               SizedBox(
              height: 20,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  controller: _nama,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: ' Nama Lengkap',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  controller: _nohp,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: ' Telepon',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
             Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  controller: _unit,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: ' Unit',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
             Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  controller: _blokrumah,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: ' Blok/No Rumah',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  controller: _wilayah,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: ' Kawasan/Wilayah',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
             Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: ' Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
             Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
              child: new Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  border: new Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: new TextField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                  obscureText: _obscureText,
                  decoration: new InputDecoration(
                     suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
               _obscureText
               ? Icons.visibility_off
               : Icons.visibility,
               color: Theme.of(context).primaryColorDark,
               ),
            onPressed: () {
               // Update the state i.e. toogle the state of passwordVisible variable
              _toggle();
             },
            ),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: ' Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Container(
                    height: 50,
                    width: 100,
                    child: RaisedButton(
                        child: Center(child: Text("Daftar")), onPressed: () {
                          daftar();
                        }))),
            Center(child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("\nSudah Punya Akun ?",style: TextStyle(color: Colors.green),),
                 GestureDetector(
                   onTap: (){
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                   },
                   child: Text("\n Masuk Disini" ,style: TextStyle(color: Colors.green[800]),)),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

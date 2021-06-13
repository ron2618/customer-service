import 'package:app_firebase/daftar.dart';
import 'package:app_firebase/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'lupapassword.dart';

//ini adalah tampilan login

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool cek = false;
  String cs ='';
  bool _obscureText = true;
  
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  getlogin() async { //mengecek sudah login apa belum,
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email');
    if (email != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

    Future<void> getdata() async { //meminta data cs dari firebase
    final db = FirebaseFirestore.instance;
    await db
        .collection('app')
        .doc("h7lG06JNy1xO4CUrBXty")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      setState(() {
        cs = documentSnapshot.data()['cs'];
      });
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _signInWithEmailAndPassword() async { //login via firebase 
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
        final snackBar =
            SnackBar(content: Text('Cek email untuk veritifikasi',style: TextStyle(fontSize: 25),));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        ingatsaya(cek);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text('Email Atau Password Salah',style: TextStyle(fontSize: 25),));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  ingatsaya(bool cek) async { // fungsi ingat saya
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _emailController.text);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }


  @override
  void initState() {//fungsi di jalankan pertamakali
    // TODO: implement initState
    super.initState();
    getlogin();
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
              height: 100,
            ),
            Center(
                child: Text(
              "Customer Service",
              style: TextStyle(fontSize: 30, color: Colors.green),
            )),
            SizedBox(
              height: 50,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
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
                    hintText: ' email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
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
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: ' password',
                    border: InputBorder.none,
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
          ),

                  ),
                ),
              ),
            ),
            CheckboxListTile(
              title: Text("ingat saya"),
              value: cek,
              onChanged: (newValue) {
                setState(() {
                  cek = newValue;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Container(
                    height: 50,
                    width: 100,
                    child: RaisedButton(
                        child: Center(child: Text("Masuk")),
                        onPressed: () {
                          _signInWithEmailAndPassword();
                        }))),
            Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\nBelum Punya Akun ?",
                  style: TextStyle(color: Colors.green),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Daftar()),
                      );
                    },
                    child: Text(
                      "\n Daftar Disini",
                      style: TextStyle(color: Colors.green[800]),
                    )),
              ],
            )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Lupa()),
                  );
                },
                child: Center(
                    child: Text(
                  "\nLupa Password ?",
                  style: TextStyle(color: Colors.green),
                ))),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Lupa extends StatefulWidget {
  @override
  _LupaState createState() => _LupaState();
}

class _LupaState extends State<Lupa> {
   final TextEditingController _emailController = TextEditingController();
  Future<void> resetPassword(String email) async {
    
     FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: email);
}
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height; // mengambil tinggi hp
    double width = MediaQuery.of(context).size.width; // mengambil lebar hp
    return Scaffold(
      appBar: new AppBar(
        title: Text("Lupa Password"),
      ),
      body: Container(
        height: height,
        width: width,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                SizedBox(height: 20,),
                Center(
                child: Container(
                    height: 50,
                    width: 100,
                    child: RaisedButton(
                        child: Center(child: Text("Kirim")), onPressed: () {
                        resetPassword(_emailController.text);
                        }))),
          ],
        ),
      ),
    );
  }
}
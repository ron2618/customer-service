import 'dart:convert';
import 'dart:io';
import 'package:app_firebase/lihatgambar.dart';
import 'package:app_firebase/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> a = [];
  bool load = false;
  var cs = "";
  var nama = "";
  var imagedata = "";
  bool pdf = false;
  Future<void> cekfile() async {
    for (var i = 1; i < 1000; i++) {
      final responsejpg = await http.get(
          "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
              imagedata.toString() +
              "-" +
              i.toString() +
              "." +
              "jpg" +
              "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52");
  print(responsejpg);
      if (responsejpg.statusCode != 200) {
        final responsegif = await http.get(
            "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                imagedata.toString() +
                "-" +
                i.toString() +
                "." +
                "gif" +
                "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52");
        if (responsegif.statusCode != 200) {
          final responsexls = await http.get(
              "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                  imagedata.toString() +
                  "-" +
                  i.toString() +
                  "." +
                  "xls" +
                  "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52");
          if (responsexls.statusCode != 200) {
            i=1000;
            setState(() {
                 load = true;
            });
         
           print(a);
          }else{
             a.add(GestureDetector(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Lihat(url: "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/xls.png?alt=media&token=45696656-84c9-440b-95a0-ffa7aa5cbcd7",)));
               },
               child: Image.network("https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/xls.png?alt=media&token=45696656-84c9-440b-95a0-ffa7aa5cbcd7")));
          }
        }else{
           a.add(GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => Lihat(url: "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                imagedata.toString() +
                "-" +
                i.toString() +
                "." +
                "gif" +
                "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52",)));
             },
             child: Image.network("https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                imagedata.toString() +
                "-" +
                i.toString() +
                "." +
                "gif" +
                "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52"),
           ));
        }
      }else{
        a.add(GestureDetector(
          onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => Lihat(url: "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                imagedata.toString() +
                "-" +
                i.toString() +
                "." +
                "jpg" +
                "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52",)));
          },
          child: Image.network("https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                imagedata.toString() +
                "-" +
                i.toString() +
                "." +
                "jpg" +
                "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52"),
        ));
              
      }
    }
  }

  String simpan = "File Siap Di Simpan";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> getdata() async {
    final db = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String email = prefs.getString('email');
// Get document with ID totalVisitors in collection dashboard
    await db
        .collection('pengguna')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      // Get value of field date from document dashboard/totalVisitors
      setState(() {
        nama = documentSnapshot.data()['nama'];
        imagedata = documentSnapshot.data()['image'];
      });
    });
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
    cekfile();
  }

  Future<void> loadimage() async {
    for (var i = 1; i < 10000; i++) {
      try {
        setState(() {
          simpan = "proses Menyimpan ...";
        });

        var extensi = 'jpg';

        var image =
            "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                imagedata.toString() +
                "-" +
                i.toString() +
                "." +
                extensi +
                "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52";
                print(image);
        var unduh = await ImageDownloader.downloadImage(image,
            destination: AndroidDestinationType.custom(directory: "CS/"));
      } catch (error) {
        try {
          var image =
              "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                  imagedata.toString() +
                  "-" +
                  i.toString() +
                  ".xls?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52";
          var unduh = await ImageDownloader.downloadImage(image,
              destination: AndroidDestinationType.custom(directory: "CS/"));
        } catch (error) {
          try {
            var image =
                "https://firebasestorage.googleapis.com/v0/b/fir-test-2d9a5.appspot.com/o/" +
                imagedata.toString() +
                "-" +
                i.toString() +
                "." +
                "gif" +
                "?alt=media&token=0f3acba4-5536-4218-9e65-0255150c2c52";
            var unduh = await ImageDownloader.downloadImage(image,
                destination: AndroidDestinationType.custom(directory: "CS/"));
          } catch (error) {
            i = 10000;
            setState(() {
              simpan = 'File Berhasil Di Simpan';
            });
          }
        }
      }
    }
  }

  Future<String> _createFolder() async {
    final folderName = "CS";
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("email");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createFolder();
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
        title: cs == "" ? Text("CS ") : Text("CS " + cs),
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: height - 300,
              width: width,
              child: a == []
                  ? Center(
                      child: Container(
                          height: 50, child: Text("belum ada file untuk di simpan")))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: height-100,
                          width: 300.0,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: height-100,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: a,
                          )),
                    ),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                RaisedButton(
                    child: Center(
                      child: Text("Keluar"),
                    ),
                    onPressed: () {
                      removeValues();
                    }),
                Expanded(child: Container()),
                RaisedButton(
                    child: Center(
                      child: Text("Simpan"),
                    ),
                    onPressed: () {
                      loadimage();
                    }),
              ],
            ),
            Text(simpan,style: TextStyle(fontSize: 25),),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'loading.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
       final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CS',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Loading(),
    );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
         return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CS',
      theme: ThemeData(
        primaryColor:  Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Login(),
    );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CS',
      theme: ThemeData(
        primaryColor:  Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Loading(),
    );
      },
    );
  }
}

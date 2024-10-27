import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_credentials/view/loginpage/loginpagescreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: "AIzaSyDRkwqYJ0uajJYf1SmWEMZ9EKDl2pqPQ-Y",
   appId: "1:155710142531:android:3366fbd86ddb3a41b4fcf6", 
   messagingSenderId: "",
    projectId: "fir-started-34dce",
    storageBucket: "fir-started-34dce.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home:LoginScreen()
    );
  }
}

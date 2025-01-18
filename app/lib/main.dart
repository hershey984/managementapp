import 'package:app/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/home_page.dart';
import 'package:app/warehouse_page.dart';
import 'package:app/login_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the configuration
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBlZavRDZrz2SkguFdQD_Ut5ALe5ksbTMQ",
      authDomain: "managementapp-9502a.firebaseapp.com",
      projectId: "managementapp-9502a",
      storageBucket: "managementapp-9502a.firebasestorage.app",
      messagingSenderId: "124026290646",
      appId: "1:124026290646:web:b8f69a5af41f0647e72477",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  List<Widget> widgetList = [
    HomePage(),
    WarehouseScreen(),
    RegisterPage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: widgetList[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
              label: 'Warehouse',
              icon: Icon(Icons.warehouse),
            ),
            BottomNavigationBarItem(
              label: 'Login',
              icon: Icon(Icons.login),
            ),
          ],
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

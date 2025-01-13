import 'package:app/home_page.dart';
import 'package:app/login_page.dart';
import 'package:app/warehouse_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  List<Widget> widgetList =  [
    HomePage(),
    WarehousePage(),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       // appBar: AppBar(
       //   title: Text('App Bar'),
       // ),
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
            print("Tapped on index: $index");
            print("HELLO");
            print("hello world");
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_final_all/pages/AccountPage.dart';
import 'pages/HomePage.dart';
import 'pages/ItEuipment.dart';
import 'pages/NotebookPage.dart';
import 'pages/AboutUsPage.dart';
import 'pages/CartPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    NotebookPage(),
    ItEuipment(),
    AboutUsPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('I have Pc'),
          backgroundColor: const Color(0xff0077B6),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 4; // Switch to CartPage
                });
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
              icon: const Icon(Icons.account_circle, color: Colors.white),
            ),
          ],
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex < 4 ? _currentIndex : 0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color(0xff0077B6)),
            BottomNavigationBarItem(
                icon: Icon(Icons.laptop),
                label: 'Notebook',
                backgroundColor: Color(0xff0077B6)),
            BottomNavigationBarItem(
                icon: Icon(Icons.sd_storage_outlined),
                label: 'IT Equipment',
                backgroundColor: Color(0xff0077B6)),
            BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'About us',
                backgroundColor: Color(0xff0077B6)),
          ],
        ),
      ),
    );
  }
}


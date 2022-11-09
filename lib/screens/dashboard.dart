import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../network/api.dart';
import 'home/home_screen.dart';
import 'login.dart';
import 'profil/profile_screen.dart';
import 'upload/upload_screen.dart';

class DashboardMenu extends StatefulWidget {
  @override
  _DashboardMenuState createState() => _DashboardMenuState();
}

class _DashboardMenuState extends State<DashboardMenu> {
  int _selectedScreen = 0;
  _onTap() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => _ScreenOptions[_selectedScreen]));
  }

  final List<Widget> _ScreenOptions = [
    HomeScreen(),
    // UploadScreen(),
    ProfilScreen()
  ];

  String name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')??'');

    if (user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: _ScreenOptions[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30), label: 'home'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.mail, size: 30), title: Text('Inbox')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 30),label: 'Profile'),
        ],
        selectedItemColor: Colors.blueGrey,
        elevation: 5.0,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedScreen,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _selectedScreen = index;
          });
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadScreen()),
          );
          // _incrementTab(1);
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}

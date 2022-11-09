import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/api.dart';
import '../login.dart';
import 'editProfil/edit_profil.dart';

class ProfilScreen extends StatefulWidget {
  // const ProfilScreen({ Key? key }) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String name = '';
  String id = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user') ?? '');
    // var id = jsonDecode(localStorage.getString('id') ?? '');

    if (user != null) {
      setState(() {
        name = user['name'];
        id = user['id'].toString();
        email = user['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
        backgroundColor: Color(0xff151515),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Text("Edit Account"),
                onTap: () {
                  EditProfile();
                },
              ),
              PopupMenuItem(
                value: 1,
                child: Text("Log Out"),
                onTap: () {
                  logout();
                },
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              print("Edit Profil");
            } else if (value == 1) {
              print('Logout');
            }
          })
        ],
      ),
      body: Center(
        child: Card(
          child: SizedBox(
            width: 300,
            height: 500,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: Text('${name}'),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Card(
                    color: Colors.grey,
                    child: SizedBox(
                      width: 300,
                      height: 30,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Nomor ID' ' : ' '${id}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    child: SizedBox(
                      width: 300,
                      height: 30,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Nama' ' : ' '${name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.grey,
                    child: SizedBox(
                      width: 300,
                      height: 30,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Email' ' : ' '${email}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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

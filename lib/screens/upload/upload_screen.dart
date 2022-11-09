import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  // const UploadScreen({ Key? key }) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff151515),
        appBar: AppBar(
          title: Text('Upload Screen'),
          backgroundColor: Color(0xff151515),
          automaticallyImplyLeading: false,
        ),
      ),
    );
  }
}

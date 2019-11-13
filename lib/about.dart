import 'package:flutter/material.dart';


class About extends  StatefulWidget{
  @override
  AboutState  createState()=> AboutState();
}
class AboutState extends State<About>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.blue[900]
      ),
    );
  }
}
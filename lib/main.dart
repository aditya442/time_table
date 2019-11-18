import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_jatis/Halaman_Utama.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/Halaman_Utama': (BuildContext context) => new Halaman_Utama()
      },
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Halaman_Utama');
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                "assets/images/logo.jpg",
                width:  250,
                height:  250,
              ),
              SizedBox(height: 25,),
              Text('Time Note Reminder',style: TextStyle(color: Colors.blue[900],fontSize: 30,fontWeight: FontWeight.w700))
            ],
          ),
        ],
      ),
    );
  }
}

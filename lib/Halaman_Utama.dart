import 'package:flutter/material.dart';
import 'package:flutter_jatis/Halaman_Input.dart';
import 'package:flutter_jatis/about.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_jatis/detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:device_id/device_id.dart';

String device_id ;

class Halaman_Utama extends StatefulWidget{
  List list;
  int index;
  Halaman_Utama({this.index,this.list});

  @override
  HalamanState createState()=> HalamanState();
}
class HalamanState extends State<Halaman_Utama> {

  final TextEditingController _filter = new TextEditingController();

  List judul = new List();
  List filteredJudul = new List();

  List list;

  Future getData() async {
    print(device_id);
    http.Response hasil = await http.get(
        Uri.encodeFull("http://adityo.xyz/jatis/jatis_getdata.php?device_id=${device_id}"),
        headers: {"Accept": "application/json"});

 //   await new Future.delayed(new Duration(seconds: 1));

    this.setState(() {
      list = json.decode(hasil.body);
    });
  }

  void initState() {
    super.initState();

    initDeviceId();
  }

  Future<void> initDeviceId() async {
    String deviceid;

    deviceid = await DeviceId.getID;

    if (!mounted) return;

    setState(() {
      device_id = deviceid;
      this.getData();
    });
   // print(deviceid);
  }

  Future _getjudul() async {
    //_filter = _filter.text;
    http.Response hasil = await http.get(
        Uri.encodeFull('http://adityo.xyz/jatis/pencarian.php?judul='+ _filter.text),
        headers: {"Accept": "application/json"});

    //await new Future.delayed(new Duration(seconds: 5));

    this.setState(() {
      print(_filter.text);
      list = json.decode(hasil.body);
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName:Text(''), accountEmail:Text('Time Note Reminder',style: TextStyle(fontSize: 20),),
              currentAccountPicture: new CircleAvatar(backgroundColor: Colors.white,child: Image.asset('assets/images/logo.jpg',height: 60,),),
              decoration: new BoxDecoration(color: Colors.blue[900]),
              otherAccountsPictures: <Widget>[
               //  new CircleAvatar(backgroundColor: Colors.black26,child: new Text('y'),),
                //  new CircleAvatar(backgroundColor: Colors.black26,child: new Text('W'),),
              ],),
            new ListTile(title: new Text('About'),
                leading:new Icon(Icons.info_outline,color: Colors.redAccent,),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return About();
                          }
                      )
                  );
            }
            ),
            new ListTile(title: new Text('Exit'),
                leading:new Icon(Icons.backspace ,color: Colors.orange,),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Halaman_Utama();
                          }
                      )
                  );
                }
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Halaman_Input();
                  }
              )
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[900],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: SingleChildScrollView(
               // margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipPath(

                          clipper: WaveClipperOne(),
                          child: Container(
                                height:200,
                                width: double.infinity,
                                color: Colors.blue[900]
                            ),
                        ),
                        Column(
                          children: <Widget>[
                           AppBar(
                              elevation: 0,
                             backgroundColor: Colors.transparent,
                             title: Text('Time Note Reminder'),
                             actions: <Widget>[
                               IconButton(onPressed: (){
                                 _getjudul();

                                   }, icon: Icon(Icons.search),

                               ),
                              // Icon(Icons.threesixty),
                             ],
                            ),
                          ],
                        ),
                          Padding(
                              padding: const EdgeInsets.only(top: 70),
                             child: Column(

                               children: <Widget>[
                                 Container(
                                margin: EdgeInsets.all(15),
                                      child: Card(
                                              child: Container(

                                                  child: TextField(
                                                   controller: _filter,
                                                   decoration: InputDecoration(
                                                   contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                                    hintText: "Search ",
                                                    border: InputBorder.none,

                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                     /*   Padding(
                          padding: const EdgeInsets.only(top: 135),
                          child: Container(
                            width: double.infinity,
                            // padding: EdgeInsets.only(top: 0),
                            child:  CarouselSlider(
                              //  aspectRatio: 16/9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 2),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              // autoPlayCurve: Curve.fastOutSlowIn,
                              pauseAutoPlayOnTouch: Duration(seconds: 5),
                              enlargeCenterPage: true,
                              //  onPageChanged: callbackFunction,
                              scrollDirection: Axis.horizontal,
                              //  height: 150.0,
                              items: [
                                'assets/images/calender.jpg',
                                'assets/images/gambar.jpg',
                                'assets/images/waktu.jpg',
                              ].map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                       height: 70,
                                      //  width: double.infinity,
                                        //width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 20 ,vertical: 20) ,
                                        // padding: EdgeInsets.only(right: 20,left: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.transparent,
                                        ),
                                        child: Image.asset((i))
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                      */
                      ],
                    ),
                  ],
                ),
              )
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.1,
              childAspectRatio: 3.0,
              //childAspectRatio : 5.0,
              //  childAspectRatio: (itemWidth / itemHeight),
            ),
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index){

              return new Container(
                margin: EdgeInsets.all(5),
                child: new GestureDetector(
                  onTap: ()=>Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context)=> new Detail (list:list , index: index,)
                      )
                  ),

                  child: new Card(
                    child: new ListTile(
                      title: new Text(list[index]['judul']),
                      leading: new Icon(Icons.book,color: Colors.orange,size: 40,),
                      subtitle: new Text("${list[index]['tanggal']}"),
                    ),
                  ),
                ),
              );
            }, childCount: list == null ? 0 : list.length),
          ),
        ],
      ),
    );
  }
}

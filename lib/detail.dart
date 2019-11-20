import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_jatis/Halaman_Utama.dart';
import 'package:flutter_jatis/Edit.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.list,this.index});

  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {

  void deleteData(){
    var url="http://adityo.xyz/jatis/jatis_delete.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],

    });
  }

  void confirm (){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Anda yakin ingin menghapus '${widget.list[widget.index]['judul']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("Hapus",style: new TextStyle(color: Colors.white),),
          color: Colors.deepOrange,
          onPressed: (){
            deleteData();
            Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context)=> new Halaman_Utama(),
                )
            );
          },
        ),
        SizedBox(height: 30,),
        new RaisedButton(
          child: new Text("Batal",style: new TextStyle(color: Colors.white)),
          color: Colors.blueAccent,
          onPressed: ()=> Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.deepOrange,
          title: new Text("Detail")
      ),
      body: new Container(
        height: 600,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text("tanggal  :   ${widget.list[widget.index]['tanggal']}", style: new TextStyle(fontSize: 18.0),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(

                        child: new Text("judul   :   ${widget.list[widget.index]['judul']}", style: new TextStyle(fontSize: 18.0),

                    ),
                      margin: EdgeInsets.only(left: 30),
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 30,right: 30),
                      child: Row(
                        children: <Widget>[
                          new Text("deskripsi:",style: new TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30,top: 10),
                        child: new Text(
                        " ${widget.list[widget.index]['deskripsi']}",style: new TextStyle(fontSize: 18.0)
                    )
                    )
                  ],
                ),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("EDIT",style: TextStyle(color: Colors.white),),
                      color: Colors.deepOrange,
                      onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context)=>new Edit(list: widget.list,index: widget.index)),
                      ),
                    ),
                    new RaisedButton(
                      child: new Text("HAPUS",style: TextStyle(color: Colors.white),),
                      color: Colors.deepOrange,
                      onPressed: ()=>confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
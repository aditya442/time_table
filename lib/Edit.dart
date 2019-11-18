import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart'  as http;
import 'package:flutter_jatis/Halaman_Utama.dart';


class Edit extends StatefulWidget{
  List list;
  int index;
  Edit({this.list,this.index});

  @override
  EditState createState()=> EditState();
}
class EditState extends State<Edit>{
  final format = DateFormat("yyyy-MM-dd HH:mm");

  bool _value2 = false;
  void _onChanged2(bool value) => setState(() => _value2 = value);

  TextEditingController controllerjudul ;
  TextEditingController controllerdeskripsi ;
  TextEditingController controllertanggal ;

  void editData() {
    var url="http://adityo.xyz/jatis/jatis_edit.php";
    http.post(url,body: {
      "device_id": widget.list[widget.index]['device_id'],
      "judul": controllerjudul.text,
      "deskripsi": controllerdeskripsi.text,
      "tanggal": controllertanggal.text,

    });
  }

  void initState() {
    controllerjudul= new TextEditingController(text: widget.list[widget.index]['judul']);
    controllerdeskripsi= new TextEditingController(text: widget.list[widget.index]['deskripsi']);
    controllertanggal = new TextEditingController(text: widget.list[widget.index]['tanggal']);
    super.initState();
  }


  void _tampilkanalert() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Container(

        height: 150.0,
        child: Column(

          children: <Widget>[

            new Image.asset(
              "assets/images/sss.png",
              height: 100,
              width: 100,

            ),
            SizedBox(height: 15,),
            new Center(
              child: new Text("Update Data succes"),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }


  @override
   Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        title: Text('Edit'),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.only(right: 100,left: 15),
                child: TextFormField(
                  controller: controllerjudul,
                  // maxLines: 2,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    //  prefixIcon: Icon(Icons.email,color: Colors.lightBlueAccent,),
                    hintText: 'Masukkan Judul ',
                    //  hintStyle: TextStyle( color: Colors.blueAccent),
                    contentPadding: EdgeInsets.fromLTRB(20, 19, 20, 10),
                    border:  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.only(right: 100,left: 15),
                child: TextFormField(
                  controller: controllerdeskripsi,
                  maxLines: 6,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    //  prefixIcon: Icon(Icons.email,color: Colors.lightBlueAccent,),
                    hintText: 'Masukkan Keterangan',
                    //   hintStyle: TextStyle( color: Colors.blueAccent),
                    contentPadding: EdgeInsets.fromLTRB(20, 19, 20, 10),
                    border:  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              // Text('Basic date field (${format.pattern})'),
              Container(
                margin: EdgeInsets.only(right: 50,left: 15),
                child: DateTimeField(
                  controller: controllertanggal,

                  decoration: InputDecoration(
                    //  prefixIcon: Icon(Icons.email,color: Colors.lightBlueAccent,),
                    hintText: 'Masukkan Tanggal dan Waktu',
                    //   hintStyle: TextStyle( color: Colors.blueAccent),
                    contentPadding: EdgeInsets.fromLTRB(20, 19, 20, 10),
                    border:  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },
                ),
              ),
              new SwitchListTile(
                value: _value2,
                onChanged: _onChanged2,
                title: new Text('priority', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.only(right: 15,left: 15),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.greenAccent[400],
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context,false)
                    ),
                    RaisedButton(
                      color: Colors.greenAccent[400],
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        editData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Halaman_Utama();
                                }
                            )
                        );
                        _tampilkanalert();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


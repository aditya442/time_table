import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart'  as http;
import 'package:flutter_jatis/Halaman_Utama.dart';
import 'package:device_id/device_id.dart';


class Halaman_Input extends StatefulWidget{
  @override
  InputState createState()=> InputState();
}
class InputState extends State<Halaman_Input>{
  final formKey = GlobalKey<FormState>();
  String _deviceid = 'Unknown';

  final format = DateFormat("yyyy-MM-dd HH:mm");

  bool _value2 = false;
  void _onChanged2(bool value) => setState(() => _value2 = value);

  StreamController<String>judulStreamController;


  TextEditingController controllerjudul = new TextEditingController();
  TextEditingController controllerdeskripsi = new TextEditingController();
  TextEditingController controllertanggal = new TextEditingController();



  void addData(){
    var url="http://adityo.xyz/jatis/jatis_tambahdata.php";

   http.post(url, body: {
      "judul": controllerjudul.text,
      "deskripsi": controllerdeskripsi.text,
      "tanggal" : controllertanggal.text,
      "device_id":_deviceid

    });

    print(http.Response);
  }

  @override
  void initState() {
    super.initState();
    initDeviceId();
    judulStreamController = StreamController<String>.broadcast();
    controllerjudul.addListener((){
      judulStreamController.sink.add(controllerjudul.text.trim());
    });

  }

  
  @override
  void dispose(){
    super.dispose();
    judulStreamController.close();

  }
  
  Color getColor(String text){
    if(text == null){
      return Colors.blue;
    }
    if(text.isEmpty){
      return Colors.blue;
    }else if (text.isNotEmpty){
      return Colors.deepOrange;
    }else{
      return Colors.purpleAccent;
    }
  }




  Future<void> initDeviceId() async {
    String deviceid;

    deviceid = await DeviceId.getID;

    if (!mounted) return;

    setState(() {
      _deviceid = deviceid;
    });
    print(deviceid);
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
              child: new Text("Tambah Data succes"),
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
        title: Text('Note'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Container(

                    margin: EdgeInsets.only(right: 15,left: 15),
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'judul Tidak Boleh Kosong';
                        }
                        return null;

                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(

                    margin: EdgeInsets.only(right:15,left: 15),
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Keterangan Tidak Boleh Kosong';
                        }
                        return null;

                      },
                    ),
                  ),


                  SizedBox(height: 20,),
                 // Text('Basic date field (${format.pattern})'),
                  Container(
                    margin: EdgeInsets.only(right: 15,left: 15),
                    child: DateTimeField(
                      controller: controllertanggal,
                      decoration: InputDecoration(
                        //  prefixIcon: Icon(Icons.email,color: Colors.lightBlueAccent,),
                        hintText: 'Masukkan Tanggal dan Waktu',
                        //   hintStyle: TextStyle( color: Colors.blueAccent),
                        contentPadding: EdgeInsets.fromLTRB(20, 19, 20, 10),
                        border:  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Tanggal  Tidak Boleh Kosong';
                        }
                        return null;

                      },

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
                  SizedBox(height: 20,),
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
                            color: Colors.deepOrange,
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,

                              ),
                            ),
                            onPressed: () => Navigator.pop(context,false)
                        ),
                        StreamBuilder(
                          stream: judulStreamController.stream,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              color: getColor(snapshot.data),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return Halaman_Utama();
                                          }
                                      )
                                  );
                                  addData();
                                  _tampilkanalert();
                                }
                              },
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
import 'dart:html';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List uploadedImage;

  Future<void> _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          /*setState(() {
            uploadedImage = reader.result;
          });*/
          this.getFile(reader.result);
        });

        reader.onError.listen((fileEvent) {
          print('error');
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  Future<void> getFile(bytes) async {
    final excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table].maxCols);
      print(excel.tables[table].maxRows);
      for (var row in excel.tables[table].rows) {
        print("$row");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Hours'),
      ),
      body: Container(
        child: Center(
          child: FlatButton(
            color: Colors.green,
            onPressed: () {
              this._startFilePicker();
            },
            child: Text('tete'),
          ),
        ),
      ),
    );
  }
}

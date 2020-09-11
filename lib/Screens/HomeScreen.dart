import 'dart:html';
import 'dart:typed_data';
import 'package:city_hours/Util/FileUtil.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _summationHours;
  DateTime _dateNow;
  DateTime _hoursTotal;

  _HomeScreenState() {
    this._generateInitialTime();
  }

  void _generateInitialTime() {
    DateTime now = new DateTime.now();
    this._summationHours = new DateTime(now.year, now.month, now.day);
    this._dateNow = new DateTime(now.year, now.month, now.day);
    this._hoursTotal = this._dateNow.add(
      Duration(hours: 160),
    );
  }

  Future<void> _getFile() {
    this._generateInitialTime();
    FileUtil(
      resultCallBack: (Uint8List result) {
        this._getDataFromCSV(result);
      },
    );
  }

  Future<void> _getDataFromCSV(bytes) async {
    final excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        this._getHours(row: row);
      }
    }

    this._getDiff();
  }

  void _getHours({List<dynamic> row}) {
    if (row[0].toString().toLowerCase() == 'total') {
      return;
    }
    if (this._isRowRight(row: row) == false) {
      return;
    }

    this._summationHours = this._summationHours.add(
          Duration(
            hours: int.parse(row.last.toString().split(':')[0]),
            minutes: int.parse(row.last.toString().split(':')[1]),
            seconds: int.parse(row.last.toString().split(':')[2]),
          ),
        );

    final result = this._summationHours.difference(this._dateNow);
  }

  void _getDiff() {

    print(this._summationHours.toString());
    print(this._hoursTotal.toString());
    print(this._summationHours.difference(this._hoursTotal));
  }

  bool _isRowRight({List<dynamic> row}) {
    final lasIndex = row.last.toString();
    return lasIndex.contains(':');
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
              this._getFile();
            },
            child: Text('tete'),
          ),
        ),
      ),
    );
  }
}

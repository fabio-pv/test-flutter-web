import 'dart:html';
import 'dart:typed_data';
import 'package:city_hours/Util/FileUtil.dart';
import 'package:city_hours/Util/MessageUtil.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List _uint8list;
  DateTime _summationHours;
  DateTime _dateNow;
  DateTime _hoursTotal;
  String _fileName;
  DateTime _initialDate;
  DateTime _finalDate;
  String _dateToShow;
  String _hoursCalcTotal;
  String _hoursCalcDiff;

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
      resultCallBack: (Uint8List result, String fileName) {
        setState(() {
          this._fileName = fileName;
          this._uint8list = result;
        });
      },
    );
  }

  Future<void> _getDataFromCSV() async {
    if (this._uint8list == null) {
      MessageUtil.simple(
        context: context,
        title: 'Verifique os campos',
        text: 'Por favor escolha uma arquivo para ser importado',
      );
      return;
    }

    if (this._initialDate == null) {
      MessageUtil.simple(
        context: context,
        title: 'Verifique os campos',
        text: 'Por favor escolha um período de data para a importação',
      );
      return;
    }

    final excel = Excel.decodeBytes(this._uint8list);

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

    if (this._isSameRange(row: row) == false) {
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

    setState(() {
      this._hoursCalcTotal = result.toString().split('.')[0];
    });
  }

  void _getDiff() {
    final result = this._summationHours.difference(this._hoursTotal);

    setState(() {
      this._hoursCalcDiff = result.toString().split('.')[0];
    });
  }

  bool _isRowRight({List<dynamic> row}) {
    final lasIndex = row.last.toString();
    return lasIndex.contains(':');
  }

  bool _isSameRange({
    List<dynamic> row,
  }) {
    final dateCompare = DateTime.parse(row[2]);

    final before = this._initialDate.isBefore(dateCompare);
    final after = this._finalDate.isAfter(dateCompare);

    return before && after;
  }

  Future<void> _showDateRange() async {
    final dateNow = DateTime.now();
    final initialLastDate = new DateTime(
      dateNow.year,
      dateNow.month + 1,
      dateNow.day,
    );

    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: dateNow,
        initialLastDate: initialLastDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2040));
    if (picked != null && picked.length == 2) {
      setState(() {
        this._initialDate = picked[0];
        this._finalDate = picked[1];
        this._dateToShow = (DateFormat('dd/MM/yyyy')).format(picked[0]) +
            ' até ' +
            (DateFormat('dd/MM/yyyy')).format(picked[1]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('City Hours'),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: 300,
              width: double.maxFinite,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      this._hoursCalcTotal ?? '--:--:--',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      this._hoursCalcDiff ?? '--:--:--',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total de horas excedidas',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.2),
              child: Card(
                elevation: 3,
                child: Container(
                  width: 400,
                  height: 220,
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_file),
                          SizedBox(
                            width: 20,
                          ),
                          FlatButton(
                            onPressed: () {
                              this._getFile();
                            },
                            child: Center(
                              child: Text(this._fileName ??
                                  'Clique aqui para escolher um arquivo'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(
                            width: 20,
                          ),
                          FlatButton(
                            onPressed: this._showDateRange,
                            child: Center(
                              child: Text(
                                this._dateToShow ??
                                    'Clique aqui para definir uma data',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            onPressed: this._getDataFromCSV,
                            color: Theme.of(context).accentColor,
                            child: Center(
                              child: Text(
                                'Importar',
                                style:
                                    Theme.of(context).textTheme.button.copyWith(
                                          color: Colors.white,
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MessageUtil {
  static Future<dynamic> simple({
    context,
    title,
    text,
  }) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static Future<dynamic> simpleWithNavigator({
    context,
    title,
    text,
    String route,
  }) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () {
                  Navigator.pushNamed(context, route);
                },
              ),
            ],
          );
        });
  }

  static Future<dynamic> simpleWithCallback({
    context,
    title,
    text,
    Function onPressYes,
    Function onPressNo,
  }) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Não'),
                onPressed: () {
                  onPressNo();
                },
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () {
                  onPressYes();
                },
              ),
            ],
          );
        });
  }
}

import 'dart:html';

import 'package:city_hours/Util/DropzoneFile/BackgroundDropzoneFile/BackgroundDropzoneFile.dart';
import 'package:city_hours/Util/DropzoneFile/BackgroundDropzoneFile/DragBackgroundDropzoneFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class DropzoneFile extends StatefulWidget {
  @override
  _DropzoneFileState createState() => _DropzoneFileState();
}

class _DropzoneFileState extends State<DropzoneFile> {
  int event = 1;
  List<File> files = [];

  void _changeEvent({@required int newEvent}) {
    setState(() {
      this.event = newEvent;
    });
  }

  void _getFiles({@required File file}) {
    setState(() {
      this.files.add(file);
    });
    this._changeEvent(
      newEvent: BackgroundDropzoneFile.FILE_EVENT,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: 300,
        height: 200,
        child: Stack(
          children: [
            DropzoneView(
              operation: DragOperation.copy,
              cursor: CursorType.grab,
              onLoaded: () => print('Zone loaded'),
              onError: (ev) => print('Error: $ev'),
              onHover: () {
                this._changeEvent(
                  newEvent: BackgroundDropzoneFile.DROP_EVENT,
                );
              },
              onDrop: (ev) {
                this._getFiles(
                  file: ev,
                );
              },
              onLeave: () {
                this._changeEvent(newEvent: BackgroundDropzoneFile.DRAG_EVENT);
              },
            ),
            BackgroundDropzoneFile(
              event: this.event,
              files: this.files,
            ),
          ],
        ),
      ),
    );
  }
}

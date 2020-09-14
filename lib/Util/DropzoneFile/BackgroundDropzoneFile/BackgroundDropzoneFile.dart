import 'dart:html';

import 'package:city_hours/Util/DropzoneFile/BackgroundDropzoneFile/DragBackgroundDropzoneFile.dart';
import 'package:city_hours/Util/DropzoneFile/BackgroundDropzoneFile/DropBackgroundDropzoneFile.dart';
import 'package:city_hours/Util/DropzoneFile/BackgroundDropzoneFile/FileBackgroundDropzoneFile.dart';
import 'package:flutter/material.dart';

class BackgroundDropzoneFile extends StatelessWidget {
  static const int DRAG_EVENT = 1;
  static const int DROP_EVENT = 2;
  static const int FILE_EVENT = 3;
  final int event;
  final List<File> files;

  BackgroundDropzoneFile({
    this.event = 1,
    this.files,
  });

  @override
  Widget build(BuildContext context) {
    if (this.event == DRAG_EVENT) {
      return DragBackgroundDropzoneFile();
    }

    if (this.event == DROP_EVENT) {
      return DropBackgroundDropzoneFile();
    }

    if (this.event == FILE_EVENT) {
      return FileBackgroundDropzoneFile(
        files: this.files,
      );
    }
  }
}

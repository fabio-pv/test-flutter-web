import 'dart:html';

import 'package:city_hours/Util/DropzoneFile/BackgroundDropzoneFile/ElementFileBackgroundDropzoneFile.dart';
import 'package:flutter/material.dart';

class FileBackgroundDropzoneFile extends StatelessWidget {
  final List<File> files;

  FileBackgroundDropzoneFile({@required this.files});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: this.files.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          print(this.files[index].name);
          return ElementFileBackgroundDropzoneFile(
            file: this.files[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20,
          );
        },
      ),
    );
  }
}

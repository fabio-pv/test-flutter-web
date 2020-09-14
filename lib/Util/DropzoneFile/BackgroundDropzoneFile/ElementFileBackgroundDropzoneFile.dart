import 'dart:html';

import 'package:city_hours/Util/DropzoneFile/BackgroundDropzoneFile/IconElementFileBackgroundDropzoneFile.dart';
import 'package:flutter/material.dart';

class ElementFileBackgroundDropzoneFile extends StatelessWidget {
  final File file;

  ElementFileBackgroundDropzoneFile({@required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconElementFileBackgroundDropzoneFile(
              fileName: this.file.name,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.file.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

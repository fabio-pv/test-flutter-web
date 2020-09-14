import 'dart:html';

import 'package:city_hours/Util/DropzoneFile/DropzoneFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class TestFile extends StatelessWidget {
  static const String ROUTE = 'test-file';

  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DropzoneFile(),
    );
  }
}

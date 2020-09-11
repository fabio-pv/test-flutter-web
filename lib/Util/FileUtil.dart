import 'dart:html';

import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class FileUtil {
  ResultCallBack resultCallBack;

  FileUtil({
    @required this.resultCallBack,
  }) {
    this.singleFile();
  }

  Future<void> singleFile() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          this.resultCallBack(reader.result);
        });

        reader.onError.listen((fileEvent) {
          print('error');
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }
}

typedef ResultCallBack = void Function(Uint8List uint8list);

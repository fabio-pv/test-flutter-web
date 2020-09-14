import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconElementFileBackgroundDropzoneFile extends StatelessWidget {
  static const Map<String, String> icons = {
    'csv': 'file-delimited-outline',
    'xlsx': 'microsoft-excel',
    'txt': 'note-text-outline',
  };

  final String fileName;

  IconElementFileBackgroundDropzoneFile({@required this.fileName});

  String _getIcon() {
    final extension = this.fileName.split('.').last;
    return icons[extension];
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      MdiIcons.fromString(this._getIcon()),
      size: 40,
      color: Colors.grey,
    );
  }
}

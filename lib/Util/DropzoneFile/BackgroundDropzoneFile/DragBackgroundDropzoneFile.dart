import 'package:flutter/material.dart';

class DragBackgroundDropzoneFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.attach_file,
            size: 40,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Arraste seus arquivos aqui',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

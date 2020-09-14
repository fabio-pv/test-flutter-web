import 'package:flutter/material.dart';

class DropBackgroundDropzoneFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.insert_drive_file,
            size: 40,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Agora você pode soltar eles',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImage extends StatelessWidget {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera),
                onPressed: () async {
                  final result =
                      await picker.getImage(source: ImageSource.camera);
                  Navigator.of(context).pop(File(result.path));
                },
              ),
              Text('Camera'),
              IconButton(
                icon: Icon(Icons.image),
                onPressed: () async {
                  final result =
                      await picker.getImage(source: ImageSource.gallery);
                  Navigator.of(context).pop(File(result.path));
                },
              ),
              Text('Gallery'),
            ],
          ),
        ],
      ),
    );
  }
}

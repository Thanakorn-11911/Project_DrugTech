import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDataScreen extends StatefulWidget {
  AddDataScreen({Key key}) : super(key: key);

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _Cname = TextEditingController();
  TextEditingController _Pname = TextEditingController();
  //TextEditingController _shape = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future getImagefromcamera() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagefromgallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String _selected1;
  String _selected2;
  String _selected3;
  List<Map> _myJson = [
    {'id': '1', 'image': 'images/shape/diamond.png', 'name': 'Diamond'},
    {'id': '2', 'image': 'images/shape/oblong.png', 'name': 'Oblong'},
    {'id': '3', 'image': 'images/shape/oval.png', 'name': 'Oval'},
    {'id': '4', 'image': 'images/shape/round.png', 'name': 'Round'},
    {'id': '5', 'image': 'images/shape/square.png', 'name': 'Square'},
    {'id': '6', 'image': 'images/shape/triangle.png', 'name': 'Triangle'},
  ];

  List<Map> _mySize = [
    {'id': '1', 'name': 'not specified'},
    {'id': '2', 'name': 'Small (< 0.1 cm)'},
    {'id': '3', 'name': 'Middle (1.0 - 2.0 cm)'},
    {'id': '4', 'name': 'Large (> 2.0 cm)'},
  ];

  List<Map> _myStatus = [
    {'id': '1', 'name': 'not specified'},
    {'id': '2', 'name': 'Entoll'},
    {'id': '3', 'name': 'revocation'},
    {'id': '4', 'name': 'Change form'},
    {'id': '5', 'name': 'Change manufacturer'},
    {'id': '6', 'name': 'Discontinued'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalkey,
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  imageProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  commonNameTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  productNameTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  dropListShape(),
                  SizedBox(
                    height: 20,
                  ),
                  dropListSizeAndStatus(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage('assets/drugtest.jpg'),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
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
                onPressed: getImagefromcamera,
              ),
              Text('Camera'),
              IconButton(
                icon: Icon(Icons.image),
                onPressed: getImagefromgallery,
              ),
              Text('Gallery'),
            ],
          ),
        ],
      ),
    );
  }

  Widget commonNameTextField() {
    return TextFormField(
      controller: _Cname,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Brand name",
        helperText: "Common Name can't be empty",
        hintText: "Dev Stack",
      ),
    );
  }

  Widget productNameTextField() {
    return TextFormField(
      controller: _Pname,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Generic name",
        helperText: "Product Name can't be empty",
        hintText: "Dev Stack",
      ),
    );
  }

  Widget dropListShape() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  hint: Text('Select Shape'),
                  value: _selected1,
                  onChanged: (newValue) {
                    setState(() {
                      _selected1 = newValue;
                    });
                  },
                  items: _myJson.map((shapeItem) {
                    return DropdownMenuItem(
                      value: shapeItem['id'].toString(),
                      child: Row(
                        children: [
                          Image.asset(
                            shapeItem['image'],
                            width: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(shapeItem['name']),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropListSizeAndStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton(
          hint: Text('Select Sized'),
          value: _selected2,
          onChanged: (newValue) {
            setState(() {
              _selected2 = newValue;
            });
          },
          items: _mySize.map((sizeItem) {
            return DropdownMenuItem(
              value: sizeItem['id'].toString(),
              child: Text(sizeItem['name']),
            );
          }).toList(),
        ),
        Container(
          width: 150,
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Select Status'),
            value: _selected3,
            onChanged: (newValue) {
              setState(() {
                _selected3 = newValue;
              });
            },
            items: _myStatus.map((statusItem) {
              return DropdownMenuItem(
                value: statusItem['id'].toString(),
                child: Text(statusItem['name']),
              );
            }).toList(),
          ),
        )
      ],
      // children: [
      //   //size
      //   Padding(
      //     padding: EdgeInsets.only(left: 1, right: 1),
      //     child: DropdownButton(
      //       hint: Text('Select Sized'),
      //       value: _selected,
      //       onChanged: (newValue) {
      //         setState(() {
      //           _selected = newValue;
      //         });
      //       },
      //       items: _mySize.map((sizeItem) {
      //         return DropdownMenuItem(
      //           value: sizeItem['id'].toString(),
      //           child: Text(sizeItem['name']),
      //         );
      //       }).toList(),
      //     ),
      //   ),
      //   SizedBox(
      //     width: 10,
      //   ),
      //   // status
      //   Padding(
      //     padding: EdgeInsets.only(right: 50),
      //     child: DropdownButton(
      //       hint: Text('Select Status'),
      //       value: _selected,
      //       onChanged: (newValue) {
      //         setState(() {
      //           _selected = newValue;
      //         });
      //       },
      //       items: _myStatus.map((statusItem) {
      //         return DropdownMenuItem(
      //           value: statusItem['id'].toString(),
      //           child: Text(statusItem['name']),
      //         );
      //       }).toList(),
      //     ),
      //   )
      // ],
    );
  }
}

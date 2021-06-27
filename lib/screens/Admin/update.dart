import 'dart:io';

import 'package:ddd/Model/drug.dart';
import 'package:ddd/services/constants.dart';
import 'package:ddd/services/db.dart';
import 'package:ddd/shared/getImage.dart';
import 'package:ddd/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key key, this.data, this.id}) : super(key: key);
  final Drugs data;
  final String id;

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    drugss = widget.data.copyWith();
  }

  List<File> image = [];
  Drugs drugss = Drugs();

  List<Map> _myJson = [
    {'id': '1', 'image': 'images/shape/diamond.png', 'name': 'Diamond'},
    {'id': '2', 'image': 'images/shape/oblong.png', 'name': 'Oblong'},
    {'id': '3', 'image': 'images/shape/oval.png', 'name': 'Oval'},
    {'id': '4', 'image': 'images/shape/round.png', 'name': 'Round'},
    {'id': '5', 'image': 'images/shape/square.png', 'name': 'Square'},
    {'id': '6', 'image': 'images/shape/triangle.png', 'name': 'Triangle'},
  ];

  List<Map> _mySize = [
    {'id': '1', 'name': 'ไม่ระบุ'},
    {'id': '2', 'name': 'Small (< 0.1 cm)'},
    {'id': '3', 'name': 'Middle (1.0 - 2.0 cm)'},
    {'id': '4', 'name': 'Large (> 2.0 cm)'},
  ];

  List<Map> _myStatus = [
    {'id': '1', 'name': 'ไม่ระบุ'},
    {'id': '2', 'name': 'ขึ้นทะเบียน'},
    {'id': '3', 'name': 'เพิกถอนทะเบียน'},
    {'id': '4', 'name': 'เปลี่ยนรูปแแบบ'},
    {'id': '5', 'name': 'เปลี่ยนผู้ผลิต'},
    {'id': '6', 'name': 'เลิกผลิต'},
  ];

  List<Map> _myType = [
    {'id': '1', 'name': 'ไม่ระบุ'},
    {'id': '2', 'name': 'ยาสามัญ'},
    {'id': '3', 'name': 'ยาสามัญประจำบ้าน'},
    {'id': '4', 'name': 'ยาอันตราย'},
    {'id': '5', 'name': 'ยาควบคุมพิเศษ'},
    {'id': '6', 'name': 'ยาออกฤทธิ์ต่อจิตและประสาท ประเภท 1'},
    {'id': '7', 'name': 'ยาออกฤทธิ์ต่อจิตและประสาท ประเภท 2'},
    {'id': '8', 'name': 'ยาออกฤทธิ์ต่อจิตและประสาท ประเภท 3'},
    {'id': '9', 'name': 'ยาออกฤทธิ์ต่อจิตและประสาท ประเภท 4'},
    {'id': '10', 'name': 'ยาเสพติด ประเภท 1'},
    {'id': '11', 'name': 'ยาเสพติด ประเภท 2'},
    {'id': '12', 'name': 'ยาเสพติด ประเภท 3'},
    {'id': '13', 'name': 'ยาเสพติด ประเภท 4'},
    {'id': '14', 'name': 'ยาเสพติด ประเภท 5'},
    {'id': '15', 'name': 'ยาแผนโบราณ'},
    {'id': '16', 'name': 'ผลิตภัณฑ์เสริมอาหาร'},
  ];

  List<Map> _myDrugRegistrationType = [
    {'id': '1', 'name': 'ไม่ระบุ'},
    {'id': '2', 'name': 'ทะเบียนยาสำหรับมนุษย์ชนิดแคปซูล'},
    {'id': '3', 'name': 'ทะเบียนยาสำหรับมนุษย์ชนิดเม็ด'},
    {'id': '4', 'name': 'ทะเบียนยาสำหรับสัตว์ชนิดเม็ดและแคปซูล'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update" + "\t" + widget.data.brandName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                letterTextField(),
                SizedBox(
                  height: 20,
                ),
                dropdowmListDrugType(),
                SizedBox(
                  height: 20,
                ),
                DrugRegistrationType(),
                SizedBox(
                  height: 20,
                ),
                benefitTextField(),
                SizedBox(
                  height: 20,
                ),
                aboutTextField(),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  children: [
                    for (var i = 0; i < drugss.images.length; i++)
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.4)),
                          margin: EdgeInsets.only(left: 5, bottom: 5),
                          height: 60,
                          width: 60,
                          child: Stack(
                            children: [
                              Image.network(
                                drugss.images[i],
                                fit: BoxFit.fitHeight,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.minusCircle,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      drugss.images.removeAt(i);
                                    });
                                  },
                                ),
                              )
                            ],
                          )),
                    for (var i = 0; i < image.length; i++)
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.4)),
                          margin: EdgeInsets.only(left: 5, bottom: 5),
                          height: 60,
                          width: 60,
                          child: Stack(
                            children: [
                              Image.file(
                                image[i],
                                fit: BoxFit.fitHeight,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.minusCircle,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      image.removeAt(i);
                                    });
                                  },
                                ),
                              )
                            ],
                          )),
                    InkWell(
                      onTap: () async {
                        final data = await showModalBottomSheet(
                            context: context,
                            builder: (cxt) {
                              return GetImage();
                            });
                        if (data != null) {
                          setState(() {
                            image.add(data as File);
                          });
                        }
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        color: navigationColor,
                        child: Icon(
                          FontAwesomeIcons.plusCircle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        //&& images.length > 0
                        loading(context);

                        for (var i = 0; i < image.length; i++) {
                          String urlImage = await dbService()
                              .loadFile(image[i], path: "drugimage");
                          if (urlImage != null) drugss.images.add(urlImage);
                        }

                        bool update =
                            await dbService().updateDrugs(drugss, widget.id);
                        print("\n\n");
                        print(update);
                        print("\n\n");
                        if (update) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text(
                      "Submit",
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(navigationColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonNameTextField() {
    return TextFormField(
      initialValue: widget.data.brandName,
      validator: (e) => e.isEmpty ? "Please enter your commonname" : null,
      onChanged: (e) => drugss.brandName = e,
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
          color: Color(0xFF2962FF),
        ),
        labelText: "Brand name",
        helperText: "Common Name can't be empty",
        hintText: "Dev Stack",
      ),
    );
  }

  Widget productNameTextField() {
    return TextFormField(
      initialValue: widget.data.genericName,
      validator: (e) => e.isEmpty ? "Please enter your genericname" : null,
      onChanged: (e) => drugss.genericName = e,
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
          color: Color(0xFF2962FF),
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
                  value: drugss.shapeId,
                  onChanged: (e) => drugss.shapeId = e,
                  items: _myJson.map((shapeItem) {
                    return DropdownMenuItem(
                      value: shapeItem['name'].toString(),
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
          value: drugss.sizedId,
          onChanged: (e) => drugss.sizedId = e,
          items: _mySize.map((sizeItem) {
            return DropdownMenuItem(
              value: sizeItem['name'].toString(),
              child: Text(sizeItem['name']),
            );
          }).toList(),
        ),
        Container(
          width: 150,
          child: DropdownButton(
            isExpanded: true,
            hint: Text('Select Status'),
            value: drugss.statusId,
            onChanged: (e) => drugss.statusId = e,
            items: _myStatus.map((statusItem) {
              return DropdownMenuItem(
                value: statusItem['name'].toString(),
                child: Text(statusItem['name']),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget letterTextField() {
    return TextFormField(
      initialValue: widget.data.letter,
      validator: (e) => e.isEmpty ? "Please enter your letter" : null,
      onChanged: (e) => drugss.letter = e,
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
          color: Color(0xFF2962FF),
        ),
        labelText: "Letter",
        helperText: "Letter can't be empty",
        hintText: "Dev Stack",
      ),
    );
  }

  Widget dropdowmListDrugType() {
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
                  hint: Text('Select drug type'),
                  value: drugss.drugTypeId,
                  onChanged: (e) => drugss.drugTypeId = e,
                  items: _myType.map((typeItem) {
                    return DropdownMenuItem(
                      value: typeItem['name'].toString(),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(typeItem['name']),
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

  Widget DrugRegistrationType() {
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
                  hint: Text('Select drug registration type'),
                  value: drugss.drugRegistrationTypeId,
                  onChanged: (e) => drugss.drugRegistrationTypeId = e,
                  items: _myDrugRegistrationType.map((DRTtypeItem) {
                    return DropdownMenuItem(
                      value: DRTtypeItem['name'].toString(),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(DRTtypeItem['name']),
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

  Widget benefitTextField() {
    return TextFormField(
      initialValue: widget.data.benefit,
      onSaved: (String benefit) {},
      validator: (e) => e.isEmpty ? "Please enter your letter" : null,
      onChanged: (e) => drugss.benefit = e,
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
          color: Color(0xFF2962FF),
        ),
        labelText: "Benefit",
        helperText: "Benefit can't be empty",
        hintText: "Dev Stack",
      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      initialValue: widget.data.description,
      onSaved: (String description) {},
      validator: (e) => e.isEmpty ? "Please enter your letter" : null,
      onChanged: (e) => drugss.description = e,
      maxLines: 4,
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
        labelText: "About",
        helperText: "Write about yourself",
        hintText: "I am Dev Stack",
      ),
    );
  }
}

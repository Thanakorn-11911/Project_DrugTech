import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd/Model/drug.dart';
import 'package:ddd/screens/Admin/detail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TFLITEPage extends StatefulWidget {
  TFLITEPage({Key key}) : super(key: key);

  @override
  _TFLITEPageState createState() => _TFLITEPageState();
}

class _TFLITEPageState extends State<TFLITEPage> {
  final CollectionReference drugscol =
      FirebaseFirestore.instance.collection("drugs");
  File PickedImage;
  bool isImageLoaded = false;

  List _result;

  String _confidence = "";
  String _name = "";

  getImageGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      PickedImage = File(tempStore.path);
      isImageLoaded = true;
    });
    applyModelOnImage(PickedImage);
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 19,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _result = res;
      print(_result);

      String str = _result[0]['label'];

      _name = str.split('.').last;
      _confidence = _result != null
          ? (_result[0]['confidence'] * 100.0).toString() + "%"
          : "";
    });
  }

  loadModel() async {
    var resultant = await Tflite.loadModel(
        model: "assets/model/model_unquant.tflite",
        labels: "assets/model/labels.txt");
    print("result after loading model: $resultant");
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((val) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Classification"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            isImageLoaded
                ? Center(
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(PickedImage.path)),
                            fit: BoxFit.contain),
                      ),
                    ),
                  )
                : Container(),
            Text("Name : $_name\nConfidence: $_confidence"),
            if (_name != null && _name.isNotEmpty)
              FutureBuilder<QuerySnapshot>(
                  future: drugscol.get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final dataList = snapshot.data?.docs
                        ?.map((d) =>
                            Drugs.fromJson(d.data() as Map<String, dynamic>))
                        ?.where((d) =>
                            d.brandName.toLowerCase() ==
                            _name.trim().toLowerCase());
                    return TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => Detail(
                                  test:
                                      (dataList != null && dataList.isNotEmpty)
                                          ? dataList.first
                                          : null)));
                        },
                        child: Text("more detail"));
                  }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImageGallery();
        },
        child: Icon(Icons.photo_album),
      ),
    );
  }
}
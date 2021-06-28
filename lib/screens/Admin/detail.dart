import 'package:ddd/Model/drug.dart';
import 'package:ddd/services/constants.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({
    Key key,
    this.test,
  }) : super(key: key);

  final Drugs test;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    if (widget.test == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1B5E20),
        ),
        body: Center(
          child: Text("not found!"),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black26),
            child: widget.test.images.isNotEmpty
                ? Ink.image(
                    height: 400,
                    image: NetworkImage("${widget.test.images[0]}"),
                    fit: BoxFit.fitWidth,
                  )
                : null,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.test.brandName ?? '',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        widget.test.genericName ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontFamily: 'Avenir',
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.test.statusId ?? '',
                                  style: TextStyle(
                                      color: Color(0xFF1B5E20),
                                      fontFamily: 'Avenir',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                Text(
                                  //"Type",
                                  widget.test.drugTypeId ?? '',
                                  style: TextStyle(
                                      fontFamily: 'Avenir',
                                      fontSize: 12.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  //"registype",
                                  widget.test.drugRegistrationTypeId ?? '',
                                  style: TextStyle(
                                      fontFamily: 'Avenir',
                                      fontSize: 12.0,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                //"shape",
                                widget.test.shapeId ?? '',
                                style: TextStyle(
                                    color: Color(0xFF1B5E20),
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                widget.test.sizedId ?? '',
                                style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontSize: 12.0,
                                    color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        "Benefit".toUpperCase(),
                        style: TextStyle(
                            color: Color(0xFF1B5E20),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.test.benefit ?? '',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Description".toUpperCase(),
                        style: TextStyle(
                            color: Color(0xFF1B5E20),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.test.description ?? '',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0),
                      ),
                      const SizedBox(height: 50.0),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 25,
                          color: Color(0xFF1B5E20),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        height: 150,
                        padding: EdgeInsets.only(left: 32.0),
                        child: ListView.builder(
                            itemCount: widget.test.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    widget.test.images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: -300,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "DETAIL",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

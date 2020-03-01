import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageScreen extends StatelessWidget{
  Widget makeSlider() {

  //diplay in slider view

    /*return SizedBox(
        height: 200.0,
        width: 350.0,
        child: Carousel(
          images: [
            ListView.builder(itemBuilder: (context,index){
              return ImageGridItem(index+1);
            }),
          ],
          boxFit: BoxFit.cover,
          dotSize: 5.0,
          dotSpacing: 15.0,
          dotColor: Colors.lightGreenAccent,
          indicatorBgPadding: 5.0,
          borderRadius: false,
          autoplay: true,
        )
    );*/
    return Container(
      height: 300.0,
      child: CarouselSlider(
        items: <Widget>[
          GridView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1),
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ImageGridItem(index+1),
                );
              }),
        ],
        height: 400.0,
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        autoPlay: true,
        scrollDirection: Axis.horizontal,
        autoPlayInterval: Duration(seconds: 3),
        reverse: false,
      ),
    );
    /*return CarouselSlider(

      items: <Widget>[
    GridView.builder(
    itemCount: 5,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (context, index) {
          return ImageGridItem(index+1);
        }),
        ],
      height: 200.0,

      autoPlayAnimationDuration: Duration(milliseconds: 1000),
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      reverse: false,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
      body: Container(
        child: makeSlider(),
      ),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  int _index;

  ImageGridItem(int index) {
    this._index=index;
  }

  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<ImageGridItem> {
  Uint8List imageFile;

  StorageReference storageReference =
      FirebaseStorage.instance.ref().child("sliderimages");

  getImage() async {
    int maxSize = 7 * 1024 * 1024;
    storageReference
        .child("image_${widget._index}.jpg")
        .getData(maxSize)
        .then((data) {
      this.setState(() {
        imageFile = data;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Widget decideGridTileWidget() {
    if (imageFile == null) {
      return Center(child: Text("No Data"));
    } else {
      return Image.memory(
        imageFile,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridTile(child: decideGridTileWidget());
  }

}

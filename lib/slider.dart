import 'package:couponapp/listView.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SliderImages extends StatefulWidget {
  @override
  _SliderImagesState createState() => _SliderImagesState();
}
class _SliderImagesState extends State<SliderImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('slider').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildSlider(context, snapshot.data.documents);
        });
  }

  Widget _buildSlider(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildSliderItem(context, data)).toList());
  }
  Widget _buildSliderItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    /*return Container(
      height: 200.0,
      child: new Carousel(
        images: [
          Image.network(record.image1),
          Image.network(record.image2),
          Image.network(record.image3),
        ],
        autoplay: true,
        autoplayDuration: Duration(seconds: 4),
        animationDuration: Duration(milliseconds: 1000),
        indicatorBgPadding: 3.0,
        boxFit: BoxFit.cover,
      ),
    );*/

    /*return Container(
      height: 800.0,
      child: ListView(
        children: <Widget>[
          imagecarousel,
          Container(
            height:500.0,
            child: NListView(),
          ),
        ],
      ),
    );*/
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
        Container(
        height: 200.0,
        child: Carousel(
          images: [
            Image.network(record.image1),
            Image.network(record.image2),
            Image.network(record.image3),
          ],
          autoplay: true,
          autoplayDuration: Duration(seconds: 4),
          animationDuration: Duration(milliseconds: 1000),
          indicatorBgPadding: 3.0,
          boxFit: BoxFit.cover,
        ),
        ),

        Container(
          height:500.0,
          child: NListView(),
        )
        ],
      ),
    );
  }
}
class Record {
  final String image1;
  final String image2;
  final String image3;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map,{this.reference})
      :/*assert(map['image'] != null),*/
        image1 = map['image1'],
        image2=map['image2'],
        image3=map['image3'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$image1,$image2,$image3>";
}

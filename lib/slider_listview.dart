import 'package:couponapp/slider_images.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'coupon_list.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirstFragment extends StatefulWidget {
  @override
  FirstFragmentState createState()=>FirstFragmentState();
}
class FirstFragmentState extends State<FirstFragment> {
  @override
  /*Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }*/
  /*slider_images()
  {
    Future _getImageUrl() async {
      final Future<StorageReference> ref =
      FirebaseStorage.instance.getReferenceFromUrl('gs://coupondemo.appspot.com/sliderimages');
      dynamic url = await ref.then((doc) => doc.getDownloadURL());
      print(url);
    }*/
  /* StorageReference storageReference=FirebaseStorage.instance.ref().child("sliderimages");
    String _imageUrl;

    void initState() {
      super.initState();

      var ref = FirebaseStorage.instance.ref().child("sliderimages");
      ref.getDownloadURL().then((loc) => setState(() => _imageUrl = loc));
    }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //slider_images();
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/discount2.jpg'),
          AssetImage('images/discount3.jpg'),
          AssetImage('images/discount4.jpg'),
        ],
        autoplay: true,
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          image_carousel,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              'Recent Discount',
              style: TextStyle(fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.red),),
          ),
          Container(
            height: 320.0,
            // child: Coupons(),
            child: CouponsList(),
          )
        ],
      ),
    );
  }
}
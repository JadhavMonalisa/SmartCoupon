import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

//import 'package:share/share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_card/expandable_card.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'coupondetails.dart';

class InformationImage extends StatefulWidget{
  final shareName;
  final shareImage;
  final shareOldPrice;
  final shareNewPrice;
  final shareShortDescription;
  final shareLongDescription;
  final shareImages;
  final imagesLen;

  /*final shareImage1;
  final shareImage2;
  final shareImage3;*/
  final shareTerms;
  final shareLocation;

  //final shareImgLocation;

  InformationImage({
    this.shareName,
    this.shareImage,
    this.shareOldPrice,
    this.shareNewPrice,
    this.shareShortDescription,
    this.shareLongDescription,
    this.shareImages,
    //this.shareImgLocation,

    /*this.shareImage1,
    this.shareImage2,
    this.shareImage3,*/
    this.shareTerms,
    this.shareLocation,
    this.imagesLen,
  });

  @override
  _InformationImageState createState() => _InformationImageState();
}

class _InformationImageState extends State<InformationImage> {
  int id ;
  int _current = 0;

  List<String> imgList = new List();
  List<String> imgDirection=new List();

  //Map<String, String>list = new HashMap();
  List<Widget> images;

  @override
  Widget build(BuildContext context) {
    /*for(int i=0; i<widget.imagesLen;i++)
          {
            print('i=$i');
            for(int j=i; j<widget.shareImages[i]; j++)
              {
                  dynamic path=widget.shareImages[i];
                  imgList.add(path);
                  print('Image Path=$path');
              }
          }*/

    /*for(int i=0; i<widget.imagesLen;i++)
          {
            print('i=$i');
            for(int j=i; j<widget.imagesLen; j++)
              {
                  dynamic path=widget.shareImages[i];
                  imgList.add(path);
                  print('Image Path=$path');
              }
          }
*/

    for (int i = 0; i < widget.imagesLen; i++) {
      dynamic path = widget.shareImages[i];
      var _list = path.values.toList();
      //String path1 = widget.shareImages[_list[i]];
      imgList.add(_list[0]);
      imgDirection.add(_list[1]);
      print('Path=$path');
      print('Direction=$imgDirection');
    }

    /*for (int i = 0; i < widget.imagesLen; i++)
        {
          */ /*Map info=Map.from(widget.shareImages[i]);
          print('info:$info');
          String key=info.keys as String;
          print('key:$key');
*/ /*
        dynamic path = widget.shareImages[i];

          imgList.add(path);
          print('Path=$path');
        }*/
    /*var FirebaseDatabase;
    FirebaseDatabase.instance.reference().child('sliderImages')
        .orderByChild('direction')
        .equalTo('imgPath').once()
        .then((onValue) {
      Map data = onValue.value;
    });*/

    return Scaffold(
      appBar: AppBar(
        title: Text('Coupons'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Container(
                height: 230.0,
                child: Card(
                  child: GridTile(
                    child: Image.network(widget.shareImage),
                  ),
                ),
              ),
              ListTile(
                title: Center(
                    child: Text(
                      widget.shareName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
              Container(

                //decoration: BoxDecoration(border: Border.all(width: 1.0,color: Colors.blue),),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: CarouselSlider(

                      items: imgList.map((imgUrl)
                      {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                              ),
                              child: GestureDetector(

                                  child: Image.network(
                                    imgUrl,
                                    fit: BoxFit.fill,
                                  ),

                                  onTap: () {

                                    print('imgUrl=$imgUrl');
                                    print('index=$imgList.indexOf(imgUrl)');

                                    Navigator.push<Widget>(

                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CouponDetails(
                                              couponImage: imgUrl,
                                              couponUrl: imgDirection[imgList.indexOf(imgUrl)],
                                            ),
                                      ),

                                    );
                                  }),
                            );
                          },
                        );
                      }).toList(),

                      height: 100.0,
                      autoPlay: true,
                      reverse: true,
                      autoPlayInterval: Duration(seconds: 4),
                      viewportFraction: 0.4,
                    ),
                  ),
                ),
              ),

              ListTile(
                title: Text(widget.shareShortDescription),
              ),
              Divider(),
              new ListTile(
                title: Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    widget.shareLongDescription,
                  ),
                ),
              ),
              Divider(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                ),
                child: ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      Text(
                        ' Terms and Conditions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          15.0, 4.0, 7.0, 10.0),
                      child: Text(
                        widget.shareTerms,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.green,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Share Details',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        var request = await HttpClient()
                            .getUrl(Uri.parse(widget.shareImage));
                        var response = await request.close();
                        Uint8List bytes =
                        await consolidateHttpClientResponseBytes(response);
                        await Share.file(
                            'Share Details To', 'amlog.jpg', bytes,
                            'image/jpg',
                            text: widget.shareName +
                                "\n" +
                                'Details: ' +
                                widget.shareShortDescription +
                                "\n" +
                                'Description: ' +
                                widget.shareLongDescription.toString());
                      },
                    ),
                  ),

                  // to share location or get direction
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.blue,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Get Direction',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(
                              Icons.add_location,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      /**/
                        onPressed: () async {
                          /*Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                          String url=widget.shareLocation;
                          */
                          //const url = 'https://www.google.com/maps/dir/18.5682556,73.9006976/unitglo+solutions+pvt.+ltd/@18.5856899,73.7774599,12z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x3bc2b9b55a4da339:0x66c0eb5e7342ad04!2m2!1d73.793909!2d18.63904';
                          String url = widget.shareLocation;

                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

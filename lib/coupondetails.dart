import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class CouponDetails extends StatefulWidget {

  final couponImage;
  final couponUrl;

  CouponDetails({this.couponImage,this.couponUrl});

  @override
  _CouponDetailsState createState() => _CouponDetailsState();
}

class _CouponDetailsState extends State<CouponDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coupons'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70.0),
          child: ListView(
            children: <Widget>[
              Container(
                height: 230.0,
                child: Card(
                  child: GridTile(
                    child: Image.network(widget.couponImage),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Center(
                    child: RaisedButton(
                      color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        onPressed: () async {

                        //get current location
                          Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                         // Position position2 = await Geolocator().getCurrentPosition(locationPermissionLevel: widget.couponUrl);
                          print('Current Location=$position');

                          //Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
                          //get destination location
                          String url = widget.couponUrl;
                          print('Destination Location=$url');

                          /*String origin=url;
                          String destination=widget.couponUrl;
*/
                          //String getLocation=origin+destination;

                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                          /*void getLocation() async {
                            Position position = await Geolocator()
                                .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                            print(position);
                          }*/
                          /*String url = widget.couponUrl;
                          print('URL=$url');
                          *//*String origin='18.651132,73.839066';
                          String destination='18.640504,73.798118';
                          String url="https://www.google.com/maps/dir/?api=1&origin=" + origin + "&destination=" + destination + "&travelmode=driving&dir_action=navigate";*//*
                          if (await canLaunch(url)) {
                          await launch(url);
                          } else {
                          throw 'Could not launch $url';
                          }*/
                        },
                      child: Text('Get Location',style: TextStyle(color: Colors.white),),
                    )
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

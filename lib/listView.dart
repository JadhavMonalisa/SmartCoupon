import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'information_page.dart';

class NListView extends StatefulWidget {
  @override
  _NListViewState createState() => _NListViewState();
}

class _NListViewState extends State<NListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Coupon'),
      ),*/
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('couponDetails').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    int len=record._myList.length;
    print('length: $len');

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),

      child: Container(
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(5.0),
        ),

        child: Container(
          height: 100.0,
          width: 100.0,

          child: InkWell(
            child: Card(
              /*child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.white,
                      child:Image.network(record.image),
                    ),
                    title: Text(record.name,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),),
                    subtitle: Text(record.shortDescription,style:TextStyle(color: Colors.grey),),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.red,),
                  ),
                ],
              ),*/

              child: ListTile(
                leading: Container(
                  height: 100.0,
                    width: 100.0,
                    color: Colors.white,
                    child:Image.network(record.image),
                  ),
                title: Text(record.name,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),),
                subtitle: Text(record.shortDescription,style:TextStyle(color: Colors.grey),),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.red,),
                ),
            ),

              //pass details to inforamtion_page

              onTap:()=> Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> InformationImage(
                    shareName:record.name,
                    shareImage: record.image,
                    shareShortDescription: record.shortDescription,
                    shareLongDescription:record.longDescription,
                    shareImages:record._myList,
                    shareTerms:record.terms,
                    shareLocation:record.location,
                    imagesLen:len,
                  ))),
            ),
          ),
        ),
      );
  }
}

class Record {
  final String name;
  final String shortDescription;
  final String longDescription;
  final String image;
  //final String sliderImages;
  //final List<String> images=List.from(document['sliderImages']);
  //List<String> sliderImages;
  List<dynamic> _myList = new List();

  //Map<String,String> _myList=new Map();
  //Map<dynamic,dynamic> _myList=new Map();

  //List<String> imgLocation=new List();
  Map<dynamic, dynamic> responses = Map();
    //final String direction;
  final String terms;
  final String location;
  final DocumentReference reference;

  Record.fromMap(Map<String,dynamic> map, {this.reference})
      :/*assert(map['image'] != null),
        assert(map['shortDescription'] != null),
        assert(map['name'] != null),
*/
        image = map['image'],
        location=map['location'],
        longDescription = map['longDescription'],
        name = map['name'],
        shortDescription = map['shortDescription'],

        //sliderImages=map['sliderImages'],

        _myList=List.from(map['sliderImages']),

        terms=map['terms'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$image,$location,$longDescription,$name,$shortDescription,$_myList,$terms>";
}

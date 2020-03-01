import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class ShareDetails extends StatefulWidget {

  final share_name;
  final share_image;
  final share_old_price;
  final share_new_price;
  final share_description;

  ShareDetails({
    this.share_name,
    this.share_image,
    this.share_old_price,
    this.share_new_price,
    this.share_description
  });
  @override
  _ShareDetailsState createState() => _ShareDetailsState();
}

class _ShareDetailsState extends State<ShareDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Share Details'),

      ),

      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                child: Image.asset(widget.share_image),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(widget.share_name,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("\$${widget.share_old_price}",
                          style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Expanded(
                        child: new Text("\$${widget.share_new_price}",
                          style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),


          Row(
            children: <Widget>[
              Expanded(
                  child: FloatingActionButton(
                      elevation: 0.0,

                      child: new Icon(Icons.share),

                      onPressed: () async{
                        final ByteData bytes = await rootBundle.load(widget.share_image);

                        await Share.file('Share Details To','esys.png',bytes.buffer.asUint8List(),'images/png',

                            text: widget.share_name+
                                "\n"+'Old Price:'+widget.share_old_price+
                                "\n"+'Discounted Price: '+widget.share_new_price+
                                "\n"+'Description:'+widget.share_description
                        );
                      }),
                  /*child: Text('Share On WhatsApp',style:TextStyle(color: Colors.white),),
                  onPressed: () async {
                      //Share.share('check out my website https://example.com');
                    final ByteData bytes = await rootBundle.load(widget.share_image);
                    await Share.file('esys image','esys.png',bytes.buffer.asUint8List(),'images/png',

                        text: widget.share_name+
                            "\n"+'Old Price:'+widget.share_old_price+
                            "\n"+'Discounted Price: '+widget.share_new_price+
                            "\n"+'Description:'+widget.share_description
                    );
                  },*/

              )
            ],
          ),

          Divider(),

          new ListTile(

            title: Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,),),
            subtitle: Text(widget.share_description),
          ),
          Divider(),
        ],
      ),
    );
  }
}

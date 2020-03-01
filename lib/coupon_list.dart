import 'package:flutter/material.dart';
import 'share_details.dart';

class CouponsList extends StatefulWidget {
  @override
  _CouponsListState createState() => _CouponsListState();
}

class _CouponsListState extends State<CouponsList> {

  //String price1,price2,name,description;
  //var itemCount=0;

  final List items=[
    {
      'name':'Discount on Designer Dresses',
      'imgUrl':'images/dress1.jpg',
      'price1':'2000',
      'price2':'1599',
      'description':'Accentuate your beautiful self with designer one piece.'
    },
    {
      'name':'Discount on T-Shirt',
      'imgUrl':'images/tshirt1.jpg',
      'price1':'1000',
      'price2':'700',
      'description':'Accentuate your beautiful self with designer one piece.'
    },
    {
      'name':'Discount3',
      'imgUrl':'images/d1.jpg',
      'price1':'2000',
      'price2':'1799',
      'description':'Accentuate your beautiful self with designer one piece.'
    },
    {
      'name':'Discount1',
      'imgUrl':'images/d1.jpg',
      'price1':'100',
      'price2':'70',
      'description':'Accentuate your beautiful self with designer one piece.'
    },
    {
      'name':'Discount2',
      'imgUrl':'images/d1.jpg',
      'price1':'1000',
      'price2':'700',
      'description':'Accentuate your beautiful self with designer one piece.'
    },
    {
      'name':'Discount3',
      'imgUrl':'images/d1.jpg',
      'price1':'2000',
      'price2':'1799',
      'description':'Accentuate your beautiful self with designer one piece.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context,int index){
        return Discount(
          item_name:items[index]['name'],
          item_pic:items[index]['imgUrl'],
          item_price1:items[index]['price1'],
          item_price2:items[index]['price2'],
          item_description: items[index]['description'],
        );
      },
    );
  }
}
class Discount extends StatelessWidget{

  final item_name;
  final item_pic;
  final item_price1;
  final item_price2;
  final item_description;

  Discount({
    this.item_name,
    this.item_pic,
    this.item_price1,
    this.item_price2,
    this.item_description
  });

  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return Card(

      //---dispaly in listView---

      child: Container(
        decoration: new BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.grey,width: 15.0),
            top: BorderSide(color:Colors.grey,width: 10.0),
            right: BorderSide(color: Colors.grey,width: 5.0),
            bottom: BorderSide(color: Colors.grey,width: 3.0)
          ),
        ),
        child: GridTile(
          child: InkWell(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(

                  builder: (context)=>new ShareDetails(
                    share_name: item_name,
                    share_image: item_pic,
                    share_old_price: item_price1,
                    share_new_price: item_price2,
                    share_description:item_description,
                  )
              ),
            ),
            child: InkWell(
              child: ListTile(
                leading:CircleAvatar(backgroundImage:AssetImage(item_pic),radius: 30.0,),
                title: Text(item_name,style: TextStyle(fontStyle: FontStyle.italic),),
                subtitle: Text("\$$item_price1",style: TextStyle(decoration: TextDecoration.lineThrough),),
                trailing:Text("\$$item_price2",style: TextStyle(color: Colors.red,fontSize: 18.0),),
                    //Icon(Icons.share,color: Colors.green,),
                ),
              ),
            ),
            //Text("\$$item_price2",style: TextStyle(color: Colors.red,fontSize: 18.0),),
            //trailing: Icon(Icons.keyboard_arrow_right,color: Colors.red,),
          ),
        ),
      );
  }
}

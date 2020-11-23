import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'product.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}
class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  String jsonString = '''
  [
  {
	"productName": "Ram",
	"price": 175.3,
	"quantity": 5
  },
  {
	"productName": "Mouse",
	"price": 20.6,
	"quantity": 100
  },
  {
	"productName": "Keyboard",
	"price": 30.0,
	"quantity": 20
  }
]
  ''';
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    dynamic jsonArray = jsonDecode(jsonString) as List;
    for(int i=0;i<jsonArray.length;i++)
      products.add(Product.fromJson(jsonArray[i]));
  }
  var control = [TextEditingController(),TextEditingController(),TextEditingController()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Product information',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, letterSpacing: 2.0),
          ),
          SizedBox(height: 10.0,),
          //Divider(height: 10.0,color: Colors.black,),
          TextField(
            controller: control[0],
            decoration: InputDecoration(
              labelText: 'Product Name',
            ),
          ),
          TextField(
            controller: control[1],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',

            ),
          ),
          TextField(
            controller: control[2],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Price',
            ),
          ),
          RaisedButton.icon(
            onPressed: () {
              if(control[0].text.isEmpty || control[1].text.isEmpty || control[2].text.isEmpty) {
                Toast.show('Please fill all fields',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                return;
              }
              products.add(Product(productName: control[0].text,quantity: int.parse(control[1].text),
                  price: double.parse(control[2].text)));
              control.forEach((element) {element.clear();});
              setState(() {
              });
            },
            icon: Icon(Icons.add),
            label: Text('Add Product'),
          ),
          SizedBox(height: 20.0,),
          Text(
            'Your Products:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, letterSpacing: 2.0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context,int index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.blue[200],
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 1),
                    leading: Text(
                      products.elementAt(index).productName,
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text('Price: ${products[index].price}'),
                    subtitle: Text('Quantity: ${products[index].quantity}'),
                    trailing: FlatButton.icon(
                      onPressed: () {
                        products.removeAt(index);
                        setState(() {

                        });
                      },
                      icon: Icon(Icons.delete,color: Colors.white,),
                      label: Text(''),),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}



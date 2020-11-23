import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'product.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  Future<List<Product>> products;

  Future<List<Product>> fetchProducts() async {
    http.Response response = await http.get('https://jsonkeeper.com/b/3GKZ');
    List<Product> _products = [];
    if(response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
      _products = jsonArray.map((element) => Product.fromJson(element)).toList();
    }
    return _products;
  }
  @override
  void initState() {
    super.initState();
    products = fetchProducts();
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
          FutureBuilder(
              future: products,
              builder: (context, snapshot) {
                return RaisedButton.icon(
                  onPressed: () {
                    if(control[0].text.isEmpty || control[1].text.isEmpty || control[2].text.isEmpty) {
                      Toast.show('Please fill all fields',context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                      return;
                    }
                    snapshot.data.add(Product(productName: control[0].text,quantity: int.parse(control[1].text),
                        price: double.parse(control[2].text)));
                    control.forEach((element) {element.clear();});
                    setState(() {
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Product'),
                );
              },
          ),
          SizedBox(height: 20.0,),
          Text(
            'Your Products:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, letterSpacing: 2.0),
          ),
          FutureBuilder(
            future: products,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context,int index) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        color: Colors.blue[200],
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 1),
                          leading: Text(
                            snapshot.data.elementAt(index).productName,
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Text('Price: ${snapshot.data[index].price}'),
                          subtitle: Text('Quantity: ${snapshot.data[index].quantity}'),
                          trailing: FlatButton.icon(
                            onPressed: () {
                              snapshot.data.removeAt(index);
                              setState(() {

                              });
                            },
                            icon: Icon(Icons.delete,color: Colors.white,),
                            label: Text(''),),
                        ),
                      );
                    },
                  ),
                );
              }
              else
                return SpinKitRipple(
                  color: Colors.black,
                  size: 50.0,
                );
            },

          ),
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'customersPage.dart';
import 'invoice.dart';
import 'product.dart';
import 'package:toast/toast.dart';
import 'ProductListItem.dart';
import 'dart:convert';

class MainPage extends StatefulWidget {
  final List<Invoice> invoices;
  MainPage(this.invoices);
  @override
  _MainPageState createState() => _MainPageState(invoices);
}

class _MainPageState extends State<MainPage> {

  TextEditingController controller = TextEditingController();
  int _invoiceNo = 1;
  List<Product> products = [];
  List<Invoice> invoices;
  _MainPageState(this.invoices);
  @override
  void initState() {
    super.initState();
    _invoiceNo=invoices.last.invoiceNo+1;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice# $_invoiceNo'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Customer Name',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Products:',style: TextStyle(fontSize: 25.0),),
              RaisedButton(
                child: Text('add product'),
                onPressed: () {
                  _showDialog(context);
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductListItem(
                    product: products[index],
                    deleteProduct: () {
                      products.removeAt(index);
                      setState(() {

                      });
                    },
                  );
                },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('add invoice'),
                onPressed: () {
                  if(controller.text.isEmpty) {
                    Toast.show('enter customer name', context,duration: Toast.LENGTH_LONG);
                    return;
                  }
                  if(products.isEmpty) {
                    Toast.show('enter at least one product', context,duration: Toast.LENGTH_LONG);
                    return;
                  }
                  invoices.add(
                    Invoice(
                      invoiceNo: _invoiceNo,
                      customerName: controller.text,
                      products: products,
                    )
                  );
                  setState(() {
                    controller.clear();
                    products = [];
                    _invoiceNo++;
                  });
                },
              ),
              RaisedButton(
                child: Text('show all invoices'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CustomersPage(invoices),));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
  void _showDialog(BuildContext context) {
    List<TextEditingController> controls=[];
    for(int i=0;i<3;i++)
      controls.add(TextEditingController());
    showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Product info'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controls[0],
                  decoration: InputDecoration(
                    hintText: 'product name'
                  ),
                ),
                TextField(
                  controller: controls[1],
                  decoration: InputDecoration(
                      hintText: 'Quantity'
                  ),
                ),
                TextField(
                  controller: controls[2],
                  decoration: InputDecoration(
                      hintText: 'Price'
                  ),
                ),
              ],
            ),
          ),
          actions: [
            RaisedButton(
              child: Text('add'),
              onPressed: () {

                products.add(
                  Product(
                    productName: controls[0].text,
                    quantity: int.parse(controls[1].text),
                    price: double.parse(controls[2].text),
                  )
                );
                setState(() {

                });
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
        context: context,
    );
  }


}

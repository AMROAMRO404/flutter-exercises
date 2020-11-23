import 'package:flutter/material.dart';
import 'invoice.dart';

import 'detailsPage.dart';
class CustomersPage extends StatelessWidget {
  final List<Invoice> invoices;

  CustomersPage(this.invoices);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Customers'),
      ),
      body: ListView.builder(
        itemCount: invoices.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailsPage(invoices[index]),));
              },
              child: Container(
                  color: Colors.blue[200],
                  margin: EdgeInsets.all(8.0),
                  child: Text(invoices[index].customerName,style: TextStyle(fontSize: 30.0),)
              ),
            );
          },
      ),
    );
  }
}

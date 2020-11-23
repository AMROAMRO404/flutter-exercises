import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'invoice.dart';
import 'mainPage.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<Invoice> invoices = [];
  void fetchInvoices() async {
    http.Response response = await http.get('https://jsonkeeper.com/b/K8P7');
    if(response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body)['invoices'] as List;
      invoices = jsonArray.map((e) => Invoice.fromJson(e)).toList();
//      setState(() {
//        _invoiceNo = invoices.last.invoiceNo+1;
//      });

    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(invoices),));
  }
  @override
  void initState() {
    super.initState();
    fetchInvoices();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitPouringHourglass(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}

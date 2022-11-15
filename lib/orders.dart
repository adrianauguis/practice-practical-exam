import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  // nag set tag parameters sa constructer ang tawag ani techinally kay formal parameter
  Orders(
      {Key? key,
      required this.orders,
      required this.totalPay,
      required this.name,
      required this.phone})
      : super(key: key);

  List orders = [];
  List totalPay = [];
  String? name, phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$name orders"),
          actions: [
            Text('Contact # $phone'),
          ],
        ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),

          // listview builder para display sa orders ug prices na gi pass gikan sa homepage
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Text(
                  'Order ${index + 1} - ${orders[index]} | Price = ${totalPay[index]}'
              );
              },
          ),
        ),
        );
  }
}

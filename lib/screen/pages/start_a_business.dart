import 'package:flutter/material.dart';

class Business extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Row(
            children: [
              Text("Sg Mart Bussiness Opportunity"),
              Text("Compensataion & Recognitions"),
              Text("Developmental Forums and Trips"),
              Text("Become A Direct Retailer"),
              Text("Become a Customer"),
            ],
          ),
        ),
      ),
    );
  }
}

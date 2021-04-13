import 'package:flutter/material.dart';
import 'package:sgmart/screen/landing_page.dart';

class Business extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  width: size.width * 10,
                  child: Buttom_Detail(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

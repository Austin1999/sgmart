import 'package:flutter/material.dart';

class Landing_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.menu),
                      color: Colors.red,
                      onPressed: () {}),
                  Text(
                    "Shop",
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: size.size.width * 0.020,
          ),
          GestureDetector(
            child: Text(
              "Promotion",
              style: TextStyle(),
            ),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Promotion(),
              //     ));
            },
          ),
          SizedBox(
            width: size.size.width * 0.020,
          ),
          GestureDetector(
            child: Text("About  Sg Mart"),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => About(),
              //     ));
            },
          ),
          SizedBox(
            width: size.size.width * 0.020,
          ),
          GestureDetector(
            child: Text("Start A Bussiness"),
            onTap: () {
              // // Navigator.push(
              // //     context,
              // //     MaterialPageRoute(
              // //       builder: (context) => Business(),
              //     ));
            },
          )
        ],
      ),
    );
  }
}

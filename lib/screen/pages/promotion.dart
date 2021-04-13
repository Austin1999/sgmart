import 'package:flutter/material.dart';
import 'package:sgmart/screen/landing_page.dart';

class Promotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Promtion Page"),
                Container(
                  width: size.width * 10,
                  height: size.height * .80,
                ),
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
      ),
    );
  }
}

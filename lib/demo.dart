import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Center(child: Text('Demo App')),
        ),
        body: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Demo App'), Icon(AntIcons.apple_outline)],
          ),
        ));
  }
}

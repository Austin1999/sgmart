import 'package:flutter/material.dart';
import 'package:sgmart/auth.dart';
import 'package:sgmart/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SG Mart',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: GoogleFonts.secularOneTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      // home: Signup()
      home: AuthService().handleAuth(),
    );
  }
}

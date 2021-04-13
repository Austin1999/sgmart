import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgmart/admin/transaction.dart';
import 'package:sgmart/constants.dart';

import 'screen/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SG Mart',
        theme: ThemeData(
          textSelectionColor: Colors.green,
          primaryColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // textTheme: GoogleFonts.secularOneTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: TransactionPage()
        // home: handleAuth(),
        );
  }

  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return Home();
        });
  }
}

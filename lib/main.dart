import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgmart/admin/transaction.dart';
import 'package:sgmart/admin/user.dart';
import 'package:sgmart/constants.dart';
import 'package:sgmart/login&signin/adminlogin.dart';

import 'screen/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {'/email': (context) => AdminLogin()},
        title: 'SG Mart Maligai',
        theme: ThemeData(
          textSelectionColor: Colors.green,
          primaryColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // textTheme: GoogleFonts.secularOneTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: Home()
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

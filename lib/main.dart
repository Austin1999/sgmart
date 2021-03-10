// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:sgmart/auth.dart';
// import 'package:sgmart/signinpage.dart';
// import 'package:sgmart/signuppage.dart';

// void main() {
//   runApp(MyApp());
// }

// class App extends StatefulWidget {
//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire
//       future: Firebase.initializeApp(),
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return ErrorMessage();
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return AuthService().handleAuth();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Loading();
//       },
//     );
//   }
// }

// class ErrorMessage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(
//           'Some Error Occured',
//           style:
//               Theme.of(context).textTheme.headline6.copyWith(color: Colors.red),
//         ),
//       ),
//     );
//   }
// }

// class Loading extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:sgmart/admin/adminpage.dart';
import 'package:sgmart/auth.dart';
import 'package:sgmart/demo.dart';
import 'package:sgmart/responsive/constants.dart';
import 'package:sgmart/responsive/login.dart';
import 'package:sgmart/responsive/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: GoogleFonts.secularOneTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Demo(),
      // home: AuthService().handleAuth(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Option selectedOption = Option.LogIn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // print(size.height);
    // print(size.width);

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 2,
                  color: kPrimaryColor,
                ),
                Container(
                    height: double.infinity,
                    width: size.width / 2,
                    color: Colors.white),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(size.height > 770
                    ? 32
                    : size.height > 670
                        ? 16
                        : 8),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            size.width > 980
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Let's Kick Now !",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          selectedOption == Option.LogIn
                              ? Text(
                                  "Login With your credentials",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                )
                              : Text(
                                  "Signup with your credentials.\nIt's easy and takes less than 30 seconds",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.copyright,
                      color: Colors.grey,
                      size: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Copyright 2021 | Digisailor",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),

              //Animation 1
              //transitionBuilder: (widget, animation) => RotationTransition(
              //  turns: animation,
              //  child: widget,
              //),
              //switchOutCurve: Curves.easeInOutCubic,
              //switchInCurve: Curves.fastLinearToSlowEaseIn,

              //Animation 2
              transitionBuilder: (widget, animation) =>
                  ScaleTransition(child: widget, scale: animation),

              child: selectedOption == Option.LogIn
                  ? LogIn(
                      onSignUpSelected: () {
                        setState(() {
                          selectedOption = Option.SignUp;
                        });
                      },
                    )
                  : SignUp(
                      onLogInSelected: () {
                        setState(() {
                          selectedOption = Option.LogIn;
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgmart/auth.dart';
import 'package:sgmart/home.dart';
import 'package:sgmart/login&signin/login.dart';
import 'package:sgmart/login&signin/new_account.dart';
import 'package:sgmart/screen/pages/about.dart';
import 'package:sgmart/screen/pages/home.dart';
import 'package:sgmart/screen/pages/promotion.dart';
import 'package:sgmart/constants.dart';

class Home extends StatefulWidget {
  User user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // final tabList = ["Shop", "Promtes", " Start A Business", "About"];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          leading: Image.asset('asset/sgmart.png'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicatorColor: kPrimaryColor,
                labelColor: Colors.black,
                controller: _tabController,
                tabs: [
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * .070,
                      ),
                      Tab(
                        icon: Icon(Icons.home_outlined, color: kPrimaryColor),
                      ),
                      SizedBox(
                        width: size.width * .010,
                      ),
                      Text("Home"),
                    ],
                  ),
                  // Tab(
                  //   text: "Promotion",
                  // ),
                  Tab(
                    text: "About Sg Mart",
                  ),
                  Tab(
                    text: "Start A Business",
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
          // titleSpacing: 200,
          elevation: 0.5,
          title: Text(
            "SG Mart",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          actions: [
            FirebaseAuth.instance.currentUser == null
                ? Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: GestureDetector(
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
            SizedBox(
              width: size.width * 0.030,
            ),
            FirebaseAuth.instance.currentUser == null
                ? Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: GestureDetector(
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup(),
                          ),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: GestureDetector(
                      child: Text(
                        "SignOut",
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        AuthService().signOut(context);
                      },
                    ),
                  ),
            SizedBox(
              width: size.width * 0.030,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: kPrimaryColor,
                  ),
                  color: Colors.black,
                  onPressed: () {
                    // Navigator.pop(context);
                  }),
            ),
            SizedBox(
              width: size.width * 0.020,
            ),
          ],
        ),
        body: TabBarView(controller: _tabController, children: [
          ShopHome(),
          About(),
          FirebaseAuth.instance.currentUser == null
              ? Center(
                  child: TextButton(
                    child: Text(
                      'Please Sign in To Continue',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                  ),
                )
              : UserHomePage(
                  user: widget.user,
                ),
          // Promotion(),
        ]));
  }
}

//buttom container called in every page
class Buttom_Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 24.0, left: 24.0, right: 24.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title
                    Text(
                      "South Gate Malligai",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: size.height * .015,
                    ),
                    //Address first line
                    Text(
                      "1A, Chidambara Nagar, 1st Street, Opp. Shakthi",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    //Address second line
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Vinayagar School, Thoothukudi-628008",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Container(
                    child: Column(
                  children: [
                    Text(
                      "Customer Services",
                      style:
                          GoogleFonts.ubuntu(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: size.height * .010,
                    ),
                    Text(
                      "customercare@sgmart.co.in",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                )),

                //Media email
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Media Relations",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: size.height * .010,
                      ),
                      Text(
                        "media@sgmart.co.in",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontSize: 14),
                      )
                    ],
                  ),
                ),

                //Vendor email
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Vendor Support",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: size.height * .010,
                      ),
                      Text(
                        "vendorsupport@sgmart.co.in",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All rights recieved | Copyright © ${DateTime.now().year} SG Mart',
              style: GoogleFonts.prompt(),
            ),
          )
        ],
      ),
    );
  }
}

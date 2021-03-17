import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgmart/auth.dart';
import 'package:sgmart/home.dart';
import 'package:sgmart/login&signin/login.dart';
import 'package:sgmart/login&signin/new_account.dart';
import 'package:sgmart/screen/pages/about.dart';
import 'package:sgmart/screen/pages/home.dart';
import 'package:sgmart/screen/pages/promotion.dart';
import 'package:sgmart/constants.dart';

class Home extends StatefulWidget {
  final user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // final tabList = ["Shop", "Promtes", " Start A Business", "About"];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
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
                  Tab(
                    text: "Home",
                    icon: Icon(Icons.home_outlined, color: kPrimaryColor),
                  ),
                  Tab(
                    text: "Promotion",
                  ),
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
                        AuthService().signOut();
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
          Promotion(),
          About(),
          FirebaseAuth.instance.currentUser == null
              ? Center(
                  child: Text('Please Sign in To Continue'),
                )
              : UserHomePage(
                  user: widget.user,
                )
        ]));
  }
}

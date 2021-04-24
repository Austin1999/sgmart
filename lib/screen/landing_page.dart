import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sgmart/admin/user.dart';
import 'package:sgmart/home.dart';
import 'package:sgmart/login&signin/login.dart';
import 'package:sgmart/screen/pages/about.dart';
import 'package:sgmart/screen/pages/home.dart';
import 'package:sgmart/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login&signin/login.dart';

class Home extends StatefulWidget {
  final phone;
  Home({this.phone});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  final keyIsFirstLoaded = 'is_first_loaded';
  showDialogIfFirstLoaded(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser.metadata.lastSignInTime ==
        FirebaseAuth.instance.currentUser.metadata.creationTime) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Stack(
                      children: [
                        Icon(Icons.close),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('asset/sgmart.png'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Welcome to SG Mart Maligai',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: kPrimaryColor),
                              ),
                            ),
                            Image.asset('asset/welcome.jpg'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Welcome to SGMART Maligai Partner Group. Each new partner  benefits from and contributes to our Sgmart Member network strength.',
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                        Lottie.asset('welcome_animation.json',
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Scaffold(
      appBar: AppBar(
        // leading: Image.asset('asset/sgmart.png',),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              labelStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 665
                      ? 16
                      : MediaQuery.of(context).size.width * 0.03),
              indicatorColor: kPrimaryColor,
              labelColor: Colors.black,
              controller: _tabController,
              tabs: [
                //home & icon

                Tab(
                  text: "Home",
                ),
                //Business
                Tab(
                  text: "Our Products",
                ),
                Tab(
                  text: "About Sg Mart",
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        // titleSpacing: 200,
        elevation: 0.5,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 18),
              child: GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'asset/sgmart.png',
                    height: 82,
                    width: 82,
                  )),
            ),
          ],
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
                            ));
                      }))
              : Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: GestureDetector(
                    child: Text(
                      "SignOut",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut().whenComplete(() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      });
                    },
                  ),
                ),
          SizedBox(
            width: size.width * 0.030,
          ),
          SizedBox(
            width: size.width * 0.020,
          ),
        ],
        iconTheme: Theme.of(context).iconTheme.copyWith(color: kPrimaryColor),
      ),
      drawer: FirebaseAuth.instance.currentUser != null
          ? FirebaseAuth.instance.currentUser.uid ==
                  '7QxRBK5F7VTpDtS60IX2WQrX3Jr1'
              ? Drawer(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Divider(
                          thickness: 0.3,
                          color: Colors.black,
                        ),
                        ListTile(
                          title: Text("User Detail"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserPage(),
                                ));
                          },
                        ),
                        Divider(
                          thickness: .3,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                )
              : Drawer(
                  child: Center(
                    child: ListTile(
                      title: Text('Only Admin have access to this Menu'),
                    ),
                  ),
                )
          : Drawer(
              child: Center(
                child: ListTile(
                  title: Text('Please Sign in to access this Menu'),
                ),
              ),
            ),
      // body: widget.state,
      body: buildTabBarView(),
    );
  }

  TabBarView buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        // Promotion(),

        FirebaseAuth.instance.currentUser == null
            ? Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'Please Sign in To Continue',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
              )
            : UserHomePage(
                phone: widget.phone,
              ),
        ShopHome(),
        About()
      ],
    );
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
            child: size.width >= 900
                ? Row(
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
                            style: GoogleFonts.ubuntu(
                                color: Colors.black, fontSize: 18),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            style: GoogleFonts.ubuntu(
                                color: Colors.black, fontSize: 18),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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

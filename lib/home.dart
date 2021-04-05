import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sgmart/admin/user_detail.dart';
import 'package:sgmart/auth.dart';
import 'package:sgmart/constants.dart';
import 'package:sgmart/login&signin/login.dart';
import 'package:sgmart/widgets/treeview.dart';

class UserHomePage extends StatefulWidget {
  User user;
  UserHomePage({this.user});
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  var groupvaolume = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        key: _scaffoldKey,
        drawer: widget.user.uid == 'ub8mlhBOAnPHALalBLYhZfbVmzH3'
            ? Drawer(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.asset(
                        "asset/Sgmart.png",
                        height: 82,
                        width: 82,
                      ),
                      ListTile(
                        title: Text('SignOut'),
                        onTap: () {
                          AuthService().signOut(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                      ),
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
                                builder: (context) => User_Detail(),
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
            : Container(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(widget.user.photoURL)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  print(widget.user.photoURL);
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print(widget.user.photoURL);
                  var data = snapshot.data;
                  // return Row(
                  // children: [
                  return Container(
                    height: size.height * 0.85,
                    // width: size.width * 0.6,
                    child: Card(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kPrimaryColor,
                                    child: Text(
                                        data
                                            .get('name')
                                            .toString()
                                            .substring(0, 1),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(color: Colors.white)),
                                  ),
                                  Text(
                                    '${data.get('name')} \n ${data.get('address')}',
                                  ),
                                  Text('₹0 \nPaid to you'),
                                  Text(
                                      '${data.get('phone')} \n your referal id'),
                                  kIsWeb
                                      ? IconButton(
                                          icon: Icon(Icons.copy),
                                          onPressed: () {
                                            Clipboard.setData(
                                              new ClipboardData(
                                                  text: data.get('phone')),
                                            ).then((result) {
                                              final snackBar = SnackBar(
                                                content:
                                                    Text('Copied to Clipboard'),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  textColor: Colors.yellow,
                                                  onPressed: () {},
                                                ),
                                              );
                                              _scaffoldKey.currentState
                                                  .showSnackBar(snackBar);
                                            });
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(Icons.share),
                                          onPressed: () {
                                            FlutterShareMe().shareToSystem(
                                                msg: data.get('phone'));
                                          },
                                        )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'Your Referals',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    groupvaolume.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ],
                            ),
                            FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('Users')
                                  .where('id',
                                      isGreaterThanOrEqualTo:
                                          '${snapshot.data.get('id')}')
                                  .where('id',
                                      isLessThanOrEqualTo:
                                          '${snapshot.data.get('id')}~')
                                  .orderBy('id')
                                  .get(),
                              builder: (context, snapshot1) {
                                if (!snapshot1.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot1.data.docs.length,
                                      itemBuilder: (context, index1) {
                                        DocumentSnapshot data1 =
                                            snapshot1.data.docs[index1];
                                        // groupvaolume +=
                                        //     data1.get('personalVolume');
                                        print(data1.get('name'));
                                        return TreeChild(
                                          docs: snapshot1.data.docs,
                                          i: index1,
                                          padding: double.parse(data1
                                                  .get('level')
                                                  .toString()) *
                                              20,
                                        );
                                      });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 12.0),
                  //   child: Container(
                  //     height: size.height * 0.85,
                  //     width: size.width * 0.35,
                  //     child: Card(
                  //       child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Column(
                  //             children: [
                  //               Container(
                  //                 height: size.height * 0.35,
                  //                 width: double.infinity,
                  //                 child: Card(
                  //                   elevation: 2.0,
                  //                   child: Column(
                  //                     children: [
                  //                       Padding(
                  //                         padding:
                  //                             const EdgeInsets.all(8.0),
                  //                         child: Text(
                  //                           'Your Products',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .headline6,
                  //                         ),
                  //                       ),
                  //                       Row(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.center,
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceEvenly,
                  //                         children: [
                  //                           RaisedButton.icon(
                  //                             color: kPrimaryColor,
                  //                             icon: Icon(Icons.visibility,
                  //                                 color: Colors.white),
                  //                             onPressed: () => view(
                  //                                 'product', 'My Products'),
                  //                             label: Text(
                  //                               'View',
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .button
                  //                                   .copyWith(
                  //                                       color:
                  //                                           Colors.white),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Container(
                  //                   height: size.height * 0.35,
                  //                   width: double.infinity,
                  //                   child: Card(
                  //                     elevation: 2.0,
                  //                     child: Column(
                  //                       children: [
                  //                         Padding(
                  //                           padding:
                  //                               const EdgeInsets.all(8.0),
                  //                           child: Text(
                  //                             "Today's Deals",
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .headline6,
                  //                           ),
                  //                         ),
                  //                         Row(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.center,
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment
                  //                                   .spaceEvenly,
                  //                           children: [
                  //                             RaisedButton.icon(
                  //                               color: kPrimaryColor,
                  //                               icon: Icon(Icons.visibility,
                  //                                   color: Colors.white),
                  //                               onPressed: () => view(
                  //                                   'deals',
                  //                                   "Today's Deals"),
                  //                               label: Text(
                  //                                 'View',
                  //                                 style: Theme.of(context)
                  //                                     .textTheme
                  //                                     .button
                  //                                     .copyWith(
                  //                                         color:
                  //                                             Colors.white),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ))
                  //             ],
                  //           )),
                  //     ),
                  //   ),
                  // )
                  //   ],
                  // );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  view(dname, title) {
    showDialog(
      context: context,
      builder: (context) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .doc(dname)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
                  return Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.get('productlist').length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data.get('productlist');
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(data[index]),
                                ),
                                Divider(
                                  thickness: 1.0,
                                ),
                              ],
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: RaisedButton(
                              color: kPrimaryColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sgmart/constants.dart';
import 'package:sgmart/screen/landing_page.dart';
import 'package:sgmart/widgets/customtreeview.dart';
import 'constants.dart';

class UserHomePage extends StatefulWidget {
  final phone;
  UserHomePage({this.phone});
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  var groupvaolume = 0; //inital groupVolume
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double commssion = 0; // intial commission value
  bool clicked = false; // for disable commission btn

  //for calculate commission
  Future getData(snapshot) async {
    //querysnapshot return type of data
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isGreaterThanOrEqualTo: '${snapshot.data.get('id')}')
        .where('id', isLessThanOrEqualTo: '${snapshot.data.get('id')}~')
        .orderBy('id')
        .get();
    return data.docs;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user.photoURL)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print('Photo URl : ${user.photoURL}');
                  var data = snapshot.data;
                  return Container(
                    height: size.height * 0.85,
                    child: Card(
                      child: Scrollbar(
                        controller: ScrollController(),
                        isAlwaysShown: true,
                        showTrackOnHover: true,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: size.width > 465
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              '₹ ${data.get('personalVolume')} \nPersonal Volume'),
                                          Text(
                                              '₹ ${data.get('groupVolume')} \nGroup Volume'),
                                          Text(
                                              '${data.get('phone')} \n your login id'),
                                          kIsWeb
                                              //clipboard
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.copy,
                                                    color: Colors.green,
                                                  ),
                                                  onPressed: () {
                                                    Clipboard.setData(
                                                      new ClipboardData(
                                                          text: data
                                                              .get('phone')),
                                                    ).then((result) {
                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                            'Copied to Clipboard'),
                                                        action: SnackBarAction(
                                                          label: 'Undo',
                                                          textColor:
                                                              Colors.yellow,
                                                          onPressed: () {
                                                            ClipboardData(
                                                                text: '');
                                                          },
                                                        ),
                                                      );
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar);
                                                    });
                                                  },
                                                ) //phone view
                                              : IconButton(
                                                  icon: Icon(Icons.share),
                                                  onPressed: () {
                                                    FlutterShareMe()
                                                        .shareToSystem(
                                                            msg: data
                                                                .get('phone'));
                                                  },
                                                )
                                        ],
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                                'Personal Volume : ₹ ${data.get('personalVolume')}'),
                                            Text(
                                                'Group Volume : ₹ ${data.get('groupVolume')}'),
                                            Row(
                                              children: [
                                                Text(
                                                    'your login id : ${data.get('phone')}'),
                                                kIsWeb
                                                    //clipboard
                                                    ? IconButton(
                                                        icon: Icon(
                                                          Icons.copy,
                                                          color: Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          Clipboard.setData(
                                                            new ClipboardData(
                                                                text: data.get(
                                                                    'phone')),
                                                          ).then((result) {
                                                            final snackBar =
                                                                SnackBar(
                                                              content: Text(
                                                                  'Copied to Clipboard'),
                                                              action:
                                                                  SnackBarAction(
                                                                label: 'Undo',
                                                                textColor:
                                                                    Colors
                                                                        .yellow,
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            );
                                                            _scaffoldKey
                                                                .currentState
                                                                .showSnackBar(
                                                                    snackBar);
                                                          });
                                                        },
                                                      ) //phone view
                                                    : IconButton(
                                                        icon: Icon(Icons.share),
                                                        onPressed: () {
                                                          FlutterShareMe()
                                                              .shareToSystem(
                                                                  msg: data.get(
                                                                      'phone'));
                                                        },
                                                      )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              size.width > 795
                                  ? Row(
                                      children: [
                                        //referal text
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            'Your Referals',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width >
                                                            665
                                                        ? 20
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              'Your Referel : ${data.get('ref')} (${data.get('refname')})'),
                                        ),
                                        Spacer(),
                                        Text('Your Comission : '),
                                        //commission amount
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            commssion.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width >
                                                            665
                                                        ? 20
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03),
                                          ),
                                        ),

                                        //commission button
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            color: Colors.green,
                                            onPressed: () async {
                                              var data1 =
                                                  await getData(snapshot);
                                              var volume = 0;
                                              await data1.forEach(
                                                  (QueryDocumentSnapshot
                                                      element) {
                                                volume += element
                                                    .get('personalVolume');
                                              });
                                              var pv =
                                                  data.get('personalVolume');

                                              setState(() {
                                                commssion =
                                                    viewCommission(pv, volume);
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(snapshot.data.id)
                                                    .update({
                                                  "commission": commssion,
                                                  "groupVolume": volume
                                                });
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AutoSizeText(
                                                'View Commission',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width >
                                                            665
                                                        ? 18
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              'Your Referel : ${data.get('ref')} (${data.get('refname')})'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  'Your Comission : ${commssion.toString()}'),

                                              //commission button
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: RaisedButton(
                                                  color: Colors.green,
                                                  onPressed: () async {
                                                    var data1 =
                                                        await getData(snapshot);
                                                    var volume = 0;
                                                    await data1.forEach(
                                                        (QueryDocumentSnapshot
                                                            element) {
                                                      volume += element.get(
                                                          'personalVolume');
                                                    });
                                                    var pv = data
                                                        .get('personalVolume');

                                                    setState(() {
                                                      commssion =
                                                          viewCommission(
                                                              pv, volume);
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc(snapshot.data.id)
                                                          .update({
                                                        "commission": commssion,
                                                        "groupVolume": volume
                                                      });
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: AutoSizeText(
                                                      'View Commission',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  665
                                                              ? 18
                                                              : MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              //data fetching
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
                                    return CustomTreeView(
                                      data: snapshot1,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  //product & today deal
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
                        ),
                        Buttom_Detail()
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

  //commission
  double viewCommission(pv, int gv) {
    if (pv >= 3000 && gv >= 12000 && gv <= 50099) {
      return double.parse((gv / 100 * 1.5).toString());
    } else {
      if (pv >= 3000 && gv >= 51000 && gv <= 101999) {
        return double.parse((gv / 100 * 3.0).toString());
      } else {
        if (pv >= 3000 && gv >= 102000 && gv <= 203999) {
          return double.parse((gv / 100 * 4.5).toString());
        } else {
          if (pv >= 3000 && gv >= 204000 && gv <= 407999) {
            return double.parse((gv / 100 * 6.0).toString());
          } else {
            if (pv >= 3000 && gv >= 408000 && gv <= 713999) {
              return double.parse((gv / 100 * 7.5).toString());
            } else {
              if (pv >= 3000 && gv >= 714000 && gv <= 1019999) {
                return double.parse((gv / 100 * 9.0).toString());
              } else {
                if (pv >= 3000 && gv >= 1020000) {
                  return double.parse((gv / 100 * 10.5).toString());
                } else {
                  _buildErrorDialog(
                      context, 'You have low personal / group volume');
                  return 0;
                }
              }
            }
          }
        }
      }
    }
  }

  //alert dialog
  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}

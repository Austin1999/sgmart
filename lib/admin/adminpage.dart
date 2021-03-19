import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sgmart/login&signin/login.dart';
import 'package:sgmart/constants.dart';
import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import '../auth.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<String> name = List();
  List<Widget> pname = List();
  Uri url;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController pnamecon = TextEditingController();
  String productname;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
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
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.blueGrey.shade50,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('adminverified', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Row(
                  children: [
                    Container(
                      height: size.height * 0.85,
                      width: size.width * 0.6,
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Text('A',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      'Howdy Admin!',
                                    ),
                                  ),
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(
                                        text: 'Total Users : ',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                              text:
                                                  '${snapshot.data.docs.length}',
                                              style: TextStyle(
                                                  color: kPrimaryColor))
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Unverified Users',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data.docs[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      trailing: RaisedButton(
                                        onPressed: () async {
                                          FirebaseApp tempApp =
                                              await Firebase.initializeApp(
                                                  name: 'temporaryregiter',
                                                  options:
                                                      Firebase.app().options);
                                          UserCredential result =
                                              await FirebaseAuth.instanceFor(
                                                      app: tempApp)
                                                  .createUserWithEmailAndPassword(
                                                      email: data.get('email'),
                                                      password:
                                                          data.get('password'))
                                                  .whenComplete(() => {
                                                        FirebaseAuth.instance
                                                            .currentUser
                                                            .updateProfile(
                                                                photoURL:
                                                                    data.get(
                                                                        'phone'))
                                                      });
                                          var gen = await FirebaseFirestore
                                              .instance
                                              .collection('Users')
                                              .doc('general')
                                              .get()
                                              .then((value) {
                                            return value.get('id') + 1;
                                          });
                                          var refid = await FirebaseFirestore
                                              .instance
                                              .collection('Users')
                                              .doc(data.get('ref'))
                                              .get()
                                              .then((value) {
                                            return value.get('id');
                                          });
                                          var id =
                                              refid.toString() + gen.toString();
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc('general')
                                              .update({
                                            'id': FieldValue.increment(1)
                                          });
                                          FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(data.get('phone'))
                                              .set(
                                            {
                                              'level': id.length,
                                              'parent': data.get('ref') != null
                                                  ? false
                                                  : true,
                                              'id': id,
                                              "searchindex": setSearchParam(
                                                  data.get('phone')),
                                              'adminverified': true
                                            },
                                            SetOptions(merge: true),
                                          );
                                          tempApp.delete();
                                          print(FirebaseAuth
                                              .instance.currentUser.photoURL);
                                        },
                                        color: kPrimaryColor,
                                        child: Text(
                                          'Approve',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                          '${index + 1} . ${data.get('name')}'),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Container(
                        height: size.height * 0.85,
                        width: size.width * 0.35,
                        child: Card(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: size.height * 0.35,
                                    width: double.infinity,
                                    child: Card(
                                      elevation: 2.0,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Your Products',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              RaisedButton.icon(
                                                color: kPrimaryColor,
                                                icon: Icon(Icons.visibility,
                                                    color: Colors.white),
                                                onPressed: () => view(
                                                    'product', 'My Products'),
                                                label: Text(
                                                  'View',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ),
                                              RaisedButton.icon(
                                                splashColor: kPrimaryColor,
                                                color: Colors.white,
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: kPrimaryColor,
                                                ),
                                                onPressed: () => onpressed(
                                                    'Edit Your Products',
                                                    'product'),
                                                label: Text(
                                                  'Edit',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button
                                                      .copyWith(
                                                          color: kPrimaryColor),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: size.height * 0.35,
                                      width: double.infinity,
                                      child: Card(
                                        elevation: 2.0,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Today's Deals",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                RaisedButton.icon(
                                                  color: kPrimaryColor,
                                                  icon: Icon(Icons.visibility,
                                                      color: Colors.white),
                                                  onPressed: () => view(
                                                      'deals', "Today's Deals"),
                                                  label: Text(
                                                    'View',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                                RaisedButton.icon(
                                                  splashColor: kPrimaryColor,
                                                  color: Colors.white,
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: kPrimaryColor,
                                                  ),
                                                  onPressed: () => onpressed(
                                                      'Edit Todays Deals',
                                                      'deals'),
                                                  label: Text(
                                                    'Edit',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button
                                                        .copyWith(
                                                            color:
                                                                kPrimaryColor),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  setSearchParam(String refid) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < refid.length; i++) {
      temp = temp + refid[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  onpressed(title, dname) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter stateSetter) {
            return Dialog(
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: pnamecon,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  hintText: 'Name'),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              // width: MediaQuery.of(context).size.width / 2,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.network(
                                  url == null
                                      // || url.toString().trim() == ''
                                      ? 'http://www.aaru.edu.jo/websites/aaru2/wp-content/plugins/learnpress/assets/images/no-image.png'
                                      : url.toString(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => uploadToStorage(
                                fileName: dname,
                                pathName: 'products/$dname',
                                updateState: stateSetter))
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Widget widget = pname.elementAt(index);
                        return Row(
                          children: [
                            widget,
                            IconButton(
                                icon: Icon(
                                  Icons.close,
                                ),
                                onPressed: () {
                                  deleted(stateSetter, index);
                                }),
                          ],
                        );
                      },
                      itemCount: pname.length,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: kPrimaryColor,
                            onPressed: () async {
                              print(productname);
                              name.add(pnamecon.text);
                              productname != null
                                  ? name.add(productname)
                                  : print('Null Value');
                              print('Controller : ${pnamecon.text}');
                              print(name);
                              await FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(dname)
                                  .set(
                                {
                                  'productlist': FieldValue.arrayUnion(name),
                                },
                                SetOptions(merge: true),
                              );
                              name.clear();
                              pname.clear();
                              pnamecon.clear();
                              setState(() {
                                productname = null;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: kPrimaryColor,
                            onPressed: () {
                              name.clear();
                              pname.clear();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            onPressed: () {
                              updated(stateSetter);
                              print(productname);
                              productname == null
                                  ? print('Null value')
                                  : name.add(productname);
                            },
                            child: new Icon(
                              Icons.add,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  updated(StateSetter updateState) {
    updateState(() {
      pname.add(
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      productname = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      hintText: 'Name'),
                ),
              ),
            ],
          ),
        ),
      );
      setState(() {});
    });
  }

  deleted(StateSetter updateState, index) {
    updateState(() {
      pname.removeAt(index);
    });
  }

  void uploadImage({@required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void uploadToStorage({pathName, fileName, StateSetter updateState}) {
    final path = '$pathName/$fileName';
    uploadImage(onSelected: (file) {
      fb
          .storage()
          .refFromURL('gs://portifolio-b7066.appspot.com/')
          .child(path)
          .put(file)
          .future
          .then((data) async {
        var ur = await data.ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection('Products')
            .doc(fileName)
            .set({'url': ur});
        updateState(() {
          url = ur;
        });
        print(url);
      });
    });
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

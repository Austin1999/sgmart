import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgmart/constants.dart';
import 'package:sgmart/screen/landing_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController phone = TextEditingController(text: '+91');
  TextEditingController otp = TextEditingController();
  TextEditingController referal = TextEditingController();
  TextEditingController referalphone = TextEditingController();
  int ref;
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  bool show = false;
  bool obscure = true;
  bool codesent = false;
  bool isLoading = true;
  bool phoneexists = false;
  ConfirmationResult result;

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  String phoneValidator(String value) {
    Pattern pattern = r'^(\+\d{1,2})?\d{10}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter valid 10 Digt Number Phone Number';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.green,
      body: size.width >= 650
          ? Row(
              children: [
                //LeftSide
                Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  width: size.width * .40,
                  // height: size.height * .80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Sgmart text
                      Center(
                        child: CircleAvatar(
                          child: Image.asset('asset/user.png'),
                          backgroundColor: Colors.green[800],
                          radius: size.width * 0.08,
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        "Welcome Back!",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        "Sign in with your credentials.",
                        style: TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                ),

                //RightSide
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: size.width * .60,
                  // height: size.height * .80,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          //Signup
                          Center(
                            child: Text(
                              "Signin",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
                            ),
                          ),

                          //Phone
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                            child: TextFormField(
                              onChanged: (value) async {
                                if (value.length == 13) {
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc('phone')
                                      .get()
                                      .then(
                                    (value) {
                                      List userphone = value.get('userphone');
                                      for (var e in userphone) {
                                        if (e == phone.text.trim()) {
                                          print('Phone Exists $e');
                                          setState(() {
                                            phoneexists = true;
                                          });
                                          print(phoneexists);
                                          break;
                                        } else {
                                          setState(() {
                                            phoneexists = false;
                                            print(phoneexists);
                                          });
                                        }
                                      }
                                    },
                                  );
                                }
                              },
                              autovalidate:
                                  phone.text.length >= 13 ? true : false,
                              keyboardType: TextInputType.phone,
                              validator: phoneValidator,
                              controller: phone,
                              decoration: InputDecoration(
                                  hintText: "Enter Phone Number",
                                  icon: Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          //referal
                          phoneexists
                              ? Text(
                                  'Welcome back!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(color: Colors.grey),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 25, 40, 5),
                                  child: TextFormField(
                                    onTap: () {
                                      setState(() {
                                        show = true;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    validator: (value) => value.isEmpty
                                        ? 'Referal Field Must not be Empty'
                                        : null,
                                    controller: referalphone,
                                    decoration: InputDecoration(
                                      hintText: "Referal",
                                      icon: Icon(Icons.person_add_alt),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                ),
                          show
                              ? StreamBuilder<QuerySnapshot>(
                                  stream: (referalphone.text == null ||
                                          referalphone.text.trim() == '')
                                      ? FirebaseFirestore.instance
                                          .collection('Users')
                                          .limit(2)
                                          .snapshots()
                                      : FirebaseFirestore.instance
                                          .collection('Users')
                                          .where('searchindex',
                                              arrayContains: referalphone.text)
                                          .limit(2)
                                          .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      print(snapshot.error);
                                      return Text(
                                          'We run into an error ${snapshot.error}');
                                    }
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      case ConnectionState.none:
                                        return Text('Oops no data present');
                                      case ConnectionState.done:
                                        return Text('We are done');
                                      default:
                                        return ListView(
                                          shrinkWrap: true,
                                          children: snapshot.data.docs
                                              .map((DocumentSnapshot document) {
                                            return ListTile(
                                              onTap: () {
                                                setState(() {
                                                  show = false;
                                                  referal.text = document['id'];
                                                  ref = document['personalid'];
                                                  referalphone.text =
                                                      document['phone'];
                                                });
                                              },
                                              title: Text(
                                                document['phone'],
                                              ),
                                            );
                                          }).toList(),
                                        );
                                    }
                                  },
                                )
                              : Container(),
                          phoneexists
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 25, 40, 5),
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty
                                        ? 'Name Field Must not be Empty'
                                        : null,
                                    controller: name,
                                    decoration: InputDecoration(
                                        hintText: "Name",
                                        icon: Icon(Icons.person),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        )),
                                  ),
                                ),
                          phoneexists
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 25, 40, 5),
                                  child: TextFormField(
                                    keyboardType: TextInputType.streetAddress,
                                    validator: (val) => val.isEmpty
                                        ? 'Address Field Must not be Empty'
                                        : null,
                                    controller: address,
                                    decoration: InputDecoration(
                                      hintText: "Enter Address",
                                      icon: Icon(Icons.location_on),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                ),
                          codesent
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 5),
                                  child: TextFormField(
                                    obscureText: obscure,
                                    controller: otp,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obscure = !obscure;
                                          });
                                        },
                                        icon: obscure
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                      ),
                                      hintText: "Enter OTP",
                                      icon: Icon(Icons.lock_outlined),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                            child: Container(
                              width: double.infinity,
                              child: FloatingActionButton.extended(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    codesent ? "Verify OTP" : "Send OTP",
                                    style: TextStyle(),
                                  ),
                                  onPressed: () async {
                                    var resvalue;
                                    print(codesent);
                                    formkey.currentState.save();
                                    if (formkey.currentState.validate()) {
                                      print(resvalue);
                                      try {
                                        if (!codesent) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text('Loading...'),
                                                    CircularProgressIndicator()
                                                  ],
                                                ),
                                              );
                                            },
                                          );

                                          result = await FirebaseAuth.instance
                                              .signInWithPhoneNumber(
                                            phone.text,
                                          )
                                              .then((value) {
                                            setState(() {
                                              codesent = true;
                                              resvalue = value;
                                            });
                                            Navigator.pop(context);
                                            return value;
                                          });
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text('Loading...'),
                                                    CircularProgressIndicator()
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                          await result
                                              .confirm(otp.text)
                                              .then((v) async {
                                            // await v.user.updateProfile(
                                            //     photoURL: phone.text);
                                            // await v.user.reload();
                                            // print('Referal uid : $ref');

                                            var id = referal.text.toString() +
                                                phone.text.substring(3);
                                            var len = id.length;
                                            if (phoneexists) {
                                              print('phoneexists');
                                            } else {
                                              var userid =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Users')
                                                      .doc('phone')
                                                      .get()
                                                      .then(
                                                        (value) =>
                                                            value.get('user'),
                                                      );
                                              print(userid);
                                              print(v.user.uid);
                                              await FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(v.user.uid)
                                                  .set({
                                                'parentid': ref,
                                                'uid': v.user.uid,
                                                'phone': phone.text,
                                                'level': len / 10,
                                                'id': id,
                                                'personalVolume': 0,
                                                'groupVolume': 0,
                                                'name': name.text,
                                                'address': address.text,
                                                'personalid': userid + 1,
                                                "searchindex":
                                                    setSearchParam(phone.text),
                                              }).whenComplete(() =>
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc('phone')
                                                          .update({
                                                        'user': FieldValue
                                                            .increment(1),
                                                        'userphone': FieldValue
                                                            .arrayUnion(
                                                                [phone.text])
                                                      }));
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Home(
                                                    phone: phone.text,
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                        }
                                      } catch (e) {
                                        _buildErrorDialog(context, e.message);
                                      }
                                    }
                                  }),
                            ),
                          ),
                          //password
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          :
          //RightSide
          Container(
              // height: size.height * .80,
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      //Signup
                      Center(
                        child: Text(
                          "Signin",
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                      ),

                      //Phone
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                        child: TextFormField(
                          onChanged: (value) async {
                            if (value.length == 13) {
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc('phone')
                                  .get()
                                  .then(
                                (value) {
                                  List userphone = value.get('userphone');
                                  for (var e in userphone) {
                                    if (e == phone.text.trim()) {
                                      print('Phone Exists $e');
                                      setState(() {
                                        phoneexists = true;
                                      });
                                      print(phoneexists);
                                      break;
                                    } else {
                                      setState(() {
                                        phoneexists = false;
                                        print(phoneexists);
                                      });
                                    }
                                  }
                                  // userphone.forEach((e) {

                                  // });
                                },
                              );

                              // print(phoneexists);
                              // print(phoneexist);
                              // print(phone.text);
                            }
                          },
                          keyboardType: TextInputType.phone,
                          validator: phoneValidator,
                          controller: phone,
                          decoration: InputDecoration(
                              hintText: "Enter Phone Number",
                              icon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      //referal
                      phoneexists
                          ? Text(
                              'Welcome back!',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.grey),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    show = true;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {});
                                },
                                controller: referalphone,
                                decoration: InputDecoration(
                                  hintText: "Referal",
                                  icon: Icon(Icons.person_add_alt),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                      show
                          ? StreamBuilder<QuerySnapshot>(
                              stream: (referalphone.text == null ||
                                      referalphone.text.trim() == '')
                                  ? FirebaseFirestore.instance
                                      .collection('Users')
                                      .limit(2)
                                      .snapshots()
                                  : FirebaseFirestore.instance
                                      .collection('Users')
                                      .where('searchindex',
                                          arrayContains: referalphone.text)
                                      .limit(2)
                                      .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return Text(
                                      'We run into an error ${snapshot.error}');
                                }
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  case ConnectionState.none:
                                    return Text('Oops no data present');
                                  case ConnectionState.done:
                                    return Text('We are done');
                                  default:
                                    return ListView(
                                      shrinkWrap: true,
                                      children: snapshot.data.docs
                                          .map((DocumentSnapshot document) {
                                        return ListTile(
                                          onTap: () {
                                            setState(() {
                                              show = false;
                                              referal.text = document['id'];
                                              ref = document['personalid'];
                                              referalphone.text =
                                                  document['phone'];
                                            });
                                          },
                                          title: Text(
                                            document['phone'],
                                          ),
                                        );
                                      }).toList(),
                                    );
                                }
                              },
                            )
                          : Container(),
                      phoneexists
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                              child: TextFormField(
                                validator: (val) => val.isEmpty
                                    ? 'Please enter your Name'
                                    : null,
                                controller: name,
                                decoration: InputDecoration(
                                    hintText: "Name",
                                    icon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                            ),
                      phoneexists
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                              child: TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                validator: (val) => val.isEmpty
                                    ? 'Please enter your Address'
                                    : null,
                                controller: address,
                                decoration: InputDecoration(
                                  hintText: "Enter Address",
                                  icon: Icon(Icons.location_on),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                      codesent
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
                              child: TextFormField(
                                obscureText: obscure,
                                controller: otp,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure = !obscure;
                                      });
                                    },
                                    icon: obscure
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                  ),
                                  hintText: "Enter OTP",
                                  icon: Icon(Icons.lock_outlined),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                        child: Container(
                          width: double.infinity,
                          child: FloatingActionButton.extended(
                              backgroundColor: Colors.green,
                              label: Text(
                                codesent ? "Verify OTP" : "Send OTP",
                                style: TextStyle(),
                              ),
                              onPressed: () async {
                                var resvalue;
                                print(codesent);
                                formkey.currentState.save();
                                if (formkey.currentState.validate()) {
                                  print(resvalue);
                                  try {
                                    if (!codesent) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('Loading...'),
                                                CircularProgressIndicator()
                                              ],
                                            ),
                                          );
                                        },
                                      );

                                      result = await FirebaseAuth.instance
                                          .signInWithPhoneNumber(
                                        phone.text,
                                      )
                                          .then((value) {
                                        setState(() {
                                          codesent = true;
                                          resvalue = value;
                                        });
                                        Navigator.pop(context);
                                        return value;
                                      });
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text('Loading...'),
                                                CircularProgressIndicator()
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                      await result
                                          .confirm(otp.text)
                                          .then((v) async {
                                        // await v.user.updateProfile(
                                        //     photoURL: phone.text);
                                        // await v.user.reload();
                                        // print('Referal uid : $ref');

                                        var id = referal.text.toString() +
                                            phone.text.substring(3);
                                        var len = id.length;
                                        if (phoneexists) {
                                          print('phoneexists');
                                        } else {
                                          var userid = await FirebaseFirestore
                                              .instance
                                              .collection('Users')
                                              .doc('phone')
                                              .get()
                                              .then(
                                                (value) => value.get('user'),
                                              );
                                          print(userid);
                                          print(v.user.uid);
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(v.user.uid)
                                              .set({
                                            'parentid': ref,
                                            'uid': v.user.uid,
                                            'phone': phone.text,
                                            'level': len / 10,
                                            'id': id,
                                            'personalVolume': 0,
                                            'groupVolume': 0,
                                            'name': name.text,
                                            'address': address.text,
                                            'personalid': userid + 1,
                                            "searchindex":
                                                setSearchParam(phone.text),
                                          }).whenComplete(() =>
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc('phone')
                                                      .update({
                                                    'user':
                                                        FieldValue.increment(1),
                                                    'userphone':
                                                        FieldValue.arrayUnion(
                                                            [phone.text])
                                                  }));
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Home(
                                                phone: phone.text,
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                    }
                                  } catch (e) {
                                    _buildErrorDialog(context, e.message);
                                  }
                                }
                              }),
                        ),
                      ),
                      //password
                    ],
                  ),
                ),
              ),
            ),
    );
  }

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
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  setSearchParam(String refid) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < refid.length; i++) {
      temp = temp + refid[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }
}

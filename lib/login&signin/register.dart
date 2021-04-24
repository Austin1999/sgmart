import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgmart/login&signin/adminlogin.dart';
import 'package:sgmart/constants.dart';
import 'package:sgmart/screen/landing_page.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> formkey1 = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController(text: '+91');
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referal = TextEditingController();
  TextEditingController referalphone = TextEditingController();
  String refname;
  int ref;
  bool show = false;
  bool obscure = true;
  bool dataexit = false;

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

  String phoneValidator(String value) {
    Pattern pattern = r'^(\+\d{1,2})?\d{10}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter valid 10 Digt Number Phone Number';
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
                        "Let's get you set up",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        "Sign up with your credentials. \n It's easy and take less than 30 seconds",
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
                      key: formkey1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset('asset/sgmart.png'),
                            ),
                          ),
                          //Signup
                          Padding(
                              padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 20),
                              )),
                          //Name
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Please enter your Name' : null,
                              controller: name,
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  icon: Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ),
                          ),
                          //Phone
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                            child: TextFormField(
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
                          //Email
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
                              controller: email,
                              decoration: InputDecoration(
                                  hintText: "Enter your Email",
                                  icon: Icon(Icons.mail),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ),
                          ),
                          //password
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                            child: TextFormField(
                              validator: pwdValidator,
                              controller: password,
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
                                hintText: "Enter Password",
                                icon: Icon(Icons.lock_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),

                          //Address
                          Padding(
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
                          //referal
                          Padding(
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
                              validator: (value) => value.isEmpty
                                  ? 'Referal Field Must not be Empty'
                                  : null,
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
                                                  refname = document['name'];
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
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          //Button
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                            child: Container(
                              width: double.infinity,
                              child: FloatingActionButton.extended(
                                backgroundColor: Colors.green,
                                label: Text(
                                  "Create account",
                                  style: TextStyle(),
                                ),
                                onPressed: () {
                                  formkey1.currentState.save();
                                  if (formkey1.currentState.validate()) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('Loading...'),
                                              CircularProgressIndicator(
                                                backgroundColor: kPrimaryColor,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: email.text,
                                            password: password.text)
                                        .then((v) async {
                                      var id = referal.text.toString() +
                                          phone.text.substring(3);
                                      var len = id.length;
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
                                          .doc(phone.text)
                                          .set({
                                        'ref': referalphone.text,
                                        'refname': refname,
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
                                      }).whenComplete(() async {
                                        await FirebaseAuth.instance.currentUser
                                            .updateProfile(
                                                photoURL: phone.text);
                                        await FirebaseAuth.instance.currentUser
                                            .reload();
                                        await FirebaseFirestore.instance
                                            .collection('Users')
                                            .doc('phone')
                                            .update({
                                          'user': FieldValue.increment(1),
                                          'userphone': FieldValue.arrayUnion(
                                              [phone.text])
                                        });
                                      });
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(
                                            phone: phone.text,
                                          ),
                                        ),
                                      );
                                    });
                                    print('Text Editing Value ${referal.text}');
                                  }
                                },
                              ),
                            ),
                          ),
                          //Login page
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: Row(
                              children: [
                                Center(
                                  child: Text(
                                    "Already have an Account?",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 17,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AdminLogin(),
                                        ));
                                  },
                                )
                              ],
                            ),
                          ),
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              width: size.width,
              // height: size.height * .80,
              child: SingleChildScrollView(
                child: Form(
                  key: formkey1,
                  child: Column(
                    children: [
                      //Signup
                      Padding(
                          padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                          child: Text(
                            "Signup",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 20),
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 30,
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        ),
                      ),
                      //Name
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                        child: TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Please enter your Name' : null,
                          controller: name,
                          decoration: InputDecoration(
                              hintText: "Name",
                              icon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      //Phone
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.deny(
                              RegExp(r'[a-zA-Z]'),
                            ),
                          ],
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
                      //Email
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                          controller: email,
                          decoration: InputDecoration(
                              hintText: "Enter Email id",
                              icon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      //password
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                        child: TextFormField(
                          validator: pwdValidator,
                          controller: password,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            icon: Icon(Icons.visibility),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      //Address
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                        child: TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          validator: (val) =>
                              val.isEmpty ? 'Please enter your Address' : null,
                          controller: address,
                          decoration: InputDecoration(
                            hintText: "Enter Address",
                            icon: Icon(Icons.location_on),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      //referal
                      Padding(
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
                          controller: referal,
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
                              stream: (referal.text == null ||
                                      referal.text.trim() == '')
                                  ? FirebaseFirestore.instance
                                      .collection('Users')
                                      .limit(2)
                                      .snapshots()
                                  : FirebaseFirestore.instance
                                      .collection('Users')
                                      .where('searchindex',
                                          arrayContains: referal.text)
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
                                              referal.text = document['phone'];
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
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      //Button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                        child: Container(
                          width: double.infinity,
                          child: FloatingActionButton.extended(
                            backgroundColor: Colors.green,
                            label: Text(
                              "Create account",
                              style: TextStyle(),
                            ),
                            onPressed: () {
                              formkey1.currentState.save();
                              if (formkey1.currentState.validate()) {
                                formkey1.currentState.save();
                                if (formkey1.currentState.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('Loading...'),
                                            CircularProgressIndicator(
                                              backgroundColor: kPrimaryColor,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text)
                                      .then((v) async {
                                    var id = referal.text.toString() +
                                        phone.text.substring(3);
                                    var len = id.length;
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
                                        .doc(phone.text)
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
                                      "searchindex": setSearchParam(phone.text),
                                    }).whenComplete(() async {
                                      await FirebaseAuth.instance.currentUser
                                          .updateProfile(photoURL: phone.text);
                                      await FirebaseAuth.instance.currentUser
                                          .reload();
                                      await FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc('phone')
                                          .update({
                                        'user': FieldValue.increment(1),
                                        'userphone':
                                            FieldValue.arrayUnion([phone.text])
                                      });
                                    });
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(
                                          phone: phone.text,
                                        ),
                                      ),
                                    );
                                  });
                                  print('Text Editing Value ${referal.text}');
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      //Login page
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Center(
                              child: Text(
                                "Already have an Account?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            GestureDetector(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 17,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminLogin(),
                                    ));
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgmart/auth.dart';
import 'package:sgmart/responsive/actionbutton.dart';
import 'package:sgmart/responsive/constants.dart';

class SignUp extends StatefulWidget {
  final Function onLogInSelected;

  SignUp({@required this.onLogInSelected});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formkey1 = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referal = TextEditingController();
  bool show = false;
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
    if (value.length < 10) {
      return 'Invalid phone number';
    }
    // else if (dataexit) {
    //   return 'Phone Number already registered';
    // }
    else if (value.length == 10) {
      var str;
      FirebaseFirestore.instance.doc('Users/phone').get().then((value) {
        for (var i in value.get('numbers')) {
          if (i.toString() == phone.text) {
            print(i);
            setState(() {
              dataexit = true;
            });
          } else {
            setState(() {
              dataexit = false;
            });
          }
        }
      });
      if (dataexit) {
        return 'Mobile Number Exit';
      } else {
        // setState(() {
        //   dataexit = false;
        // });
        return null;
      }
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

    return Padding(
      padding: EdgeInsets.all(size.height > 770
          ? 64
          : size.height > 670
              ? 32
              : 16),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.8
                    : size.height > 670
                        ? 0.85
                        : 0.95),
            width: 500,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Form(
                    key: formkey1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SIGN UP",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
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
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Please enter your Name' : null,
                            controller: name,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 10,
                            // autovalidate: true,
                            keyboardType: TextInputType.phone,
                            validator: phoneValidator,
                            controller: phone,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_outlined),
                              hintText: 'phone',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            validator: (val) => val.isEmpty
                                ? 'Please enter your Address'
                                : null,
                            controller: address,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_on_outlined),
                              hintText: 'Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                            controller: email,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: pwdValidator,
                            controller: password,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              hintText: 'Passsword',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                              hintText: 'Referal Code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
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
                                                referal.text =
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
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: FloatingActionButton.extended(
                            backgroundColor: kPrimaryColor,
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
                                print('Text Editing Value ${referal.text}');
                                AuthService().signUp(
                                    name.text,
                                    password.text,
                                    email.text,
                                    phone.text,
                                    address.text,
                                    context,
                                    userreferal: (referal.text == null ||
                                            referal.text.trim() == '')
                                        ? null
                                        : referal.text);
                              }
                            },
                            label: Text('Create my account'),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onLogInSelected();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Log In",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  phoneauth(phoneNumber) {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (credential) async {
          await FirebaseAuth.instance.currentUser.updatePhoneNumber(credential);
          // either this occurs or the user needs to manually enter the SMS code
        },
        verificationFailed: null,
        codeSent: (verificationId, [forceResendingToken]) async {
          String smsCode;
          // get the SMS code from the user somehow (probably using a text field)
          final AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          await FirebaseAuth.instance.currentUser.updatePhoneNumber(credential);
        },
        codeAutoRetrievalTimeout: null);
  }
}

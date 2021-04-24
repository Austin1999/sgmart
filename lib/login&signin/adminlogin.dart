import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgmart/constants.dart';
import 'package:sgmart/login&signin/register.dart';
import 'package:sgmart/screen/landing_page.dart';

import 'login.dart';

class AdminLogin extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<AdminLogin> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController(text: '+91');
  bool obscure = true;

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
    if (value.length < 13) {
      return 'phone must be longer than 10 characters';
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
                      // Sgmart text
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
                        "Welcome Back! to SG Maligai",
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset('asset/sgmart.png'),
                            ),
                          ),
                          //Signup
                          Center(
                            child: Text(
                              "Signin",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
                            child: TextFormField(
                              obscureText: obscure,
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
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          //Button
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                            child: Container(
                              width: double.infinity,
                              child: FloatingActionButton.extended(
                                heroTag: 'btn1',
                                backgroundColor: Colors.green,
                                label: Text(
                                  "Login",
                                  style: TextStyle(),
                                ),
                                onPressed: () async {
                                  formkey.currentState.save();
                                  if (formkey.currentState.validate()) {
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
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: email.text,
                                              password: password.text)
                                          .then((v) async {
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
                                    } catch (e) {
                                      _buildErrorDialog(context, e.message);
                                    }
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
                                    "Don't have an Account?",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Register here",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 17,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Signup(),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: size.width * 0.20,
                                child: Divider(
                                  thickness: 2.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('OR'),
                              ),
                              SizedBox(
                                width: size.width * 0.20,
                                child: Divider(
                                  thickness: 2.0,
                                ),
                              ),
                            ],
                          ),

                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton.extended(
                                  icon: Icon(
                                    Icons.phone,
                                    color: kPrimaryColor,
                                  ),
                                  heroTag: 'btn2',
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  label: Text(
                                    'Continue with Phone',
                                    style: TextStyle(color: kPrimaryColor),
                                  )),
                            ),
                          )
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
                  key: formkey,
                  child: Column(
                    children: [
                      //Signup
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Image.asset('asset/sgmart.png'),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(40, 25, 40, 5),
                          child: Text(
                            "Signin",
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
                      //Phone

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
                              "Sign In",
                              style: TextStyle(),
                            ),
                            onPressed: () async {
                              formkey.currentState.save();
                              if (formkey.currentState.validate()) {
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
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text)
                                      .then((v) async {
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
                                } catch (e) {
                                  _buildErrorDialog(context, e.message);
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
                                "Register Here",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 17,
                                ),
                              ),
                              onTap: () {},
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
}

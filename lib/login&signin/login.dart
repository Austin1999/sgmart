import 'package:flutter/material.dart';
import 'package:sgmart/constants.dart';
import '../auth.dart';
import 'new_account.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                            child: TextFormField(
                              maxLength: 10,
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
                                    "Create account",
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
                                      await AuthService().signIn(
                                          email.text, password.text, context,
                                          phone: phone.text);
                                    }
                                  }),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Signup(),
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
                  key: formkey,
                  child: Column(
                    children: [
                      //Signup
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                        child: TextFormField(
                          maxLength: 10,
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
                              "Create account",
                              style: TextStyle(),
                            ),
                            onPressed: () {
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
                                          CircularProgressIndicator(
                                            backgroundColor: kPrimaryColor,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Signup(),
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
}

// Padding(
// padding: const EdgeInsets.fromLTRB(200, 25, 40, 20),
// child: Row(
// children: [
// Center(
// child: Text(
// "Already have an account?",
// style: TextStyle(color: Colors.grey),
// ),
// ),
// GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Login(),
// ));
// },
// child: Text(
// "Log In",
// style: TextStyle(color: Colors.green),
// ),
// )

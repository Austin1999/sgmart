import 'package:flutter/material.dart';
import 'package:sgmart/auth.dart';
import 'package:sgmart/responsive/actionbutton.dart';
import 'package:sgmart/responsive/constants.dart';

class LogIn extends StatefulWidget {
  final Function onSignUpSelected;

  LogIn({@required this.onSignUpSelected});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.height > 770
              ? 4
              : size.height > 670
                  ? 23
                  : 12,
          vertical: size.width > 770
              ? 40
              : size.height > 670
                  ? 23
                  : 12),
      child: Container(
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
                      ? 0.65
                      : size.height > 670
                          ? 0.75
                          : 0.85),
              width: 500,
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOG IN",
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
                            height: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) => val.isEmpty
                                  ? 'Please enter your Mobile Number'
                                  : null,
                              controller: phone,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'Phone',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
                              controller: email,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
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
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: FloatingActionButton.extended(
                              backgroundColor: kPrimaryColor,
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
                                            CircularProgressIndicator()
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  AuthService().signIn(
                                      email.text, password.text, context,
                                      phone: phone.text);
                                }
                              },
                              label: Text('SignIn'),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Dont't have an account?",
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
                                  widget.onSignUpSelected();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Sign Up",
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
      ),
    );
  }
}

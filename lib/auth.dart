import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgmart/home.dart';
import 'package:sgmart/main.dart';
import 'package:sgmart/responsive/constants.dart';

import 'admin/adminpage.dart';

class AuthService {
  // String username;
  // LoginPage usernme;
  // AuthService({this.username});
  User _user;
  String userphone;
  // AuthService({this.userphone});
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return snapshot.hasData
              ? snapshot.data.email == 'admin@maligai.com' &&
                      snapshot.data.uid == 'zKneFULSMyg54psRm6eW3EkBVfA3'
                  ? AdminPage()
                  : UserHomePage(
                      user: snapshot.data.photoURL,
                    )
              : HomePage();
        });
  }

  //Sign out
  signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = FirebaseAuth.instance.currentUser;
  }

  signIn(username, userpassword, context, {phone}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(phone)
          .get()
          .then((value) async {
        if (value.get('adminverified')) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: username, password: userpassword);
          await FirebaseAuth.instance.currentUser
              .updateProfile(photoURL: phone);
          //   .then((value) async {
          // Navigator.pop(context);
          // await FirebaseAuth.instance.currentUser
          //     .updateProfile(photoURL: phone);
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => value.user.email == 'admin@maligai.com'
          //         ? AdminPage()
          //         : HomePage(),
          //   ),
          // );
          // _user = value.user;
          // });
        } else {
          _buildErrorDialog(context, 'Admin Verification is under process');
        }
      });
    } on FirebaseAuthException catch (e) {
      _buildErrorDialog(context, e.message);
    }
  }

  signUp(username, userpassword, useremail, userphone, useraddress, context,
      {userreferal}) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userphone).set({
        'name': username,
        'email': useremail,
        'password': userpassword,
        'address': useraddress,
        'phone': userphone,
        'adminverified': false,
        'referel': [],
        "searchindex": [],
        // setSearchParam(value.user.uid)
      }).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
      // await value.user.updateProfile(photoURL: userphone);
      // _user = value.user;
      userreferal != null ??
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userreferal)
              .set(
            {
              'referel': FieldValue.arrayUnion([username])
            },
            SetOptions(merge: true),
          );
      await FirebaseFirestore.instance.collection('Users').doc('phone').set(
        {
          'numbers': FieldValue.arrayUnion([userphone])
        },
        SetOptions(merge: true),
      );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => UserHomePage(),
      //   ),
      // );
    } on FirebaseAuthException catch (e) {
      _buildErrorDialog(context, e.message);
    }
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

import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool isshow = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Now!'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Enter Your Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Enter Your Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: TextFormField(
              controller: phone,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Enter Your Phone'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  isshow = true;
                });
              },
              child: Text('Submit'),
            ),
          ),
          isshow
              ? Text('${name.text}, ${email.text}, ${phone.text}')
              : Container()
        ],
      ),
    );
  }
}

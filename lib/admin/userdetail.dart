import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgmart/constants.dart';

class UserDetail extends StatefulWidget {
  final DocumentSnapshot snapshot;
  UserDetail({this.snapshot});
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  TextEditingController add = TextEditingController();
  TextEditingController remove = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.snapshot.id)
          .collection('transactions')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 12.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  widget.snapshot.get('name'),
                                  style: TextStyle(fontSize: 18),
                                ),
                                Spacer(),
                                RichText(
                                  text: TextSpan(
                                    text: 'Personal Volume : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                        fontSize: 18),
                                    children: [
                                      TextSpan(
                                        text: widget.snapshot
                                            .get('personalVolume')
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.04,
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: 'Group Volume : ',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                        children: [
                                      TextSpan(
                                        text: widget.snapshot
                                            .get('groupVolume')
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17),
                                      )
                                    ]))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              widget.snapshot.get('phone'),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.04,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextFormField(
                                        cursorColor: Colors.green,
                                        controller: add,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'),
                                          ),
                                        ],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          hintText: "Add Amount",
                                        ),
                                      ),
                                    ),
                                    RaisedButton(
                                      color: Colors.green[700],
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Row(
                                                children: [
                                                  Text('Please Wait...'),
                                                  CircularProgressIndicator(),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                        await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(widget.snapshot.id)
                                            .collection('transactions')
                                            .add({
                                          'amount': int.parse(add.text),
                                          'date':
                                              DateTime.now().toIso8601String(),
                                          'credited': true,
                                        });

                                        await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(widget.snapshot.id)
                                            .update({
                                          'personalVolume':
                                              FieldValue.increment(
                                                  int.parse(add.text))
                                        }).whenComplete(() => showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.done,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          Text('Successful'),
                                                        ],
                                                      ),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Text(
                                                                '${add.text} Succesfully added to ${widget.snapshot.get('name')}'),
                                                          ),
                                                          RaisedButton(
                                                              color:
                                                                  kPrimaryColor,
                                                              child: Text(
                                                                'Ok',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                add.clear();
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ));
                                      },
                                      child: Text(
                                        'Add',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: TextFormField(
                                        cursorColor: Colors.green,
                                        controller: remove,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'),
                                          ),
                                        ],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          hintText: "Remove Amount",
                                        ),
                                      ),
                                    ),
                                    RaisedButton(
                                      color: Colors.red,
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Row(
                                                children: [
                                                  Text('Please Wait...'),
                                                  CircularProgressIndicator(),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                        await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(widget.snapshot.id)
                                            .collection('transactions')
                                            .add({
                                          'amount': int.parse(remove.text),
                                          'date':
                                              DateTime.now().toIso8601String(),
                                          'credited': false,
                                        });

                                        await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(widget.snapshot.id)
                                            .update({
                                          'personalVolume':
                                              FieldValue.increment(
                                                  -(int.parse(remove.text)))
                                        }).whenComplete(() => showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.done,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          Text('Successful'),
                                                        ],
                                                      ),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Text(
                                                                '${remove.text} Succesfully removed from ${widget.snapshot.get('name')}'),
                                                          ),
                                                          RaisedButton(
                                                              color:
                                                                  kPrimaryColor,
                                                              child: Text(
                                                                'Ok',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                remove.clear();
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ));
                                      },
                                      child: Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
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
                Text(
                  'Transaction Details',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: kPrimaryColor),
                ),
                Container(
                  child: Card(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: data.get('credited')
                                ? Colors.green
                                : Colors.red,
                            child: Icon(
                              data.get('credited')
                                  ? Icons.call_received
                                  : Icons.call_made,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            data.get('credited')
                                ? '+ ${data.get('amount').toString()}'
                                : '- ${data.get('amount').toString()}',
                            style: TextStyle(
                                color: data.get('credited')
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          subtitle: Text(
                            data.get('date').toString().substring(0, 10),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Row(
                                      children: [
                                        Text('Please Wait...'),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  );
                                },
                              );

                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(widget.snapshot.id)
                                  .update({
                                'personalVolume': data.get('credited')
                                    ? FieldValue.increment(
                                        -(data.get('amount')),
                                      )
                                    : FieldValue.increment(
                                        data.get('amount'),
                                      ),
                              }).whenComplete(() async {
                                await FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(widget.snapshot.id)
                                    .collection('transactions')
                                    .doc(data.id)
                                    .delete();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Icon(
                                            Icons.done,
                                            color: kPrimaryColor,
                                          ),
                                          Text('Successful'),
                                        ],
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                                '${remove.text} Succesfully removed from ${widget.snapshot.get('name')}'),
                                          ),
                                          RaisedButton(
                                              color: kPrimaryColor,
                                              child: Text(
                                                'Ok',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                remove.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              })
                                        ],
                                      ),
                                    );
                                  },
                                );
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    ));
  }
}

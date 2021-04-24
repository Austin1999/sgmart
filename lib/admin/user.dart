import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sgmart/admin/userdetail.dart';

import '../constants.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController commission = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'asset/sgmart.png',
          height: 82,
          width: 82,
        ),
      ),
      body: Container(
        //data fetching
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .orderBy('name')
              .snapshots(),
          builder: (_, snapshot) {
            //Before data display
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              //Gridview return card return listtile
              return GridView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (_, index) {
                    print(snapshot.data.docs[index].id);
                    return Card(
                      child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDetail(
                                      snapshot: snapshot.data.docs[index],
                                    ))),
                        leading: Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        title: Text(
                          snapshot.data.docs[index].get('name'),
                        ),
                        subtitle: Text(
                          snapshot.data.docs[index].get('phone'),
                        ),
                        // trailing: IconButton(
                        //   splashColor: Colors.green,
                        //   onPressed: () {
                        //     diaglog(snapshot.data.docs[index].id,
                        //         snapshot.data.docs[index].get("name"));
                        //   },
                        //   icon: Icon(
                        //     Icons.menu,
                        //     color: Colors.green,
                        //   ),
                        // ),
                      ),
                    );
                  },
                  //Size for Grid view
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 100,
                      crossAxisCount: (MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 2))
                          .round(),
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 2)));
            }
          },
        ),
      ),
    );
  }

  //commission
  diaglog(snapshot, name) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter stateSetter) {
            final size = MediaQuery.of(context).size;
            return Container(
              child: Dialog(
                  //shape for dialog box
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //payment
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Payment",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          //textfied
                          Container(
                            width: size.width / 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, bottom: 20, top: 20),
                              child: TextFormField(
                                cursorColor: Colors.green,
                                controller: commission,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "Purhase Amount",
                                ),
                              ),
                            ),
                          ),
                          //button
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 345.0, bottom: 18),
                            child: RaisedButton(
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
                                    .doc(snapshot)
                                    .collection('transactions')
                                    .add({
                                  'amount': int.parse(commission.text),
                                  'date': DateTime.now().toIso8601String(),
                                  'credited': true,
                                });

                                await FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(snapshot)
                                    .update({
                                      'personalVolume': FieldValue.increment(
                                          int.parse(commission.text))
                                    })
                                    .whenComplete(() => showDialog(
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                        '${commission.text} Succesfully added to $name'),
                                                  ),
                                                  RaisedButton(
                                                      color: kPrimaryColor,
                                                      child: Text(
                                                        'Ok',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      })
                                                ],
                                              ),
                                            );
                                          },
                                        ))
                                    .catchError(
                                        (error) => print(error.toString()));
                              },
                              child: Text(
                                "Add Amount",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            );
          });
        });
  }
}

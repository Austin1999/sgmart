import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class User_Detail extends StatefulWidget {
  @override
  _User_DetailState createState() => _User_DetailState();
}

class _User_DetailState extends State<User_Detail> {
  List<String> name = [];
  List<Widget> pname = [];

  Uri url;
  TextEditingController Commission = TextEditingController();
  TextEditingController pnamecon = TextEditingController();
  // String Commission;

  // Future getPost() async {
  //   var firestore = FirebaseFirestore.instance;
  //   QuerySnapshot qn = await firestore.collection('Users').where('name',isNotEqualTo: null).get();
  //
  //   return qn.docs;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Users')
              .orderBy('name')
              .get(),
          builder: (_, snapshot) {
            //Before data display
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text(
                  "Loading.....",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else {
              //Gridview return card return listtile
              return GridView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        title: Text(
                          snapshot.data.docs[index].get("name"),
                        ),
                        subtitle: Text(
                          snapshot.data.docs[index].get('phone'),
                        ),
                        trailing: IconButton(
                          splashColor: Colors.green,
                          onPressed: () {
                            diaglog(snapshot.data.docs[index].id);
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                  //Size for Grid view
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
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
  diaglog(snapshot) {
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
                          Row(
                            children: [
                              //textfiled
                              Container(
                                width: size.width / 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, bottom: 20, top: 20),
                                  child: TextFormField(
                                    cursorColor: Colors.green,
                                    controller: Commission,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      hintText: "Purhase",
                                    ),
                                  ),
                                ),
                              ),
                              //sized between text field and logo
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              //logo
                              Container(
                                child: Image.asset("asset/sgmart.png"),
                              )
                            ],
                          ),
                          //button
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 345.0, bottom: 18),
                            child: RaisedButton(
                              onPressed: () {
                                Map<String, dynamic> data = {
                                  "Commission": Commission.text,
                                };
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(snapshot)
                                    .update(data)
                                    .then((value) => displayDialog())
                                    .catchError(
                                        (error) => print("data not enter"));
                              },
                              child: Text(
                                "sent",
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

  // not working
  displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Alert"),
        content: new Text("Data Entered"),
        actions: [
          CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDefaultAction: true,
              child: new Text("Close"))
        ],
      ),
    );
  }
}

// onpressed(title, dname) {
//   final size = MediaQuery
//       .of(context)
//       .size;
//   showDialog(context: context, builder: (context) {
//     return StatefulBuilder(
//       builder: (BuildContext context, StateSetter stateSetter) {
//         return Dialog(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(
//                       title, style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                       maxLines: 1,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       width: size.width / 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8),
//                         child: TextFormField(
//                             controller: pnamecon,
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                     borderRadius:
//                                     BorderRadius.circular(12.0)),
//                                 hintText: 'Price')
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () =>
//                             uploadToStorage(
//                                 fileName: dname,
//                                 pathName: 'products/$dname',
//                                 updateState: stateSetter)),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: RaisedButton(
//                             color: Colors.green,
//                             onPressed: () async {
//                               print(Commission);
//                               name.add(pnamecon.text);
//                               Commission != null
//                                   ? name.add(Commission)
//                                   : print('Null Value');
//                               print('Controller : ${pnamecon.text}');
//                               print(name);
//                               await FirebaseFirestore.instance
//                                   .collection('Products')
//                                   .doc(dname)
//                                   .set(
//                                 {
//                                   '': FieldValue.arrayUnion(name),
//                                 },
//                                 SetOptions(merge: true),
//                               );
//                               name.clear();
//                               pname.clear();
//                               pnamecon.clear();
//                               setState(() {
//                                 Commission = null;
//                               });
//                               Navigator.of(context).pop();
//                             },
//                             child: Text(
//                               'Save',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         //Cancel button
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: RaisedButton(
//                             color: Colors.green,
//                             onPressed: () {
//                               name.clear();
//                               pname.clear();
//                               Navigator.of(context).pop();
//                             },
//                             child: Text(
//                               'Cancel',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   });
// }

//   uploadToStorage({fileName, String pathName, StateSetter updateState}) {}
//
//   updated(StateSetter updateState) {
//     updateState(() {
//       pname.add(
//         Expanded(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   onChanged: (value) {
//                     setState(() {
//                       Commission = value;
//                     });
//                   },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0)),
//                       hintText: 'Name'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//       setState(() {});
//     });
//   }
// }

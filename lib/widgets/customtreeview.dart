import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';

class CustomTreeView extends StatefulWidget {
  final AsyncSnapshot data;
  CustomTreeView({this.data});
  @override
  _CustomTreeViewState createState() => _CustomTreeViewState();
}

class _CustomTreeViewState extends State<CustomTreeView> {
  List<DataModel> da = [
    DataModel(
      id: 1,
      name: 'Root',
      parentId: -1,
      extras: {'key': 'extradata1'},
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlistData(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTreeView(
      width: MediaQuery.of(context).size.width * 0.95,
      data: da,
      onTap: (data) {
        da.forEach((element) {
          print(element.name);
          print(element.id);
          print(element.parentId);
        });
      },
      config: Config(
        parentTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        rootId: "1",
        parentPaddingEdgeInsets: EdgeInsets.only(left: 16, top: 0, bottom: 0),
      ),
    );
  }

  List<BaseData> getlistData(AsyncSnapshot snapshot) {
    return snapshot.data.docs.forEach((element) async {
      print(element.get('name'));
      await da.add(
        DataModel(
          id: (int.parse(element.get('personalid').toString()) + 1),
          parentId: snapshot.data.docs.length > 1
              ? (int.parse(element.get('parentid').toString()) + 1)
              : 1,
          name: element.get('name'),
        ),
      );
    });
  }
}

class DataModel implements BaseData {
  final int id;
  final int parentId;
  String name;

  ///Any extra data you want to get when tapped on children
  Map<String, dynamic> extras;
  DataModel({this.id, this.parentId, this.name, this.extras});
  @override
  String getId() {
    return this.id.toString();
  }

  @override
  Map<String, dynamic> getExtraData() {
    return this.extras;
  }

  @override
  String getParentId() {
    return this.parentId.toString();
  }

  @override
  String getTitle() {
    return this.name;
  }
}

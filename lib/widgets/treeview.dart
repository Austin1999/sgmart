import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TreeViewChild extends StatefulWidget {
  final docs;
  final VoidCallback onTap;

  TreeViewChild({
    this.docs,
    this.onTap,
    Key key,
  }) : super(key: key) {
    assert(docs != null);
  }

  @override
  TreeViewChildState createState() => TreeViewChildState();
}

class TreeViewChildState extends State<TreeViewChild> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.docs.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return i == 0
            ? GestureDetector(
                child: ListTile(
                    trailing: isExpanded
                        ? Icon(Icons.arrow_drop_up)
                        : Icon(Icons.arrow_drop_down),
                    title: Text(
                      widget.docs[i].get('name'),
                    ),
                    onTap: widget.onTap ??
                        () {
                          toggleExpanded();
                        }),
              )
            : isExpanded
                ? TreeChild(
                    docs: widget.docs,
                    i: i,
                    padding:
                        double.parse(widget.docs[i].get('level').toString()) +
                            20)
                : Container();
      },
    );
  }

  void toggleExpanded() {
    setState(() {
      this.isExpanded = !this.isExpanded;
    });
  }
}

class TreeChild extends StatefulWidget {
  final docs, i;
  final double padding;
  TreeChild({this.docs, this.i, this.padding});
  @override
  _TreeChildState createState() => _TreeChildState();
}

class _TreeChildState extends State<TreeChild> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(left: widget.padding),
          child: ListTile(
            trailing: widget.docs[widget.i].get('name') == 'Admin'
                ? Text('')
                : Text(
                    widget.docs[widget.i].get('personalVolume').toString(),
                  ),
            leading: CircleAvatar(
              maxRadius: MediaQuery.of(context).size.width * 0.01,
              backgroundColor: Colors.grey[300],
              child: Text(
                widget.docs[widget.i].get('level').toString(),
                style: TextStyle(color: Colors.black),
              ),
            ),
            title: Text(
              widget.docs[widget.i].get('name'),
            ),
          ),
        ),
      ),
    );
  }
}

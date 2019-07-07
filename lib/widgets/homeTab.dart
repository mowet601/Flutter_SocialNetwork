import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/databaseReferences.dart' as databaseReference;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'writeTab.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var containerHeight;
  var boxConstraint;
  FirebaseUser currentUser;
  bool showFull = false;
  IconData upIcon;
  IconData downIcon;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) => currentUser = user);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.border_color),
        backgroundColor: Colors.orange,
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WriteTab(),
              ),
            ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Flexible(
              child: streamBuilder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget streamBuilder() {
    return StreamBuilder<QuerySnapshot>(
        stream: databaseReference.DatabaseReferences()
            .postDatabaseReference
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            default:
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return new Container(
                      padding: EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                        top: 20.0,
                        bottom: 10.0,
                      ),
                      child: shortPostBody(snapshot.data.documents[index]),
                    );
                  });
              break;
          }
        });
  }

  FutureBuilder getUpIcon(String documentID) {
    List userIds;
    return new FutureBuilder(
      future: getUpvotedUserList(documentID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data['upvotedUsers'] != null) {
            userIds = snapshot.data['upvotedUsers'];
            if (userIds.contains(currentUser.uid))
              upIcon = EvaIcons.arrowCircleUp;
            else
              upIcon = EvaIcons.arrowCircleUpOutline;
          }
        }
        ;
        return Icon(
          upIcon,
          color: Colors.white,
          size: 18,
        );
      },
      initialData: Icon(
        EvaIcons.arrowCircleUpOutline,
        color: Colors.white,
        size: 18,
      ),
    );
  }

  Future<DocumentSnapshot> getUpvotedUserList(String documentID) {
    return databaseReference.DatabaseReferences()
        .postDatabaseReference
        .document(documentID)
        .get();
  }

  void upVote(String documentID) async {
    DocumentSnapshot snapshot = await getUpvotedUserList(documentID);
    List userIds = snapshot.data["upvotedUsers"];
    if (userIds.contains(currentUser.uid)) {
      databaseReference.DatabaseReferences()
          .postDatabaseReference
          .document(documentID)
          .updateData({
        "upvotes": FieldValue.increment(-1),
      });
    } else {
      databaseReference.DatabaseReferences()
          .postDatabaseReference
          .document(documentID)
          .updateData({
        "upvotes": FieldValue.increment(1),
      });
    }
  }

  void updateUpvotedUserList(String documentID) async {
    DocumentSnapshot snapshot = await getUpvotedUserList(documentID);
    List userIds = snapshot.data["upvotedUsers"];
    if (userIds.contains(currentUser.uid)) {
      databaseReference.DatabaseReferences()
          .postDatabaseReference
          .document(documentID)
          .updateData({
        "upvotedUsers": FieldValue.arrayRemove([currentUser.uid]),
      });
    } else {
      databaseReference.DatabaseReferences()
          .postDatabaseReference
          .document(documentID)
          .updateData({
        "upvotedUsers": FieldValue.arrayUnion([currentUser.uid]),
      });
    }
  }

  Widget shortPostBody(DocumentSnapshot snapshot) {
    containerHeight =
        showFull ? double.infinity : MediaQuery.of(context).size.width - 80;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: containerHeight,
            ),
            child: Text(
              snapshot.data['writeup'],
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.1,
                  height: 1.1,
                  fontSize: 18),
              textAlign: TextAlign.left,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          onTap: () {
            print("tap");
            setState(() {
              showFull = !showFull;
            });
          },
        ),
        Container(
          child: Text(
            DateFormat.yMMMd()
                .format(snapshot.data['createdAt'].toDate())
                .toString(),
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 14.0,
              height: 2.0,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                snapshot.data['name'],
                style: TextStyle(
                  color: Colors.green,
                  letterSpacing: 1.0,
                  fontSize: 14.0,
                  height: 2.0,
                ),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: getUpIcon(snapshot.documentID),
                    onTap: () => {
                          upVote(snapshot.documentID),
                          updateUpvotedUserList(snapshot.documentID),
                        },
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 18,
                    ),
                    onTap: () => showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new ListTile(
                                leading: new Icon(Icons.warning),
                                title: new Text('Report'),
                                onTap: () => print(""),
                              ),
                              new ListTile(
                                leading: new Icon(Icons.share),
                                title: new Text('Share'),
                                onTap: () => print(""),
                              ),
                            ],
                          );
                        }),
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            child: Divider(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

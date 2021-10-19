import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroceryListPage extends StatefulWidget {
  const GroceryListPage({Key? key}) : super(key: key);

  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Text("Return to login screen"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text("Load User ID's"),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Users')
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      print(doc["email"]);
                    });
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

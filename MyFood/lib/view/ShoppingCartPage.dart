import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfood/view//dbhelper.dart';

void main() async {
  runApp(const ShoppingCartPage());
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ShoppingList",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      home: const ShoppingCartPage(),
    );
  }

  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final textEditingController = TextEditingController();
  bool validated = true;
  String errorText = "";
  String todoEdited = "";
  Stream<QuerySnapshot>? dataList;

  @override
  void initState() {
    dataList = FirebaseFirestore.instance
        .collection("Users")
        .doc(user?.uid)
        .collection("Shopping List")
        .snapshots();

    super.initState();
  }

  User? user = FirebaseAuth.instance.currentUser;

  void showAlertDialog() {
    textEditingController.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Center(
                  child: const Text(
                "Add to Shoping List",
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: textEditingController,
                    autofocus: true,
                    onChanged: (_val) {
                      todoEdited = _val;
                    },
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Raleway",
                    ),
                    decoration: InputDecoration(
                      errorText: validated ? null : errorText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (textEditingController.text.isEmpty) {
                              setState(() {
                                errorText = "Can't Be Empty";
                                validated = false;
                              });
                            } else if (textEditingController.text.length >
                                512) {
                              setState(() {
                                errorText = "Too may Characters";
                                validated = false;
                              });
                            } else {
                              DatabaseHelper().createNewTask(
                                  textEditingController.text, user?.uid);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            //color: Colors.teal[50],
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Raleway",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: dataList,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasError)
            return Text('Error: ${asyncSnapshot.error}');

          switch (asyncSnapshot.connectionState) {
            case ConnectionState.none:
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 10.0,
                  centerTitle: true,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black54,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  title: const Text(
                    "Shopping List",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                backgroundColor: Colors.teal[50],
                body: const Center(
                  child: Text(
                    "No Items",
                    style: TextStyle(fontFamily: "Raleway", fontSize: 20.0),
                  ),
                ),
              );
            case ConnectionState.waiting:
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 10.0,
                  centerTitle: true,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black54,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  title: const Text(
                    "Shopping List",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                backgroundColor: Colors.teal[50],
                body: const Center(child: CircularProgressIndicator()),
              );
            case ConnectionState.active:
              int itemCount = asyncSnapshot.data!.docs.length;

              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 10.0,
                  centerTitle: true,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black54,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  title: const Text(
                    "Shopping List",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                backgroundColor: Colors.teal[50],
                body: itemCount > 0
                    ? ListView.builder(
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          DocumentSnapshot todo =
                              asyncSnapshot.data!.docs[index];
                          return Card(
                            elevation: 5.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                title: Text(
                                  todo["Food Item"],
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Raleway",
                                  ),
                                ),
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(user?.uid)
                                      .collection("Shopping List")
                                      .doc(todo.id)
                                      .delete()
                                      .then((_) => print('Deleted'))
                                      .catchError((error) =>
                                          print('Delete failed: $error'));
                                },
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('No items')),
                floatingActionButton: FloatingActionButton(
                  onPressed: showAlertDialog,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromRGBO(229, 115, 44, 1.0),
                ),
              );
            case ConnectionState.done:
              int itemCount = asyncSnapshot.data!.docs.length;

              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 10.0,
                  centerTitle: true,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black54,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  title: const Text(
                    "Shopping List",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                backgroundColor: Colors.teal[50],
                body: itemCount > 0
                    ? ListView.builder(
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          DocumentSnapshot todo =
                              asyncSnapshot.data!.docs[index];
                          return Card(
                            elevation: 5.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                title: Text(
                                  todo["Food Item"],
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Raleway",
                                  ),
                                ),
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(user?.uid)
                                      .collection("Shopping List")
                                      .doc(todo.id)
                                      .delete()
                                      .then((_) => print('Deleted'))
                                      .catchError((error) =>
                                          print('Delete failed: $error'));
                                },
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('No items')),
                floatingActionButton: FloatingActionButton(
                  onPressed: showAlertDialog,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromRGBO(229, 115, 44, 1.0),
                ),
              );
          }
        });
  }
}

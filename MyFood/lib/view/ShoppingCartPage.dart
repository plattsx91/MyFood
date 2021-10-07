import 'package:flutter/material.dart';
import 'package:myfood/view/dbhelper.dart';

void main() => runApp(ShoppingCartPage());

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Items",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.purple,
      ),
      home: itemsadded(),
    );
  }
}

class itemsadded extends StatefulWidget {
  @override
  _itemsaddedState createState() => _itemsaddedState();
}

class _itemsaddedState extends State<itemsadded> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  final dbhelper = Databasehelper.instance;

  final texteditingcontroller = TextEditingController();
  bool validated = true;
  String errtext = "";
  String itemsedited = "";
  var myitems = [];
  List<Widget> children = <Widget>[];

  void additems() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: itemsedited,
    };
    final id = await dbhelper.insert(row);
    print(id);
    Navigator.pop(context);
    itemsedited = "";
    setState(() {
      errtext = "";
    });
  }

  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add(Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            title: Text(
              row['todo'],
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "Raleway",
              ),
            ),
            onLongPress: () {
              dbhelper.deletedata(row['id']);
              setState(() {});
            },
          ),
        ),
      ));
    });
    return Future.value(true);
  }

  void showalertdialog() {
    texteditingcontroller.text = "";
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text(
                "Add Items",
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: texteditingcontroller,
                    autofocus: true,
                    onChanged: (_val) {
                      itemsedited = _val;
                    },
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Raleway",
                    ),
                    decoration: InputDecoration(
                      errorText: validated ? null : errtext,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            if (texteditingcontroller.text.isEmpty) {
                              setState(() {
                                errtext = "Can't Be Empty";
                              });
                            } else if (texteditingcontroller.text.length >
                                512) {
                              setState(() {
                                errtext = "Too may Characters";
                              });
                            } else {
                              additems();
                            }
                          },
                          color: Colors.blue,
                          child: Text("Add",
                              style: TextStyle(fontSize: 18.0, fontFamily: "Raleway",)
                          ),
                        )
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
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(
            child: Text(
              "No Data",
            ),
          );
        } else {
          if (myitems.length == 0) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: showalertdialog,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
              ),
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: Text(
                  "Shopping Cart",
                  style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.bold, color: Colors.black,),
                ),
              ),
              backgroundColor: Colors.white,
              body: Center(
                child: Text(
                  "No Food Available",
                  style: TextStyle(fontFamily: "Raleway", fontSize: 20.0, color: Colors.black),
                ),
              ),
            );
          } else {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: showalertdialog,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
              ),
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: Text(
                  "Shopping Cart",
                  style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.bold, color: Colors.black,),
                ),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}
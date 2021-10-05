import 'package:myfood/view/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        //constraints: BoxConstraints.expand(),
        ////Set background image
        //decoration: BoxDecoration(
        //    image: DecorationImage(
        //        image:
        //            AssetImage("assets/images/fridge_section_background.png"),
        //        fit: BoxFit.fill)),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            //Top of page
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Back button
                InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage())),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsets.only(
                            left: deviceWidth * .05, top: deviceHeight * .05),
                        width: deviceWidth * .15,
                        height: deviceHeight * .045,
                        child: Center(
                          child: Text(
                            "Back",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                //fontSize: deviceWidth * .03,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ))),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: const MyStatelessWidget(),
              ),
            ]),
            //Row with textbox and Add button
          ],
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: const SizedBox(
            width: 200,
            height: 100,
            child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
